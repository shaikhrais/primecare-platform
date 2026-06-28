import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Data Table renders correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DataTable(
            key: const Key('data-table'),
            columns: const [DataColumn(label: Text('Col'))],
            rows: const [DataRow(cells: [DataCell(Text('Val'))])],
          ),
        ),
      ),
    );
    expect(find.byKey(const Key('data-table')), findsOneWidget);
  });
}
