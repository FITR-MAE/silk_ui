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

    testWidgets('renders all sizes', (tester) async {
      for (final size in ButtonSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SilkIconButton(icon: PhosphorIcons.star(), size: size),
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
