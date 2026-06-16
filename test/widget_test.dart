import 'package:crypto_tracker/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders Markets header inside ProviderScope', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: CryptoTrackerApp()),
    );

    expect(find.text('Markets'), findsOneWidget);
    expect(find.text('LIVE · COINGECKO'), findsOneWidget);
  });
}
