import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkCamera', () {
    testWidgets('renders custom error widget when initialization fails', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SilkCamera(
              availableCamerasLoader: () async => throw Exception('no camera'),
              errorWidget: const Text('Camera unavailable'),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.text('Camera unavailable'), findsOneWidget);
    });
  });
}
