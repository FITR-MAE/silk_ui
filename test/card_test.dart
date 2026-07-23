import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    testWidgets('tappable card supports semantics, keyboard, and overlays', (
      tester,
    ) async {
      var taps = 0;
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Center(
              child: SilkCard(
                semanticLabel: 'Open collection',
                tooltip: 'Open collection',
                padding: EdgeInsets.zero,
                onTap: () => taps++,
                child: const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );

      final data = tester.getSemantics(
        find.bySemanticsLabel('Open collection'),
      );
      expect(data.label, 'Open collection');
      expect(data.flagsCollection.isButton, isTrue);
      expect(data.flagsCollection.isEnabled, ui.Tristate.isTrue);
      expect(data.getSemanticsData().hasAction(ui.SemanticsAction.tap), isTrue);
      final target = tester.getSize(find.byType(InkWell));
      expect(target.width, greaterThanOrEqualTo(44));
      expect(target.height, greaterThanOrEqualTo(44));
      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      expect(inkWell.focusColor, SilkColorScheme.light.focusOverlay);
      expect(inkWell.hoverColor, SilkColorScheme.light.hoverOverlay);

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(taps, 2);
      handle.dispose();
    });

    testWidgets('non-tappable card has no interaction node', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkCard(child: Text('Static card'))),
        ),
      );

      expect(find.byType(InkWell), findsNothing);
      final data = tester.getSemantics(find.byType(SilkCard));
      expect(data.flagsCollection.isButton, isFalse);
      expect(
        data.getSemanticsData().hasAction(ui.SemanticsAction.tap),
        isFalse,
      );
    });
  });
}
