import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkImage', () {
    testWidgets('renders network image from URL', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkImage(src: 'https://example.com/image.png')),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders asset image', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SilkImage(src: 'assets/image.png')),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('applies borderRadius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkImage(
              src: 'https://example.com/image.png',
              borderRadius: 16,
            ),
          ),
        ),
      );

      expect(find.byType(ClipRRect), findsOneWidget);
    });

    testWidgets('applies width and height', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkImage(
              src: 'https://example.com/image.png',
              width: 200,
              height: 150,
            ),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.width, 200);
      expect(image.height, 150);
    });

    testWidgets('applies fit', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkImage(
              src: 'https://example.com/image.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.fit, BoxFit.contain);
    });
  });
}
