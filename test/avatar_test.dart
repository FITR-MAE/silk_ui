import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  testWidgets('non-tappable avatar retains its visual size', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SilkAvatar(name: 'Ada Lovelace', scale: AvatarScale.xs),
        ),
      ),
    );

    expect(tester.getSize(find.byType(SilkAvatar)), const Size.square(24));
    expect(find.byType(InkWell), findsNothing);
  });

  testWidgets('tappable avatar has semantics, keyboard, and a 44px target', (
    tester,
  ) async {
    var taps = 0;
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: SilkAvatar(
            name: 'Ada Lovelace',
            semanticLabel: 'Open Ada profile',
            tooltip: 'Open Ada profile',
            scale: AvatarScale.xs,
            onTap: () => taps++,
          ),
        ),
      ),
    );

    final data = tester.getSemantics(find.bySemanticsLabel('Open Ada profile'));
    expect(data.label, 'Open Ada profile');
    expect(data.flagsCollection.isButton, isTrue);
    expect(data.flagsCollection.isEnabled, ui.Tristate.isTrue);
    expect(data.getSemanticsData().hasAction(ui.SemanticsAction.tap), isTrue);
    final target = tester.getSize(find.byType(InkWell));
    expect(target.width, greaterThanOrEqualTo(44));
    expect(target.height, greaterThanOrEqualTo(44));
    final avatarCircle = tester.getSize(
      find.descendant(
        of: find.byType(SilkAvatar),
        matching: find.byType(Container),
      ),
    );
    expect(avatarCircle, const Size.square(24));
    final inkWell = tester.widget<InkWell>(find.byType(InkWell));
    expect(inkWell.focusColor, SilkColorScheme.light.focusOverlay);
    expect(inkWell.hoverColor, SilkColorScheme.light.hoverOverlay);

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(taps, 2);
    handle.dispose();
  });
}
