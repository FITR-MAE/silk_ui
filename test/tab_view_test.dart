import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkTabs', () {
    testWidgets('reports one change after parent rebuilds', (tester) async {
      var changes = 0;
      late StateSetter rebuild;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                rebuild = setState;
                return SizedBox(
                  height: 300,
                  child: SilkTabs(
                    onChanged: (_) => changes++,
                    items: const [
                      SilkTabItem(label: 'First', child: Text('First page')),
                      SilkTabItem(label: 'Second', child: Text('Second page')),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      rebuild(() {});
      await tester.pump();
      rebuild(() {});
      await tester.pump();
      await tester.tap(find.text('Second').first);
      await tester.pumpAndSettle();

      expect(changes, 1);
      expect(find.text('Second page'), findsOneWidget);
    });

    testWidgets('applies caller padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 300,
              child: SilkTabs(
                padding: 24,
                items: [SilkTabItem(label: 'First', child: Text('Page'))],
              ),
            ),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Padding && widget.padding == const EdgeInsets.all(24),
        ),
        findsOneWidget,
      );
    });
  });
}
