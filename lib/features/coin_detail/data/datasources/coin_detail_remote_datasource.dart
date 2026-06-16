import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/coin_detail_model.dart';

abstract interface class CoinDetailRemoteDataSource {
  Future<CoinDetailModel> getCoinDetail(String id);
}

class CoinDetailRemoteDataSourceImpl implements CoinDetailRemoteDataSource {
  const CoinDetailRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<CoinDetailModel> getCoinDetail(String id) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio
          .get<Map<String, dynamic>>(
            ApiConstants.coinDetail(id),
            queryParameters: const <String, Object?>{
              'localization': false,
              'tickers': false,
              'market_data': true,
              'community_data': false,
              'developer_data': false,
            },
          );
      final Map<String, dynamic> body =
          response.data ?? const <String, dynamic>{};
      return CoinDetailModel.fromJson(body);
    } on DioException catch (e) {
      throw ServerException(_describe(e));
    }
  }

  String _describe(DioException e) {
    final int? status = e.response?.statusCode;
    final String? bodyMessage = _extractMessage(e.response?.data);
    final String head = status != null
        ? 'HTTP $status'
        : (e.message ?? e.type.name);
    if (bodyMessage != null && bodyMessage.isNotEmpty) {
      return '$head · $bodyMessage';
    }
    return '$head on ${e.requestOptions.path}';
  }

  String? _extractMessage(Object? data) {
    if (data == null) {
      return null;
    }
    if (data is String) {
      return data.isEmpty ? null : data.trim();
    }
    if (data is Map<String, dynamic>) {
      final Object? status = data['status'];
      if (status is Map<String, dynamic>) {
        final Object? msg = status['error_message'];
        if (msg is String && msg.isNotEmpty) {
          return msg;
        }
      }
      final Object? err = data['error'];
      if (err is String && err.isNotEmpty) {
        return err;
      }
      final Object? msg = data['message'];
      if (msg is String && msg.isNotEmpty) {
        return msg;
      }
    }
    return null;
  }
}
