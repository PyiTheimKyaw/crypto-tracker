import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/coin_model.dart';
import '../models/global_market_model.dart';
import '../models/trending_coin_model.dart';

abstract interface class MarketRemoteDataSource {
  Future<List<CoinModel>> getCoins({required int page});

  Future<GlobalMarketModel> getGlobalMarket();

  Future<List<TrendingCoinModel>> getTrendingCoins();
}

class MarketRemoteDataSourceImpl implements MarketRemoteDataSource {
  const MarketRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<CoinModel>> getCoins({required int page}) async {
    try {
      final Response<List<dynamic>> response = await _dio.get<List<dynamic>>(
        ApiConstants.coinsMarkets,
        queryParameters: <String, Object?>{
          'vs_currency': ApiConstants.vsCurrency,
          'order': 'market_cap_desc',
          'per_page': ApiConstants.perPage,
          'page': page,
        },
      );
      final List<dynamic> body =
          response.data ?? const <Map<String, dynamic>>[];
      return body
          .map<CoinModel>(
            (dynamic e) => CoinModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw ServerException(_describe(e));
    }
  }

  @override
  Future<GlobalMarketModel> getGlobalMarket() async {
    try {
      final Response<Map<String, dynamic>> response = await _dio
          .get<Map<String, dynamic>>(ApiConstants.global);
      final Map<String, dynamic> body = response.data ?? const <String, dynamic>{};
      final Map<String, dynamic> data =
          (body['data'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
      return GlobalMarketModel.fromJson(data);
    } on DioException catch (e) {
      throw ServerException(_describe(e));
    }
  }

  @override
  Future<List<TrendingCoinModel>> getTrendingCoins() async {
    try {
      final Response<Map<String, dynamic>> response = await _dio
          .get<Map<String, dynamic>>(ApiConstants.trending);
      final Map<String, dynamic> body =
          response.data ?? const <String, dynamic>{};
      final List<dynamic> coins =
          (body['coins'] as List<dynamic>?) ?? const <dynamic>[];
      return coins
          .map<TrendingCoinModel>(
            (dynamic c) => TrendingCoinModel.fromJson(
              (c as Map<String, dynamic>)['item'] as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw ServerException(_describe(e));
    }
  }

  String _describe(DioException e) {
    final int? status = e.response?.statusCode;
    if (status != null) {
      return 'HTTP $status on ${e.requestOptions.path}';
    }
    return e.message ?? e.type.name;
  }
}
