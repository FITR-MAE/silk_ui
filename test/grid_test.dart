import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silk_ui/silk_ui.dart';

void main() {
  group('SilkGrid', () {
    testWidgets('renders children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkGrid(
              shrinkWrap: true,
              children: [Text('One'), Text('Two')],
            ),
          ),
        ),
      );

      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
    });

    testWidgets('applies grid configuration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkGrid(
              value: GridValue.sm,
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              shrinkWrap: true,
              children: [Text('One'), Text('Two'), Text('Three')],
            ),
          ),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 3);
      expect(delegate.mainAxisSpacing, 8);
      expect(delegate.crossAxisSpacing, 12);
      expect(delegate.childAspectRatio, 1.5);
    });

    testWidgets('applies value presets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SilkGrid(
              value: GridValue.lg,
              shrinkWrap: true,
              children: [Text('One'), Text('Two')],
            ),
          ),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.mainAxisSpacing, 24);
      expect(delegate.crossAxisSpacing, 24);
      expect(grid.padding, const EdgeInsets.all(24));
    });
  });
}
