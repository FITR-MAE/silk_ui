import 'dart:ui' as ui;

import 'package:flutter/material.dart';
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

    final posts = tester.getSemantics(find.text('Posts'));
    expect(posts.label, 'Posts');
    expect(posts.flagsCollection.isButton, isTrue);
    expect(posts.flagsCollection.isSelected, ui.Tristate.isTrue);
    expect(tester.widget<Text>(find.text('Posts')).style?.fontSize, 11);
    final itemPadding = tester
        .widgetList<Padding>(find.byType(Padding))
        .where(
          (padding) =>
              padding.padding ==
              const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        );
    expect(itemPadding, hasLength(2));

    await tester.tap(find.text('People'));
    expect(selected, 1);
    semantics.dispose();
  });
}
