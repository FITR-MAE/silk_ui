import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkBadge', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkBadge(label: 'New')),
        ),
      );

      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('uses destructive background', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkBadge(label: 'Delete', variant: BadgeVariant.destructive),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, SilkColors.destructive);
    });

    testWidgets('uses round radius when isPill is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkBadge(label: 'Live', isPill: true)),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.borderRadius,
        BorderRadius.circular(SilkBorder.radiusRound),
      );
    });

    testWidgets('uses a contrasting success foreground', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const Scaffold(
            body: SilkBadge(label: 'Ready', variant: BadgeVariant.success),
          ),
        ),
      );

      final label = tester.widget<Text>(find.text('Ready'));
      expect(label.style?.color, SilkColorScheme.dark.successForeground);
    });
  });
}
