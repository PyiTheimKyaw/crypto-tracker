import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/coin.dart';
import '../../domain/usecases/get_coins.dart';
import 'market_providers.dart';

@immutable
class CoinListState {
  const CoinListState({
    this.coins = const <Coin>[],
    this.page = 0,
    this.hasMore = true,
    this.query = '',
  });

  final List<Coin> coins;
  final int page;
  final bool hasMore;
  final String query;

  List<Coin> get filteredCoins {
    if (query.isEmpty) {
      return coins;
    }
    final String q = query.toLowerCase();
    return coins
        .where(
          (Coin c) =>
              c.name.toLowerCase().contains(q) ||
              c.symbol.toLowerCase().contains(q),
        )
        .toList(growable: false);
  }

  CoinListState copyWith({
    List<Coin>? coins,
    int? page,
    bool? hasMore,
    String? query,
  }) {
    return CoinListState(
      coins: coins ?? this.coins,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoinListState &&
          listEquals(other.coins, coins) &&
          other.page == page &&
          other.hasMore == hasMore &&
          other.query == query);

  @override
  int get hashCode => Object.hash(Object.hashAll(coins), page, hasMore, query);
}

class CoinListNotifier extends AsyncNotifier<CoinListState> {
  @override
  Future<CoinListState> build() async {
    final GetCoins getCoins = ref.read(getCoinsProvider);
    final Either<Failure, List<Coin>> result = await getCoins(page: 1);
    return result.fold(
      (Failure failure) => throw failure,
      (List<Coin> coins) => CoinListState(
        coins: coins,
        page: 1,
        hasMore: coins.length >= ApiConstants.perPage,
      ),
    );
  }

  Future<void> loadNextPage() async {
    final CoinListState? current = state.value;
    if (current == null || !current.hasMore || state.isLoading) {
      return;
    }

    final int nextPage = current.page + 1;
    final GetCoins getCoins = ref.read(getCoinsProvider);
    final Either<Failure, List<Coin>> result = await getCoins(page: nextPage);

    state = result.fold(
      (Failure failure) =>
          AsyncError<CoinListState>(failure, StackTrace.current),
      (List<Coin> newCoins) => AsyncData<CoinListState>(
        current.copyWith(
          coins: <Coin>[...current.coins, ...newCoins],
          page: nextPage,
          hasMore: newCoins.length >= ApiConstants.perPage,
        ),
      ),
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading<CoinListState>();
    state = await AsyncValue.guard<CoinListState>(build);
  }

  void search(String query) {
    final CoinListState? current = state.value;
    if (current == null) {
      return;
    }
    state = AsyncData<CoinListState>(current.copyWith(query: query));
  }
}

final AsyncNotifierProvider<CoinListNotifier, CoinListState> coinListProvider =
    AsyncNotifierProvider<CoinListNotifier, CoinListState>(
      CoinListNotifier.new,
    );
