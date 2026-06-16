import 'dart:convert';

import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../models/coin_detail_model.dart';

abstract interface class CoinDetailLocalDataSource {
  Future<CoinDetailModel> getCached(String id);

  Future<void> cache(String id, CoinDetailModel model);
}

class CoinDetailLocalDataSourceImpl implements CoinDetailLocalDataSource {
  const CoinDetailLocalDataSourceImpl(this.box);

  final Box<String> box;

  @override
  Future<CoinDetailModel> getCached(String id) async {
    final String? raw = box.get(id);
    if (raw == null) {
      throw CacheException('No cached detail for $id');
    }
    final Map<String, dynamic> decoded =
        jsonDecode(raw) as Map<String, dynamic>;
    return CoinDetailModel.fromJson(decoded);
  }

  @override
  Future<void> cache(String id, CoinDetailModel model) async {
    await box.put(id, jsonEncode(model.toJson()));
  }
}
