import 'package:crypto_tracker/core/error/exceptions.dart';
import 'package:crypto_tracker/features/coin_detail/data/datasources/coin_detail_remote_datasource.dart';
import 'package:crypto_tracker/features/coin_detail/data/models/coin_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

Response<Map<String, dynamic>> _ok(Map<String, dynamic> body) =>
    Response<Map<String, dynamic>>(
      requestOptions: RequestOptions(path: '/coins/ethereum'),
      statusCode: 200,
      data: body,
    );

DioException _err(int code, {Object? data}) => DioException(
  requestOptions: RequestOptions(path: '/coins/ethereum'),
  response: Response<dynamic>(
    requestOptions: RequestOptions(path: '/coins/ethereum'),
    statusCode: code,
    data: data,
  ),
  type: DioExceptionType.badResponse,
);

void main() {
  late _MockDio dio;
  late CoinDetailRemoteDataSourceImpl source;

  setUp(() {
    dio = _MockDio();
    source = CoinDetailRemoteDataSourceImpl(dio);
  });

  test('GET /coins/{id} forwards the documented query params', () async {
    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer(
      (_) async => _ok(<String, dynamic>{
        'id': 'ethereum',
        'symbol': 'eth',
        'name': 'Ethereum',
      }),
    );

    await source.getCoinDetail('ethereum');

    final VerificationResult captured = verify(
      () => dio.get<Map<String, dynamic>>(
        'coins/ethereum',
        queryParameters: captureAny(named: 'queryParameters'),
      ),
    )..called(1);
    final Map<String, Object?> qp =
        captured.captured.single as Map<String, Object?>;
    expect(qp['localization'], isFalse);
    expect(qp['tickers'], isFalse);
    expect(qp['market_data'], isTrue);
    expect(qp['community_data'], isFalse);
    expect(qp['developer_data'], isFalse);
  });

  test('parses a 200 response into a CoinDetailModel', () async {
    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer(
      (_) async => _ok(<String, dynamic>{
        'id': 'ethereum',
        'symbol': 'eth',
        'name': 'Ethereum',
        'market_cap_rank': 2,
        'market_data': <String, dynamic>{
          'current_price': <String, dynamic>{'usd': 2095.85},
          'price_change_percentage_24h': -0.13,
        },
      }),
    );

    final CoinDetailModel model = await source.getCoinDetail('ethereum');

    expect(model.id, 'ethereum');
    expect(model.marketCapRank, 2);
    expect(model.marketData?.currentPrice['usd'], 2095.85);
  });

  test('wraps DioException as ServerException with body message', () async {
    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenThrow(
      _err(
        429,
        data: <String, dynamic>{
          'status': <String, dynamic>{
            'error_code': 429,
            'error_message': "You've exceeded the Rate Limit.",
          },
        },
      ),
    );

    Object? caught;
    try {
      await source.getCoinDetail('ethereum');
    } catch (e) {
      caught = e;
    }

    expect(caught, isA<ServerException>());
    expect((caught! as ServerException).message, contains('HTTP 429'));
    expect((caught as ServerException).message, contains('Rate Limit'));
  });
}
