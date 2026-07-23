import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void _noop() {}

BoxDecoration _buttonDecoration(WidgetTester tester) {
  final container = tester.widget<Container>(
    find
        .descendant(
          of: find.byType(SilkButton),
          matching: find.byType(Container),
        )
        .first,
  );
  return container.decoration as BoxDecoration;
}

void main() {
  group('SilkButton', () {
    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', onPressed: _noop),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkButton(
              label: 'Test Button',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SilkButton));
      await tester.pumpAndSettle();
      expect(pressed, true);
    });

    testWidgets('uses Material ink interaction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', onPressed: _noop),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('keeps compact buttons at least 44 by 44 pixels', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(
              label: 'Compact',
              scale: ButtonScale.xs,
              onPressed: _noop,
            ),
          ),
        ),
      );

      final size = tester.getSize(find.byType(SilkButton));
      expect(size.width, greaterThanOrEqualTo(44));
      expect(size.height, greaterThanOrEqualTo(44));
    });

    testWidgets('activates once with Enter and Space', (tester) async {
      var presses = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Activate', onPressed: () => presses++),
          ),
        ),
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(presses, 1);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(presses, 2);
    });

    testWidgets('uses scheme focus and hover overlays', (tester) async {
      final scheme = SilkColorScheme.light.copyWith(
        accent: Colors.green,
        ring: Colors.orange,
      );
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [scheme]),
          home: const Scaffold(
            body: SilkButton(label: 'Overlay', onPressed: _noop),
          ),
        ),
      );

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      expect(inkWell.focusColor, scheme.focusOverlay);
      expect(inkWell.hoverColor, scheme.hoverOverlay);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkButton(
              label: 'Test Button',
              onPressed: () => pressed = true,
              isDisabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SilkButton));
      expect(pressed, false);

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(pressed, false);

      final data = tester.getSemantics(find.bySemanticsLabel('Test Button'));
      expect(
        data.getSemanticsData().hasAction(ui.SemanticsAction.tap),
        isFalse,
      );
    });

    testWidgets('shows loading indicator when isLoading', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', isLoading: true),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });

    testWidgets('is flat by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', onPressed: _noop),
          ),
        ),
      );

      final decoration = _buttonDecoration(tester);
      expect(decoration.boxShadow, isEmpty);
    });

    testWidgets('applies shadow when requested', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', shadow: SilkShadow.md),
          ),
        ),
      );

      final decoration = _buttonDecoration(tester);
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow, isNotEmpty);
    });

    testWidgets('applies xs shadow when requested', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', shadow: SilkShadow.xs),
          ),
        ),
      );

      final decoration = _buttonDecoration(tester);
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow, isNotEmpty);
    });

    testWidgets('uses primary background for primary button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', onPressed: _noop),
          ),
        ),
      );

      final decoration = _buttonDecoration(tester);
      expect(decoration.color, SilkColors.primary);
    });

    testWidgets('uses muted background for secondary button in light theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(
              label: 'Test Button',
              variant: ButtonVariant.secondary,
              onPressed: _noop,
            ),
          ),
        ),
      );

      final decoration = _buttonDecoration(tester);
      expect(decoration.color, SilkColors.muted);
    });

    testWidgets(
      'uses dark muted background for secondary button in dark theme',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.dark,
            home: const Scaffold(
              body: SilkButton(
                label: 'Test Button',
                variant: ButtonVariant.secondary,
                onPressed: _noop,
              ),
            ),
          ),
        );

        final decoration = _buttonDecoration(tester);
        expect(decoration.color, SilkColorScheme.dark.muted);
      },
    );

    testWidgets('uses primary border for primary button in light theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', onPressed: _noop),
          ),
        ),
      );

      final decoration = _buttonDecoration(tester);
      final border = decoration.border as Border;
      expect(border.top.color, SilkColors.primary);
    });

    testWidgets('uses light border for primary button in dark theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: const Scaffold(
            body: SilkButton(label: 'Test Button', onPressed: _noop),
          ),
        ),
      );

      final decoration = _buttonDecoration(tester);
      final border = decoration.border as Border;
      expect(border.top.color, SilkColors.light);
    });

    testWidgets('uses light text for primary button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', onPressed: _noop),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Test Button'));
      expect(text.style?.color, SilkColors.primaryForeground);
    });

    testWidgets('uses theme-based text for alt button in light theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(
              label: 'Test Button',
              variant: ButtonVariant.alt,
              onPressed: _noop,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Test Button'));
      expect(text.style?.color, SilkColors.foreground);
    });

    testWidgets('uses theme-based text for alt button in dark theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: const Scaffold(
            body: SilkButton(
              label: 'Test Button',
              variant: ButtonVariant.alt,
              onPressed: _noop,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Test Button'));
      expect(text.style?.color, SilkColors.light);
    });

    testWidgets('renders all scales', (tester) async {
      for (final scale in ButtonScale.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SilkButton(label: 'Test', scale: scale),
            ),
          ),
        );
        expect(find.byType(SilkButton), findsOneWidget);
      }
    });

    testWidgets('renders all variants', (tester) async {
      for (final variant in ButtonVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SilkButton(label: 'Test', variant: variant),
            ),
          ),
        );
        expect(find.byType(SilkButton), findsOneWidget);
      }
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkButton(label: 'Unavailable')),
        ),
      );

      final semantics = tester.widget<Semantics>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Semantics && widget.properties.label == 'Unavailable',
        ),
      );
      expect(semantics.properties.label, 'Unavailable');
      expect(semantics.properties.button, isTrue);
      expect(semantics.properties.enabled, isFalse);
      expect(
        tester
            .widgetList<AnimatedOpacity>(find.byType(AnimatedOpacity))
            .singleWhere((widget) => widget.opacity == 0.5)
            .opacity,
        0.5,
      );
    });

    testWidgets('exposes one labeled button activation node', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(
              label: 'Save',
              semanticLabel: 'Save changes',
              tooltip: 'Save changes',
              onPressed: _noop,
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Save changes'), findsOneWidget);
      final data = tester.getSemantics(find.bySemanticsLabel('Save changes'));
      expect(data.flagsCollection.isButton, isTrue);
      expect(data.flagsCollection.isEnabled, ui.Tristate.isTrue);
      expect(data.getSemanticsData().hasAction(ui.SemanticsAction.tap), isTrue);
      handle.dispose();
    });
  });
}
