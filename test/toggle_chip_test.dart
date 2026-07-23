import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    expect(data.flagsCollection.isEnabled, ui.Tristate.isTrue);
    expect(data.flagsCollection.isSelected, ui.Tristate.isTrue);
    expect(data.getSemanticsData().hasAction(ui.SemanticsAction.tap), isTrue);
    final target = tester.getSize(find.byType(InkWell));
    expect(target.width, greaterThanOrEqualTo(44));
    expect(target.height, greaterThanOrEqualTo(44));
    expect(tester.getSize(find.byType(Ink)).height, lessThan(44));
    final inkWell = tester.widget<InkWell>(find.byType(InkWell));
    expect(inkWell.focusColor, SilkColorScheme.light.focusOverlay);
    expect(inkWell.hoverColor, SilkColorScheme.light.hoverOverlay);

    await tester.tap(find.byType(SilkToggleChip));
    expect(tapped, isTrue);
    tapped = false;
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(tapped, isTrue);
    tapped = false;
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(tapped, isTrue);
    semantics.dispose();
  });
}
