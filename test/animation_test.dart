import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  testWidgets('fade-in ignores taps while invisible', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: SilkFadeIn(
          delay: const Duration(seconds: 1),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => taps++,
            child: const SizedBox(width: 100, height: 100),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SizedBox), warnIfMissed: false);
    expect(taps, 0);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(SizedBox), warnIfMissed: false);
    expect(taps, 1);
  });

  testWidgets('slide-in applies its curve', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SilkSlideIn(
          duration: Duration(seconds: 1),
          curve: Threshold(0.75),
          child: SizedBox(width: 100, height: 100),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));
    final transform = tester.widget<Transform>(find.byType(Transform));
    expect(transform.transform.getTranslation().y, 24);
  });
}
