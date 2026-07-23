import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('reduced motion', () {
    testWidgets('entrance animations render their final state without work', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        _reducedMotionApp(
          Column(
            children: [
              SilkFadeIn(
                delay: const Duration(days: 1),
                child: GestureDetector(
                  onTap: () => taps++,
                  child: const Text('Fade content'),
                ),
              ),
              const SilkSlideIn(
                delay: Duration(days: 1),
                child: Text('Slide content'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Fade content'), findsOneWidget);
      expect(find.text('Slide content'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(SilkFadeIn),
          matching: find.byType(AnimatedBuilder),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(SilkSlideIn),
          matching: find.byType(AnimatedBuilder),
        ),
        findsNothing,
      );
      expect(tester.binding.transientCallbackCount, 0);

      await tester.tap(find.text('Fade content'));
      expect(taps, 1);
      await tester.pump(const Duration(days: 1));
      expect(tester.binding.transientCallbackCount, 0);
    });

    testWidgets('an entrance animation cancels when the setting changes', (
      tester,
    ) async {
      var disableAnimations = false;
      late StateSetter rebuild;
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              rebuild = setState;
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(disableAnimations: disableAnimations),
                child: const SilkFadeIn(
                  delay: Duration(days: 1),
                  child: Text('Content'),
                ),
              );
            },
          ),
        ),
      );

      final entranceAnimation = find.descendant(
        of: find.byType(SilkFadeIn),
        matching: find.byType(AnimatedBuilder),
      );
      expect(entranceAnimation, findsOneWidget);
      rebuild(() => disableAnimations = true);
      await tester.pump();

      expect(find.text('Content'), findsOneWidget);
      expect(entranceAnimation, findsNothing);
      expect(tester.binding.transientCallbackCount, 0);
      await tester.pump(const Duration(days: 1));
      expect(entranceAnimation, findsNothing);
    });

    testWidgets('skeleton and loading dots are static loading indicators', (
      tester,
    ) async {
      await tester.pumpWidget(
        _reducedMotionApp(
          const Column(
            children: [SilkSkeleton(width: 100, height: 20), SilkLoadingDots()],
          ),
        ),
      );

      final skeleton = tester.widget<Container>(
        find.descendant(
          of: find.byType(SilkSkeleton),
          matching: find.byType(Container),
        ),
      );
      final decoration = skeleton.decoration! as ShapeDecoration;
      expect(decoration.color, SilkColorScheme.light.muted);
      expect(decoration.gradient, isNull);
      expect(
        find.descendant(
          of: find.byType(SilkLoadingDots),
          matching: find.byType(Container),
        ),
        findsNWidgets(3),
      );
      expect(
        find.descendant(
          of: find.byType(SilkSkeleton),
          matching: find.byType(AnimatedBuilder),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(SilkLoadingDots),
          matching: find.byType(AnimatedBuilder),
        ),
        findsNothing,
      );
      expect(tester.binding.transientCallbackCount, 0);

      await tester.pump(const Duration(seconds: 2));
      expect(tester.binding.transientCallbackCount, 0);
    });

    testWidgets('repeating loading feedback stops when motion is disabled', (
      tester,
    ) async {
      var disableAnimations = false;
      late StateSetter rebuild;
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              rebuild = setState;
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(disableAnimations: disableAnimations),
                child: const Column(
                  children: [SilkSkeleton(), SilkLoadingDots()],
                ),
              );
            },
          ),
        ),
      );

      expect(tester.binding.transientCallbackCount, greaterThan(0));
      rebuild(() => disableAnimations = true);
      await tester.pump();

      expect(tester.binding.transientCallbackCount, 0);
      await tester.pump(const Duration(seconds: 2));
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('button transitions are immediate but retain press feedback', (
      tester,
    ) async {
      await tester.pumpWidget(
        _reducedMotionApp(const SilkButton(label: 'Press', onPressed: _noop)),
      );

      expect(
        tester
            .widget<AnimatedContainer>(find.byType(AnimatedContainer))
            .duration,
        Duration.zero,
      );
      expect(
        tester.widget<AnimatedScale>(find.byType(AnimatedScale)).duration,
        Duration.zero,
      );
      expect(
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).duration,
        Duration.zero,
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(SilkButton)),
      );
      await tester.pump();
      expect(
        tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale,
        0.97,
      );
      await gesture.up();
    });

    testWidgets('navigation selection updates without a transition', (
      tester,
    ) async {
      var changes = 0;
      await tester.pumpWidget(
        _reducedMotionApp(
          SilkTabNavigation(
            items: const [
              SilkTabNavigationItem(label: 'Home', icon: Icons.home_outlined),
              SilkTabNavigationItem(
                label: 'Profile',
                icon: Icons.person_outline,
              ),
            ],
            pages: const [Text('Home page'), Text('Profile page')],
            onChanged: (_) => changes++,
          ),
        ),
      );

      for (final widget in tester.widgetList<AnimatedContainer>(
        find.descendant(
          of: find.byType(SilkTabNavigation),
          matching: find.byType(AnimatedContainer),
        ),
      )) {
        expect(widget.duration, Duration.zero);
      }
      for (final widget in tester.widgetList<AnimatedSwitcher>(
        find.descendant(
          of: find.byType(SilkTabNavigation),
          matching: find.byType(AnimatedSwitcher),
        ),
      )) {
        expect(widget.duration, Duration.zero);
      }

      final profile = tester.widget<Semantics>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Semantics && widget.properties.label == 'Profile',
        ),
      );
      profile.properties.onTap!();
      await tester.pump();

      expect(find.text('Profile page'), findsOneWidget);
      expect(changes, 1);
      expect(tester.binding.transientCallbackCount, 0);
    });

    testWidgets('pill-style tab selection uses an immediate controller', (
      tester,
    ) async {
      await tester.pumpWidget(
        _reducedMotionApp(
          const SizedBox(
            height: 300,
            child: SilkTabs(
              items: [
                SilkTabItem(label: 'First', child: Text('First page')),
                SilkTabItem(label: 'Second', child: Text('Second page')),
              ],
            ),
          ),
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.controller!.animationDuration, Duration.zero);

      await tester.tap(find.text('Second'));
      await tester.pump();
      expect(find.text('Second page'), findsOneWidget);
    });

    testWidgets('side drawer opens without a spatial transition', (
      tester,
    ) async {
      await tester.pumpWidget(
        _reducedMotionApp(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => SilkDrawer.show<void>(
                  context,
                  placement: SilkDrawerPlacement.right,
                  child: const Text('Drawer content'),
                ),
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed!();
      await tester.pump();

      expect(find.text('Drawer content'), findsOneWidget);
      expect(
        find.ancestor(
          of: find.text('Drawer content'),
          matching: find.byType(SlideTransition),
        ),
        findsNothing,
      );
      expect(tester.binding.transientCallbackCount, 0);
    });
  });
}

Widget _reducedMotionApp(Widget child) {
  return MaterialApp(
    home: Builder(
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: Scaffold(body: child),
        );
      },
    ),
  );
}

void _noop() {}
