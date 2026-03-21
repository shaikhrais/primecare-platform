import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';
import '../theme/theme_extension.dart';

class PrimeCareDataTable<T> extends StatelessWidget {
  final List<String> columns;
  final List<T> data;
  final List<DataCell> Function(T) rowBuilder;

  const PrimeCareDataTable({
    super.key,
    required this.columns,
    required this.data,
    required this.rowBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.pTheme;
    
    return Container(
      decoration: BoxDecoration(
        color: t.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: t.borderSubtle),
      ),
      // Scroll constraints explicitly matching DataTables wide architecture natively
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(t.borderSubtle.withValues(alpha: 0.3)),
          dividerThickness: 1,
          columnSpacing: PrimeCareSpacing.xl,
          headingTextStyle: TextStyle(
            color: t.textMuted,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
          columns: columns.map((col) => DataColumn(label: Text(col.toUpperCase()))).toList(),
          rows: data.map((item) {
            return DataRow(
              cells: rowBuilder(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}
