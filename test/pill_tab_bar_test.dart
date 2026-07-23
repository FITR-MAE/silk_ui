import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  testWidgets('pill tabs expose selection in the compact layout', (
    tester,
  ) async {
    int? selected;
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SilkPillTabBar(
              tabs: const ['Posts', 'People'],
              selectedIndex: 0,
              onTabChanged: (value) => selected = value,
            ),
          ),
        ),
      ),
    );

    final posts = tester.getSemantics(find.bySemanticsLabel('Posts'));
    expect(posts.label, 'Posts');
    expect(posts.flagsCollection.isButton, isTrue);
    expect(posts.flagsCollection.isEnabled, ui.Tristate.isTrue);
    expect(posts.flagsCollection.isSelected, ui.Tristate.isTrue);
    expect(posts.getSemanticsData().hasAction(ui.SemanticsAction.tap), isTrue);
    expect(tester.widget<Text>(find.text('Posts')).style?.fontSize, 11);
    final itemPadding = tester
        .widgetList<Padding>(find.byType(Padding))
        .where(
          (padding) =>
              padding.padding ==
              const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        );
    expect(itemPadding, hasLength(2));
    for (final inkWell in tester.widgetList<InkWell>(find.byType(InkWell))) {
      final target = tester.getSize(find.byWidget(inkWell));
      expect(target.width, greaterThanOrEqualTo(44));
      expect(target.height, greaterThanOrEqualTo(44));
      expect(inkWell.focusColor, SilkColorScheme.light.focusOverlay);
      expect(inkWell.hoverColor, SilkColorScheme.light.hoverOverlay);
    }
    final paintedShell = find.byWidgetPredicate(
      (widget) =>
          widget is Container && widget.padding == const EdgeInsets.all(3),
    );
    expect(tester.getSize(paintedShell).height, lessThan(44));

    await tester.tap(find.bySemanticsLabel('People'));
    expect(selected, 1);
    selected = null;
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(selected, 0);
    selected = null;
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(selected, 1);
    semantics.dispose();
  });
}
