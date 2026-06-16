import 'package:crypto_tracker/core/constants/api_constants.dart';
import 'package:crypto_tracker/core/error/exceptions.dart';
import 'package:crypto_tracker/features/market/data/datasources/market_remote_datasource.dart';
import 'package:crypto_tracker/features/market/data/models/coin_model.dart';
import 'package:crypto_tracker/features/market/data/models/global_market_model.dart';
import 'package:crypto_tracker/features/market/data/models/trending_coin_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

Response<T> _ok<T>(T body, {String path = '/x'}) => Response<T>(
  requestOptions: RequestOptions(path: path),
  statusCode: 200,
  data: body,
);

DioException _serverError({String path = '/x'}) => DioException(
  requestOptions: RequestOptions(path: path),
  response: Response<dynamic>(
    requestOptions: RequestOptions(path: path),
    statusCode: 500,
  ),
  type: DioExceptionType.badResponse,
);

void main() {
  late _MockDio dio;
  late MarketRemoteDataSourceImpl source;

  setUp(() {
    dio = _MockDio();
    source = MarketRemoteDataSourceImpl(dio);
  });

  group('getCoins', () {
    final List<Map<String, dynamic>> tBody = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'bitcoin',
        'symbol': 'btc',
        'name': 'Bitcoin',
        'image': 'https://example.com/btc.png',
        'current_price': 76764.0,
        'market_cap': 1540000000000,
        'market_cap_rank': 1,
        'price_change_percentage_24h': -0.52,
        'total_volume': 35000000000,
      },
    ];

    test('returns parsed CoinModels on 200', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _ok<List<dynamic>>(tBody));

      final List<CoinModel> result = await source.getCoins(page: 1);

      expect(result, hasLength(1));
      expect(result.first.id, 'bitcoin');
      expect(result.first.currentPrice, 76764.0);
    });

    test('forwards page and CoinGecko-required query params', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _ok<List<dynamic>>(<dynamic>[]));

      await source.getCoins(page: 3);

      final VerificationResult captured = verify(
        () => dio.get<List<dynamic>>(
          ApiConstants.coinsMarkets,
          queryParameters: captureAny(named: 'queryParameters'),
        ),
      )..called(1);
      final Map<String, Object?> qp =
          captured.captured.single as Map<String, Object?>;
      expect(qp['vs_currency'], ApiConstants.vsCurrency);
      expect(qp['order'], 'market_cap_desc');
      expect(qp['per_page'], ApiConstants.perPage);
      expect(qp['page'], 3);
    });

    test('wraps DioException as ServerException', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(_serverError(path: '/${ApiConstants.coinsMarkets}'));

      expect(
        () => source.getCoins(page: 1),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getGlobalMarket', () {
    test('unwraps the data envelope and parses', () async {
      final Map<String, dynamic> tBody = <String, dynamic>{
        'data': <String, dynamic>{
          'total_market_cap': <String, dynamic>{'usd': 2440000000000},
          'total_volume': <String, dynamic>{'usd': 93220000000},
          'market_cap_change_percentage_24h_usd': -0.42,
        },
      };
      when(
        () => dio.get<Map<String, dynamic>>(ApiConstants.global),
      ).thenAnswer((_) async => _ok<Map<String, dynamic>>(tBody));

      final GlobalMarketModel result = await source.getGlobalMarket();

      expect(result.totalMarketCap['usd'], 2440000000000);
      expect(result.marketCapChangePercentage24hUsd, -0.42);
    });

    test('wraps DioException as ServerException', () async {
      when(
        () => dio.get<Map<String, dynamic>>(ApiConstants.global),
      ).thenThrow(_serverError());

      expect(
        () => source.getGlobalMarket(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getTrendingCoins', () {
    test('flattens coins[].item entries into TrendingCoinModels', () async {
      final Map<String, dynamic> tBody = <String, dynamic>{
        'coins': <Map<String, dynamic>>[
          <String, dynamic>{
            'item': <String, dynamic>{
              'id': 'bonk',
              'name': 'Bonk',
              'symbol': 'BONK',
              'thumb': 'https://example.com/bonk.png',
              'market_cap_rank': 102,
              'data': <String, dynamic>{
                'price': 0.00000601,
                'price_change_percentage_24h': <String, dynamic>{
                  'usd': -1.36,
                },
              },
            },
          },
        ],
      };
      when(
        () => dio.get<Map<String, dynamic>>(ApiConstants.trending),
      ).thenAnswer((_) async => _ok<Map<String, dynamic>>(tBody));

      final List<TrendingCoinModel> result = await source.getTrendingCoins();

      expect(result, hasLength(1));
      expect(result.first.id, 'bonk');
      expect(result.first.data?.price, 0.00000601);
    });

    test('wraps DioException as ServerException', () async {
      when(
        () => dio.get<Map<String, dynamic>>(ApiConstants.trending),
      ).thenThrow(_serverError());

      expect(
        () => source.getTrendingCoins(),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
