import 'package:flutter_test/flutter_test.dart';

import 'package:app_am_nhac/main.dart';

void main() {
  testWidgets('Music App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MusicApp());

    expect(find.text('SoundPulse'), findsOneWidget);
  });
}