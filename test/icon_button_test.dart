import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void _noop() {}

BoxDecoration _iconButtonDecoration(WidgetTester tester) {
  final container = tester.widget<Container>(
    find
        .descendant(
          of: find.byType(SilkIconButton),
          matching: find.byType(Container),
        )
        .first,
  );
  return container.decoration as BoxDecoration;
}

void main() {
  group('SilkIconButton', () {
    testWidgets('renders with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(icon: Icons.star, label: 'Star'),
          ),
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
              icon: Icons.star,
              label: 'Star',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SilkIconButton));
      await tester.pumpAndSettle();
      expect(pressed, true);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: Icons.star,
              label: 'Star',
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
            body: SilkIconButton(
              icon: Icons.star,
              label: 'Star',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('is flat by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(icon: Icons.star, label: 'Star'),
          ),
        ),
      );

      final decoration = _iconButtonDecoration(tester);
      expect(decoration.boxShadow, isEmpty);
    });

    testWidgets('applies shadow when requested', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: Icons.star,
              label: 'Star',
              shadow: SilkShadow.md,
            ),
          ),
        ),
      );

      final decoration = _iconButtonDecoration(tester);
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow, isNotEmpty);
    });

    testWidgets('is square', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: Icons.star,
              label: 'Star',
              scale: ButtonScale.lg,
            ),
          ),
        ),
      );

      final size = tester.getSize(find.byType(SilkIconButton));
      expect(size.width, size.height);
      expect(size.width, closeTo(56, 1));
    });

    testWidgets('stays square while loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkIconButton(
              icon: Icons.star,
              label: 'Star',
              scale: ButtonScale.sm,
              isLoading: true,
            ),
          ),
        ),
      );

      final size = tester.getSize(find.byType(SilkIconButton));
      expect(size.width, size.height);
      expect(size.width, closeTo(36, 1));
    });

    testWidgets('renders all scales', (tester) async {
      for (final scale in ButtonScale.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SilkIconButton(
                icon: Icons.star,
                label: 'Star',
                scale: scale,
              ),
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
                icon: Icons.star,
                label: 'Star',
                variant: variant,
              ),
            ),
          ),
        );
        expect(find.byType(SilkIconButton), findsOneWidget);
      }
    });

    testWidgets('uses the theme foreground in dark mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: Scaffold(
            body: SilkIconButton(
              icon: Icons.star,
              label: 'Star',
              onPressed: _noop,
            ),
          ),
        ),
      );

      final iconContext = tester.element(find.byIcon(Icons.star));
      expect(
        IconTheme.of(iconContext).color,
        SilkColorScheme.dark.primaryForeground,
      );
    });
  });
}
