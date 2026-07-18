import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

BoxDecoration _cardDecoration(WidgetTester tester) {
  final decoratedBox = tester.widget<DecoratedBox>(
    find
        .descendant(
          of: find.byType(SilkCard),
          matching: find.byType(DecoratedBox),
        )
        .first,
  );
  return decoratedBox.decoration as BoxDecoration;
}

Material _cardMaterial(WidgetTester tester) {
  return tester.widget<Material>(
    find.descendant(of: find.byType(SilkCard), matching: find.byType(Material)),
  );
}

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
      final paddingFinder = find.descendant(
        of: find.byType(SilkCard),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Padding && widget.padding == const EdgeInsets.all(32),
        ),
      );
      expect(paddingFinder, findsOneWidget);
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
      final shape = _cardMaterial(tester).shape as RoundedRectangleBorder;
      expect(shape.borderRadius, BorderRadius.circular(24));
    });

    testWidgets('is flat by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkCard(child: Text('Content'))),
        ),
      );

      expect(find.byType(SilkCard), findsOneWidget);
      final decoration = _cardDecoration(tester);
      expect(decoration.boxShadow, isEmpty);
    });

    testWidgets('applies shadow when requested', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkCard(shadow: SilkShadow.md, child: Text('Content')),
          ),
        ),
      );

      final decoration = _cardDecoration(tester);
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow, isNotEmpty);
    });

    testWidgets('uses card background for primary card', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkCard(child: Text('Card'))),
        ),
      );

      expect(_cardMaterial(tester).color, SilkColors.card);
    });

    testWidgets('uses muted background for secondary card in light theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkCard(variant: CardVariant.secondary, child: Text('Card')),
          ),
        ),
      );

      expect(_cardMaterial(tester).color, SilkColors.muted);
    });

    testWidgets('uses dark muted background for secondary card in dark theme', (
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

      expect(_cardMaterial(tester).color, SilkColorScheme.dark.muted);
    });

    testWidgets('uses border for card in light theme', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkCard(child: Text('Card'))),
        ),
      );

      final shape = _cardMaterial(tester).shape as RoundedRectangleBorder;
      expect(shape.side.color, SilkColors.border);
    });

    testWidgets('uses dark border for card in dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: const Scaffold(body: SilkCard(child: Text('Card'))),
        ),
      );

      final shape = _cardMaterial(tester).shape as RoundedRectangleBorder;
      expect(shape.side.color, SilkColorScheme.dark.border);
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
      expect(_cardMaterial(tester).color, Colors.red);
    });

    testWidgets('clips content and exposes ink feedback when tappable', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkCard(
              onTap: () {},
              child: const ColoredBox(color: Colors.red),
            ),
          ),
        ),
      );

      expect(_cardMaterial(tester).clipBehavior, Clip.antiAlias);
      expect(find.byType(InkWell), findsOneWidget);
    });
  });
}
