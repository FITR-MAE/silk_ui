import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  testWidgets('toggle chip is selectable and uses a touch-safe target', (
    tester,
  ) async {
    var tapped = false;
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SilkToggleChip(
            label: 'On sale',
            isSelected: true,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    final data = tester.getSemantics(find.byType(SilkToggleChip));
    expect(data.label, 'On sale');
    expect(data.flagsCollection.isButton, isTrue);
    expect(data.flagsCollection.isSelected, ui.Tristate.isTrue);
    expect(
      tester.getSize(find.byType(InkWell)).height,
      greaterThanOrEqualTo(44),
    );

    await tester.tap(find.byType(SilkToggleChip));
    expect(tapped, isTrue);
    semantics.dispose();
  });
}
