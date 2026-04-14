import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkIconButton', () {
    testWidgets('renders with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SilkIconButton(icon: PhosphorIcons.star())),
        ),
      );

      expect(find.byType(SilkIcon), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: PhosphorIcons.star(),
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SilkIconButton));
      expect(pressed, true);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: PhosphorIcons.star(),
              onPressed: () => pressed = true,
              isDisabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SilkIconButton));
      expect(pressed, false);
    });

    testWidgets('shows loading indicator when isLoading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(icon: PhosphorIcons.star(), isLoading: true),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('is flat by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SilkIconButton(icon: PhosphorIcons.star())),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkIconButton),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, 0);
    });

    testWidgets('applies shadow when requested', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: PhosphorIcons.star(),
              shadow: SilkShadow.md,
            ),
          ),
        ),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SilkIconButton),
          matching: find.byType(Material),
        ),
      );
      expect(material.elevation, ShadowConfig.md.elevation);
    });

    testWidgets('is square', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: PhosphorIcons.star(),
              scale: ButtonScale.lg,
            ),
          ),
        ),
      );

      final size = tester.getSize(find.byType(SilkIconButton));
      expect(size.width, size.height);
      expect(size.width, 56);
    });

    testWidgets('stays square while loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: PhosphorIcons.star(),
              scale: ButtonScale.sm,
              isLoading: true,
            ),
          ),
        ),
      );

      final size = tester.getSize(find.byType(SilkIconButton));
      expect(size.width, size.height);
      expect(size.width, 36);
    });

    testWidgets('renders all scales', (tester) async {
      for (final scale in ButtonScale.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SilkIconButton(icon: PhosphorIcons.star(), scale: scale),
            ),
          ),
        );
        expect(find.byType(SilkIconButton), findsOneWidget);
      }
    });

    testWidgets('renders all variants', (tester) async {
      for (final variant in ButtonVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SilkIconButton(
                icon: PhosphorIcons.star(),
                variant: variant,
              ),
            ),
          ),
        );
        expect(find.byType(SilkIconButton), findsOneWidget);
      }
    });
  });
}
