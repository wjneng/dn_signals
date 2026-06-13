// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:dn_signals/dn_signals.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('platform-specific id call does not throw', (
    WidgetTester tester,
  ) async {
    final clickId = await DnSignals.instance.getClickId();
    expect(clickId, anyOf(isNull, isA<String>()));
  });
}
