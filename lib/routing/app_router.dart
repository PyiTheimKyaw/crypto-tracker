import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/coin_detail/presentation/pages/coin_detail_page.dart';
import '../features/market/presentation/pages/market_page.dart';

class AppRoutes {
  const AppRoutes._();

  static const String market = '/';
  static const String coinDetail = '/coin/:id';

  static String coinDetailPath(String id) => '/coin/$id';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.market,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.market,
      name: 'market',
      builder: (BuildContext context, GoRouterState state) =>
          const MarketPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'coin/:id',
          name: 'coinDetail',
          builder: (BuildContext context, GoRouterState state) {
            final String id = state.pathParameters['id'] ?? '';
            return CoinDetailPage(id: id);
          },
        ),
      ],
    ),
  ],
);
