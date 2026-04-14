import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkCard', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkCard(child: Text('Card Content'))),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('applies padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkCard(padding: EdgeInsets.all(32), child: Text('Content')),
          ),
        ),
      );

      expect(find.byType(SilkCard), findsOneWidget);
      final paddingWidget = tester.widget<Padding>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Padding),
        ),
      );
      expect(paddingWidget.padding, const EdgeInsets.all(32));
    });

    testWidgets('applies custom borderRadius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkCard(
              borderRadius: 24,
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      expect(find.byType(SilkCard), findsOneWidget);
      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      final shape = material.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, BorderRadius.circular(24));
    });

    testWidgets('is flat by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkCard(child: Text('Content'))),
        ),
      );

      expect(find.byType(SilkCard), findsOneWidget);
      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, 0);
    });

    testWidgets('applies shadow when requested', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkCard(shadow: SilkShadow.md, child: Text('Content')),
          ),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, ShadowConfig.md.elevation);
    });

    testWidgets('uses transparent background for secondary card', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkCard(variant: CardVariant.secondary, child: Text('Card')),
          ),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      expect(material.color, Colors.transparent);
    });

    testWidgets('uses grey background for secondary card in dark theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: const Scaffold(
            body: SilkCard(variant: CardVariant.secondary, child: Text('Card')),
          ),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      expect(material.color, SilkColors.grey);
    });

    testWidgets('uses dark border for card in light theme', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkCard(child: Text('Card'))),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      final shape = material.shape as RoundedRectangleBorder;
      expect(shape.side.color, SilkColors.dark);
    });

    testWidgets('uses light border for card in dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: const Scaffold(body: SilkCard(child: Text('Card'))),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      final shape = material.shape as RoundedRectangleBorder;
      expect(shape.side.color, SilkColors.light);
    });

    testWidgets('applies backgroundColor', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkCard(backgroundColor: Colors.red, child: Text('Content')),
          ),
        ),
      );

      expect(find.byType(SilkCard), findsOneWidget);
      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      expect(material.color, Colors.red);
    });
  });
}
