import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  const items = [
    SilkTabNavigationItem(label: 'Home', icon: Icons.home_outlined),
    SilkTabNavigationItem(label: 'Profile', icon: Icons.person_outline),
  ];
  const pages = [Text('Home page'), Text('Profile page')];

  testWidgets('switches pages and reports one change', (tester) async {
    var changes = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: SilkTabNavigation(
          items: items,
          pages: pages,
          onChanged: (_) => changes++,
        ),
      ),
    );

    expect(find.text('Home page'), findsOneWidget);
    expect(find.text('Profile page'), findsNothing);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Profile page'), findsOneWidget);
    expect(changes, 1);
  });

  testWidgets('hides the bottom bar without padding the page', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SilkTabNavigation(
          hideBottomBar: true,
          items: items,
          pages: pages,
        ),
      ),
    );

    expect(find.text('Home page'), findsOneWidget);
    expect(find.text('Home'), findsNothing);
    final padding = tester.widget<Padding>(
      find.ancestor(of: find.text('Home page'), matching: find.byType(Padding)),
    );
    expect(padding.padding, EdgeInsets.zero);
  });

  testWidgets('recreates its controller when item count changes', (
    tester,
  ) async {
    var showProfile = true;
    late StateSetter rebuild;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            rebuild = setState;
            return SilkTabNavigation(
              items: showProfile ? items : items.take(1).toList(),
              pages: showProfile ? pages : pages.take(1).toList(),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    rebuild(() => showProfile = false);
    await tester.pumpAndSettle();

    expect(find.text('Home page'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('is flat by default and exposes selection semantics', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SilkTabNavigation(items: items, pages: pages),
      ),
    );

    final decoratedBoxes = tester.widgetList<DecoratedBox>(
      find.descendant(
        of: find.byType(SilkTabNavigation),
        matching: find.byType(DecoratedBox),
      ),
    );
    final shadows = decoratedBoxes
        .map((box) => box.decoration)
        .whereType<BoxDecoration>()
        .expand((decoration) => decoration.boxShadow ?? const <BoxShadow>[]);
    expect(shadows, isEmpty);

    final homeSemantics = tester.widget<Semantics>(
      find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Home',
      ),
    );
    expect(homeSemantics.properties.button, isTrue);
    expect(homeSemantics.properties.selected, isTrue);
    expect(homeSemantics.properties.enabled, isTrue);
    expect(homeSemantics.properties.onTap, isNotNull);

    for (final inkWell in tester.widgetList<InkWell>(find.byType(InkWell))) {
      final target = tester.getSize(find.byWidget(inkWell));
      expect(target.width, greaterThanOrEqualTo(44));
      expect(target.height, greaterThanOrEqualTo(44));
      expect(inkWell.focusColor, SilkColorScheme.light.focusOverlay);
      expect(inkWell.hoverColor, SilkColorScheme.light.hoverOverlay);
    }
  });

  testWidgets('navigation items activate with Enter and Space', (tester) async {
    Future<void> activate(LogicalKeyboardKey key) async {
      await tester.pumpWidget(
        MaterialApp(
          key: UniqueKey(),
          home: const SilkTabNavigation(items: items, pages: pages),
        ),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(key);
      await tester.pumpAndSettle();
      expect(find.text('Profile page'), findsOneWidget);
      final data = tester.getSemantics(find.bySemanticsLabel('Profile'));
      expect(data.flagsCollection.isButton, isTrue);
      expect(data.flagsCollection.isEnabled, ui.Tristate.isTrue);
      expect(data.getSemanticsData().hasAction(ui.SemanticsAction.tap), isTrue);
    }

    await activate(LogicalKeyboardKey.enter);
    await activate(LogicalKeyboardKey.space);
  });
}
