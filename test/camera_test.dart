import 'dart:async';

import 'package:camera/camera.dart';
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

    testWidgets('clips placeholder with the configured radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkCamera(
              isActive: false,
              borderRadius: 18,
              placeholder: ColoredBox(color: Colors.red),
            ),
          ),
        ),
      );

      final clip = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(clip.borderRadius, BorderRadius.circular(18));
    });

    testWidgets('processes the latest active request after a pending open', (
      tester,
    ) async {
      final firstLoad = Completer<List<CameraDescription>>();
      var loads = 0;

      Future<List<CameraDescription>> loadCameras() {
        loads++;
        return loads == 1
            ? firstLoad.future
            : Future<List<CameraDescription>>.value(const []);
      }

      Widget buildCamera(bool active) {
        return MaterialApp(
          home: Scaffold(
            body: SilkCamera(
              key: const ValueKey('camera'),
              isActive: active,
              availableCamerasLoader: loadCameras,
              errorWidget: const Text('Camera unavailable'),
            ),
          ),
        );
      }

      await tester.pumpWidget(buildCamera(true));
      await tester.pump(const Duration(milliseconds: 450));
      expect(loads, 1);

      await tester.pumpWidget(buildCamera(false));
      await tester.pumpWidget(buildCamera(true));
      await tester.pump(const Duration(milliseconds: 250));
      firstLoad.complete(const []);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pumpAndSettle();

      expect(loads, 2);
      expect(find.text('Camera unavailable'), findsOneWidget);
    });
  });
}
