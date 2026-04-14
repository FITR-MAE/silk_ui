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
      expect(material.borderRadius, BorderRadius.circular(24));
    });

    testWidgets('applies elevation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkCard(elevation: 8, child: Text('Content'))),
        ),
      );

      expect(find.byType(SilkCard), findsOneWidget);
      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkCard),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, 8);
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
