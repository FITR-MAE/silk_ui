import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  testWidgets('filter chip has accessible keyboard and pointer targets', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: SilkFilterChip(
            label: 'Sort',
            value: 'Newest',
            options: const ['Newest', 'Popular'],
            onChanged: (_) {},
          ),
        ),
      ),
    );

    final target = tester.getSize(find.byType(PopupMenuButton<String>));
    expect(target.width, greaterThanOrEqualTo(44));
    expect(target.height, greaterThanOrEqualTo(44));
    final paintedChip = find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.padding ==
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
    expect(tester.getSize(paintedChip).height, lessThan(44));
    final data = tester.getSemantics(find.bySemanticsLabel('Sort Newest'));
    expect(data.flagsCollection.isButton, isTrue);
    expect(data.flagsCollection.isEnabled, ui.Tristate.isTrue);
    expect(data.getSemanticsData().hasAction(ui.SemanticsAction.tap), isTrue);
    final inkContext = tester.element(find.byType(InkWell).first);
    expect(Theme.of(inkContext).focusColor, SilkColorScheme.light.focusOverlay);
    expect(Theme.of(inkContext).hoverColor, SilkColorScheme.light.hoverOverlay);

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('Popular'), findsOneWidget);
    expect(
      tester.getSize(find.byType(PopupMenuItem<String>).first).height,
      greaterThanOrEqualTo(44),
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(find.text('Popular'), findsOneWidget);
    handle.dispose();
  });
}
