import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/src/components/camera/camera_control.dart';

void main() {
  testWidgets('exposes named camera actions', (tester) async {
    var closes = 0;
    var galleryOpens = 0;
    var captures = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            height: 640,
            child: SilkCameraControl(
              onClose: () => closes++,
              onGallery: () => galleryOpens++,
              onCapture: () => captures++,
            ),
          ),
        ),
      ),
    );

    expect(_semantics('Close camera'), findsOneWidget);
    expect(_semantics('Turn flash on'), findsOneWidget);
    expect(_semantics('Take photo'), findsOneWidget);
    expect(_semantics('Open gallery'), findsOneWidget);
    expect(_semantics('Switch camera'), findsOneWidget);

    await tester.tap(_semantics('Close camera'));
    await tester.tap(_semantics('Open gallery'));
    await tester.tap(_semantics('Take photo'));
    expect(closes, 1);
    expect(galleryOpens, 1);
    expect(captures, 1);
  });

  testWidgets('disables capture while switching cameras', (tester) async {
    var captures = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            height: 640,
            child: SilkCameraControl(
              isSwitching: true,
              onCapture: () => captures++,
            ),
          ),
        ),
      ),
    );

    final capture = tester.widget<Semantics>(_semantics('Take photo'));
    expect(capture.properties.enabled, isFalse);
    await tester.tap(_semantics('Take photo'));
    expect(captures, 0);
  });
}

Finder _semantics(String label) {
  return find.byWidgetPredicate(
    (widget) => widget is Semantics && widget.properties.label == label,
  );
}
