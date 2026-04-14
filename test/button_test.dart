import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkButton', () {
    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkButton(label: 'Test Button')),
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
      expect(pressed, true);
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
          home: Scaffold(body: SilkButton(label: 'Test Button')),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkButton),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, 0);
    });

    testWidgets('applies shadow when requested', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', shadow: SilkShadow.md),
          ),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkButton),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, ShadowConfig.md.elevation);
    });

    testWidgets('applies xs shadow when requested', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', shadow: SilkShadow.xs),
          ),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkButton),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, ShadowConfig.xs.elevation);
    });

    testWidgets('uses dark background for primary button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkButton(label: 'Test Button')),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkButton),
          matching: find.byType(Material),
        ),
      );
      expect(material.color, SilkColors.dark);
    });

    testWidgets(
      'uses transparent background for secondary button in light theme',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SilkButton(
                label: 'Test Button',
                variant: ButtonVariant.secondary,
              ),
            ),
          ),
        );

        final material = tester.widget<Material>(
          find.descendant(
            of: find.byType(SilkButton),
            matching: find.byType(Material),
          ),
        );
        expect(material.color, Colors.transparent);
      },
    );

    testWidgets('uses grey background for secondary button in dark theme', (
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
              variant: ButtonVariant.secondary,
            ),
          ),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkButton),
          matching: find.byType(Material),
        ),
      );
      expect(material.color, SilkColors.grey);
    });

    testWidgets('uses dark border for primary button in light theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkButton(label: 'Test Button')),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SilkButton),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, SilkColors.dark);
    });

    testWidgets('uses dark border for primary button in dark theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: const Scaffold(body: SilkButton(label: 'Test Button')),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SilkButton),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, SilkColors.dark);
    });

    testWidgets('uses light text for primary button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkButton(label: 'Test Button')),
        ),
      );

      final text = tester.widget<Text>(find.text('Test Button'));
      expect(text.style?.color, SilkColors.light);
    });

    testWidgets('uses theme-based text for alt button in light theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkButton(label: 'Test Button', variant: ButtonVariant.alt),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Test Button'));
      expect(text.style?.color, SilkColors.dark);
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
            body: SilkButton(label: 'Test Button', variant: ButtonVariant.alt),
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
  });
}
