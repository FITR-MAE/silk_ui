import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkTitle', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkTitle(text: 'My Title')),
        ),
      );

      expect(find.text('My Title'), findsOneWidget);
    });

    testWidgets('renders h1 level', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkTitle(text: 'H1 Title', scale: TitleScale.h1),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 32);
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('renders h2 level', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkTitle(text: 'H2 Title', scale: TitleScale.h2),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 24);
    });

    testWidgets('renders h3 level', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkTitle(text: 'H3 Title', scale: TitleScale.h3),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, SilkTypography.lg);
    });

    testWidgets('applies custom color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkTitle(text: 'Colored Title', color: Colors.red),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, Colors.red);
    });
  });
}
