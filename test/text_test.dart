import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkText', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkText(text: 'Hello World')),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('renders sm size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkText(text: 'Small Text', size: SilkTextSize.sm),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 12);
    });

    testWidgets('renders md size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkText(text: 'Medium Text', size: SilkTextSize.md),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 16);
    });

    testWidgets('renders lg size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkText(text: 'Large Text', size: SilkTextSize.lg),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, 20);
    });

    testWidgets('applies custom color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkText(text: 'Colored Text', color: Colors.blue),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, Colors.blue);
    });

    testWidgets('respects maxLines', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkText(
              text: 'Long text that should be truncated',
              maxLines: 1,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.maxLines, 1);
    });
  });

  group('SilkSpan', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkSpan(text: 'Hello')),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('applies italic style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkSpan(text: 'Italic Text', fontStyle: FontStyle.italic),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontStyle, FontStyle.italic);
    });

    testWidgets('applies bold weight', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkSpan(text: 'Bold Text', fontWeight: FontWeight.bold),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('applies underline', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkSpan(
              text: 'Underlined Text',
              textDecoration: TextDecoration.underline,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.decoration, TextDecoration.underline);
    });

    testWidgets('applies multiple styles', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkSpan(
              text: 'Styled Text',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              textDecoration: TextDecoration.underline,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontStyle, FontStyle.italic);
      expect(text.style?.fontWeight, FontWeight.bold);
      expect(text.style?.decoration, TextDecoration.underline);
    });
  });
}
