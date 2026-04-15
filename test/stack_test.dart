import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkStack', () {
    testWidgets('renders children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkStack(children: [Text('One'), Text('Two')])),
        ),
      );

      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
    });

    testWidgets('defaults to vertical orientation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkStack(children: [Text('One'), Text('Two')])),
        ),
      );

      final flex = tester.widget<Flex>(find.byType(Flex));
      expect(flex.direction, Axis.vertical);
    });

    testWidgets('applies horizontal orientation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkStack(
              orientation: StackOrientation.horizontal,
              children: [Text('One'), Text('Two')],
            ),
          ),
        ),
      );

      final flex = tester.widget<Flex>(find.byType(Flex));
      expect(flex.direction, Axis.horizontal);
    });

    testWidgets('applies stack configuration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkStack(
              gap: StackGap.sm,
              orientation: StackOrientation.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [Text('One')],
            ),
          ),
        ),
      );

      final flex = tester.widget<Flex>(
        find.byWidgetPredicate((widget) {
          return widget is Flex &&
              widget.direction == Axis.horizontal &&
              widget.mainAxisAlignment == MainAxisAlignment.center;
        }),
      );
      expect(flex.crossAxisAlignment, CrossAxisAlignment.center);
      expect(flex.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('applies value presets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkStack(
              gap: StackGap.lg,
              children: [Text('One'), Text('Two')],
            ),
          ),
        ),
      );

      final spacing = tester.widget<SizedBox>(
        find.byWidgetPredicate((widget) {
          return widget is SizedBox && widget.height == SilkGap.lg;
        }),
      );
      expect(spacing.height, SilkGap.lg);
    });
  });
}
