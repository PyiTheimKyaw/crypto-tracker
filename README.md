# Crypto Tracker

A Flutter cryptocurrency tracker built against the CoinGecko v3 API. Two screens — a paginated, searchable market list and a per-coin detail page — with offline persistence, light/dark theming, English + Burmese localization (in-app switch + system follow-along), and an end-to-end test suite.



## Quick start

```bash
git clone <repo>
cd crypto-tracker

flutter pub get
flutter gen-l10n
dart run build_runner build
flutter run
```

If you ever see `*.freezed.dart` or `*.g.dart` red-lines after pulling, re-run `dart run build_runner build`. If localized strings disappear, re-run `flutter gen-l10n`.

### Requirements

- Flutter `3.44.2` stable (any 3.44.x should work; pinned in CI via `subosito/flutter-action@v2`)
- Dart `3.12+`
- For the Android APK: JDK 17 (Temurin)

### Useful commands

```bash
flutter analyze                              # zero issues expected
flutter test                                 # 112 unit + widget tests, all green
flutter test test/features/market/           # one feature
flutter build apk --debug                    # mirrors the CI APK build
```

## Compliance matrix

Every functional + technical requirement to a concrete code path.

### Functional

| Requirement                                                                      | Where it lives                                                                                                       |
|----------------------------------------------------------------------------------| -------------------------------------------------------------------------------------------------------------------- |
| Global market cap, trending coin, paginated list of cryptocurrencies with search | `GlobalMarketHeader`, `TrendingCarousel`, `MarketPage` + `CoinListNotifier`, `CoinSearchBar`                          |
| Infinite scroll pagination                                                       | `_MarketPageState._onScroll` → `coinListProvider.loadNextPage()` (240 px threshold, guarded by `paginationError`)     |
| Detail screen with comprehensive coin information                                | `CoinDetailPage` + `PriceHeader` + `MarketStatsGrid` + `AboutCoinSection`                                             |
| Mark / unmark favorites with local persistence                                   | `FavoritesRepositoryImpl` over `FavoritesLocalDataSourceImpl(Box<bool> favorites)`, exposed via `favoritesStreamProvider` |
| Pull to refresh                                                                  | `RefreshIndicator` on both `MarketPage` (`_onRefresh`) and `CoinDetailPage` (`ref.invalidate`)                         |
| Loading, error, empty states                                                     | `AsyncValue.when` everywhere + `MarketLoadingView` shimmer + `_ErrorView` + `_EmptyView` + inline pagination retry tail |
| Offline support (cache + display when no network)                                | Five Hive boxes; repository policy in `MarketRepositoryImpl` and `CoinDetailRepositoryImpl`; `OfflineBanner`           |
| Dark and light theme from system theme                                           | `MaterialApp.router(themeMode: ThemeMode.system)`, `AppTheme.light()` + `AppTheme.dark()`, `AppSemanticColors` extension |
| Language switching between native language and English                           | In-app picker (`showLanguagePicker` → `LanguagePickerSheet`) + `LocaleNotifier` persisted to `settings` Hive box; falls back to system locale when "System default" is chosen |

### Technical

| Requirement                                  | Implementation                                                                                                         |
|----------------------------------------------| ---------------------------------------------------------------------------------------------------------------------- |
| MVVM                                         | View = `ConsumerWidget`s; ViewModel = Riverpod notifiers/providers; Model = domain entities + use cases                 |
| State management                             | `flutter_riverpod` 3.x (`Provider`, `AsyncNotifier`, `FutureProvider.family`, `StreamProvider`, `Notifier`)             |
| Clean Architecture                           | Three layers per feature (`domain/`, `data/`, `presentation/`); dependencies point inward, abstract repos in `domain/`  |
| TDD or BDD                                   | TDD: Wrote use-case tests first (RED → GREEN approach); 112 total tests across 23 files    |
| REST API integration                         | `Dio` + `DioClient.create()` + `RetryInterceptor`; CoinGecko endpoints in `ApiConstants`; all four endpoints hit     |
| Database                                     | `hive_ce` (community fork of `hive`); six boxes opened in `initHive()`                                                  |
| Dependency Injection                         | Riverpod providers compose everything: `dioProvider → marketRemoteDataSourceProvider → marketRepositoryProvider → ...`  |
| Continuous integration pipeline (GH Actions) | `.github/workflows/ci.yml` with two jobs: `analyze-and-test` and `build-android-debug` (uploads APK artifact)           |

### API endpoints

| Endpoint                                                | Used by                                                              |
| ------------------------------------------------------- | -------------------------------------------------------------------- |
| `GET /coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page={page}` | `MarketRemoteDataSourceImpl.getCoins`                       |
| `GET /global`                                           | `MarketRemoteDataSourceImpl.getGlobalMarket`                          |
| `GET /search/trending`                                  | `MarketRemoteDataSourceImpl.getTrendingCoins`                         |
| `GET /coins/{id}?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false` | `CoinDetailRemoteDataSourceImpl.getCoinDetail` |

## Tech stack

| Concern             | Library                                          |
| ------------------- | ------------------------------------------------ |
| State management    | `flutter_riverpod` 3.x                           |
| Networking          | `dio` + custom retry interceptor                 |
| Models / codegen    | `freezed` + `json_serializable`                  |
| Local storage       | `hive_ce` + `hive_ce_flutter` + `hive_ce_generator` |
| Functional errors   | `fpdart` (`Either<Failure, T>`)                  |
| Routing             | `go_router`                                      |
| Connectivity        | `connectivity_plus`                              |
| Images              | `cached_network_image`                           |
| Localization        | Flutter's built-in `gen-l10n` + `flutter_localizations` |
| Testing             | `flutter_test` + `mocktail`                      |

The original plan called for `hive` + `hive_generator` and Riverpod codegen (`riverpod_annotation` / `riverpod_generator`), but on Dart 3.12 they pull analyzer versions that depend on a removed `_macros` SDK package. Swapped to the community fork (`hive_ce`) and dropped Riverpod codegen in favour of the manual `Provider` / `AsyncNotifier` API; the contract for users is unchanged.

## Architecture

Clean Architecture, three layers per feature, dependency arrows pointing inward. Each feature has the same shape:

```
features/<feature>/
  domain/
    entities/        # pure Dart, no codegen, value-equal
    repositories/    # abstract interfaces
    usecases/        # thin wrappers returning Future<Either<Failure, T>>
  data/
    models/          # Freezed + json_serializable; toEntity() extension
    datasources/     # remote (Dio) and local (Hive) — throw Server/CacheException
    repositories/    # impl: branches online/offline, converts exceptions → Failure
  presentation/
    providers/       # Riverpod DI + notifiers (the "viewmodel" layer)
    pages/           # ConsumerWidget pages
    widgets/         # presentation-only widgets
```

Cross-cutting code lives under `lib/core/`: `error/` (`Failure` sealed class + `Exception` types), `network/` (`DioClient`, `RetryInterceptor`, `NetworkInfo`), `cache/` (`hive_setup`), `theme/`, `l10n/`, `providers/` (incl. `locale_provider`), `utils/`, `widgets/` (offline banner, loading skeleton, language picker sheet).

### MVVM mapping

The presentation layer is MVVM in Riverpod's shape:

- **Model** — domain entities (`Coin`, `CoinDetail`, `GlobalMarket`, `TrendingCoin`) + use cases
- **View** — `ConsumerWidget`s (`MarketPage`, `CoinDetailPage`, the widget tree)
- **ViewModel** — Riverpod notifiers/providers (`CoinListNotifier`, `coinDetailProvider`, `globalMarketProvider`, `trendingProvider`, `favoritesStreamProvider`, `LocaleNotifier`)

The notifiers hold state, expose intents (`refresh`, `loadNextPage`, `search`, `toggleFavorite`, `setLocale`) and never construct concrete repositories — every dependency is `ref.watch(...)`ed.

### Why Riverpod

- Compile-time safe access (no `BuildContext` dependency for reading providers)
- Built-in `AsyncValue<T>` for loading/data/error state machines
- Trivially overridable in tests (`ProviderContainer(overrides: [...])`)
- `family` + `FutureProvider` for per-id resources (coin detail)
- `Stream<T>` providers compose cleanly with Hive's box-watch streams (favorites)

I considered `bloc` but the boilerplate didn't pay off for a two-screen app, and Riverpod's per-test container model meant pump tests didn't need a `Provider`/`MultiProvider` harness.

### Error model

`Failure` is a sealed class (`ServerFailure`, `CacheFailure`, `NetworkFailure`). Data sources throw raw `Exception` types (`ServerException`, `CacheException`); repositories catch and convert. Notifiers/use cases stay in `Either<Failure, T>` land. UI uses `AsyncValue.when(error: ...)` plus a `refreshError` / `paginationError` field on `CoinListState` so partial failures don't blow away already-loaded data.

## Caching & offline strategy

`initHive()` opens six boxes during `main()` boot:

| Box                    | Type            | Used for                                   |
| ---------------------- | --------------- | ------------------------------------------ |
| `coins_cache`          | `Box<String>`   | Page-1 market list (JSON-encoded)          |
| `global_market_cache`  | `Box<String>`   | Global market totals                       |
| `trending_cache`       | `Box<String>`   | Trending coins                             |
| `coin_detail_cache`    | `Box<String>`   | Per-id coin detail payloads                |
| `favorites`            | `Box<bool>`     | Presence-as-favorited keyed by coin id     |
| `settings`             | `Box<String>`   | App preferences (currently: chosen locale) |

Repository policy:

- **Online → fresh fetch.** Success caches the response and merges favourites; remote error returns `Left(ServerFailure)` (no silent cache fallback when network was working).
- **Offline + cache hit → `Right(cached)`** with favourites merged.
- **Offline + cache miss → `Left(NetworkFailure)`**.

Pagination caches page 1 only — higher pages are network-only because they trade memory for limited value when offline.

Refresh and pagination keep their data on screen on failure: `CoinListState` carries `refreshError` (surfaced via a SnackBar) and `paginationError` (surfaced via an inline retry row at the list tail). The full-screen error view only appears when the very first load fails with no cache to fall back on.

Rate-limit handling: the Dio `RetryInterceptor` retries `429`/`5xx` up to twice with exponential backoff capped at 5 seconds. If CoinGecko's `Retry-After` header asks for longer than 5s the interceptor fails fast so the user sees a retry button instead of a frozen UI.

## State surfaces

- `OfflineBanner` watches `connectivityStreamProvider` (emits initial state + `connectivity_plus` deltas) and slides in above the market list when offline.
- `MarketLoadingView` is a hand-rolled shimmer skeleton driven by a `SingleTickerProviderStateMixin` + `ShaderMask` — no external shimmer package.
- Both the coin list star and the detail page star read from one `favoritesStreamProvider` so toggling on either screen syncs both ways instantly without manual invalidation.
- `LocaleNotifier` reads the persisted locale code from the `settings` box on boot and writes back on every change; `MaterialApp.router(locale: ...)` re-renders the whole tree the moment the user picks a language.

## Testing approach

`flutter test` runs **112 tests** across 23 files covering:

- **Use cases** — TDD: tests written before the trivial delegation implementations
- **Data models** — JSON fixtures → `fromJson` → `toEntity` round-trips, defaults on missing keys
- **Data sources** — mocked `Dio` (success, error, query-param capture); mocked `Box<T>` (cache write/read, miss → `CacheException`)
- **Repositories** — every online/offline × cache-hit/miss × favourite-merge branch
- **Notifiers / providers** — `ProviderContainer` with mocked repos, state transitions, pagination, search filter, refresh, pagination-error / refresh-error preservation
- **Widget tests** — pump page with overridden providers, assert loading/data/error/empty states, star tap interactions
- **Retry interceptor** — custom `HttpClientAdapter` returning canned responses to verify the retry / backoff / fail-fast policy

All test fakes live in `test/helpers/market_mocks.dart` or co-located. No widget tests touch the real network, Hive, or platform channels.

## Localization

- ARB files: `lib/core/l10n/app_en.arb`, `app_my.arb` (Burmese)
- Generated to `lib/core/l10n/generated/`
- `MaterialApp` wires `AppLocalizations.localizationsDelegates` + `AppLocalizations.supportedLocales` + `locale: ref.watch(localeProvider)`
- Noto Sans Myanmar (variable font, `assets/fonts/NotoSansMyanmar-Variable.ttf`) is the `fontFamilyFallback` in the theme so Burmese glyphs render even when the primary font lacks them
- **In-app switcher** — tap the globe icon in the top-right of the market page → bottom sheet with **System default**, **English**, **မြန်မာ**. Choice persists to Hive (`settings` box, key `'locale'`); `null` falls back to the system locale.

## Continuous integration

`.github/workflows/ci.yml` runs on every push/PR to `main`/`develop` and on `workflow_dispatch`:

1. `analyze-and-test` — pub get → gen-l10n → build_runner → analyze → test
2. `build-android-debug` (gated by job 1 + push/manual trigger) — installs JDK 17, builds `flutter build apk --debug`, uploads the artifact for 14 days

Concurrency cancels stale runs on the same branch when a new commit lands.

## Project layout

```
.
├── .github/workflows/ci.yml            # GH Actions: analyze-and-test + APK build
├── assets/fonts/NotoSansMyanmar-Variable.ttf
├── lib/
│   ├── main.dart                       # boots Hive + ProviderScope + CryptoTrackerApp
│   ├── app.dart                        # MaterialApp.router with theme + l10n + locale override
│   ├── core/
│   │   ├── constants/api_constants.dart       # CoinGecko endpoints + per-page + timeouts
│   │   ├── error/{failure,exceptions}.dart
│   │   ├── network/{dio_client,network_info,retry_interceptor}.dart
│   │   ├── cache/hive_setup.dart              # initHive() opens 6 boxes
│   │   ├── theme/{app_colors,app_text_styles,app_theme}.dart
│   │   ├── l10n/{app_en,app_my}.arb + generated/
│   │   ├── providers/
│   │   │   ├── core_providers.dart            # dioProvider, networkInfo, box providers, connectivityStreamProvider
│   │   │   └── locale_provider.dart           # LocaleNotifier persisted to settings box
│   │   ├── utils/formatters.dart              # price / compact currency / percent / supply / compact number
│   │   └── widgets/
│   │       ├── offline_banner.dart
│   │       ├── loading_view.dart              # ShimmerBox + MarketLoadingView
│   │       └── language_picker_sheet.dart     # bottom sheet: System default / English / မြန်မာ
│   ├── features/
│   │   ├── market/{domain,data,presentation}
│   │   ├── coin_detail/{domain,data,presentation}
│   │   └── favorites/{domain,data,presentation}
│   └── routing/app_router.dart                # GoRouter with /, /coin/:id
└── test/                               # 112 tests across 23 files
```

## Known limitations / future improvements

- **Database engine.** Hive is great for JSON-blob caching; for richer indexed queries (sort favorites by date added, search across all cached coins) [Drift](https://drift.simonbinder.eu) would be the obvious upgrade.
- **API contract drift.** No [Pact](https://pact.io) tests today — only handwritten JSON fixtures. If CoinGecko shifts a field, the model defaults will silently swallow it. Pact would catch that against a recorded contract.
- **Animations.** Theme/locale switches are instant; star toggle is a state flip with no scale/bounce; nav transitions are go_router defaults. Each is room for polish.
- **Deep linking.** `/coin/:id` is registered with go_router but the iOS Universal Link / Android App Link config isn't wired. Adding platform configs would enable shareable URLs.
- **Search UX.** Current search filters only the already-loaded coins client-side because CoinGecko's `/coins/markets` has no `q` parameter. A real server-side search would hit `/search?query=` and merge results.
- **Favorites scope.** Favorites live in Hive only — no remote sync, no per-account scope.
- **Detail page polish.** Sparkline chart from CoinGecko's `sparkline_in_7d` would fit nicely above MARKET STATS.
- **L10n quality.** Burmese strings are reasonable working translations, not native-quality copy. A speaker should review before shipping.

## License

MIT — see `LICENSE` if/when added. The CoinGecko API is free and key-less but their terms (https://www.coingecko.com/en/api/pricing) apply to usage.
