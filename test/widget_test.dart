import 'package:crypto_tracker/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App skeleton renders inside ProviderScope', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: CryptoTrackerApp()),
    );

    expect(find.text('Crypto Tracker — skeleton'), findsOneWidget);
  });
}
