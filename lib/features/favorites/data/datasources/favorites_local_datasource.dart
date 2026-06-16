import 'package:hive_ce_flutter/hive_ce_flutter.dart';

abstract interface class FavoritesLocalDataSource {
  Set<String> getFavoriteIds();

  bool isFavorite(String id);

  Future<void> add(String id);

  Future<void> remove(String id);

  Stream<Set<String>> watch();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  const FavoritesLocalDataSourceImpl(this.box);

  final Box<bool> box;

  @override
  Set<String> getFavoriteIds() => box.keys.whereType<String>().toSet();

  @override
  bool isFavorite(String id) => box.containsKey(id);

  @override
  Future<void> add(String id) => box.put(id, true);

  @override
  Future<void> remove(String id) => box.delete(id);

  @override
  Stream<Set<String>> watch() => box.watch().map((_) => getFavoriteIds());
}
