import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  testWidgets('pill tabs expose selection and touch-safe targets', (
    tester,
  ) async {
    int? selected;
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SilkPillTabBar(
            tabs: const ['Posts', 'People'],
            selectedIndex: 0,
            onTabChanged: (value) => selected = value,
          ),
        ),
      ),
    );

    final posts = tester.getSemantics(find.text('Posts'));
    expect(posts.label, 'Posts');
    expect(posts.flagsCollection.isButton, isTrue);
    expect(posts.flagsCollection.isSelected, ui.Tristate.isTrue);
    for (final inkWell in tester.widgetList<InkWell>(find.byType(InkWell))) {
      expect(
        tester.getSize(find.byWidget(inkWell)).height,
        greaterThanOrEqualTo(44),
      );
    }

    await tester.tap(find.text('People'));
    expect(selected, 1);
    semantics.dispose();
  });
}
