// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/providers/03_D_portal_providers.dart';
import 'package:primecare_ui/src/theme/01_I_design_system.dart';

class PrimeCareDataTable<T> extends ConsumerWidget {
  final List<dynamic>? columns;
  final List<T>? data;
  final List<DataCell> Function(T)? rowBuilder;
  final List<DataRow>? rows; // Standard Flutter rows support

  const PrimeCareDataTable({
    super.key,
    this.columns,
    this.data,
    this.rowBuilder,
    this.rows,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    // Build the columns
    final List<DataColumn> dataColumns = (columns ?? []).map((col) {
      if (col is DataColumn) {
        // Enforce institutional header style if it's a raw DataColumn
        return DataColumn(
          label: DefaultTextStyle(
            style: GoogleFonts.inter(
              color: ds.colors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: PrimeCareSpacing.scaled(12, scale).toDouble(),
              letterSpacing: 0.5 * scale,
            ),
            child: col.label,
          ),
          onSort: col.onSort,
          tooltip: col.tooltip,
          numeric: col.numeric,
        );
      }
      if (col is String) {
        return DataColumn(
          label: Text(
            col.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: PrimeCareSpacing.scaled(11, scale).toDouble(),
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }
      return const DataColumn(label: Text(''));
    }).toList();

    // Build the rows
    final List<DataRow> dataRows =
        rows ??
        (data ?? []).map((item) {
          return DataRow(cells: rowBuilder!(item));
        }).toList();

    return Container(
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(
          PrimeCareSpacing.scaled(12, scale).toDouble(),
        ),
        border: Border.all(color: ds.colors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: ds.colors.shadow,
            blurRadius: 10.0 * scale,
            offset: Offset(0, 4.0 * scale),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            ds.colors.borderSubtle.withValues(alpha: 0.3),
          ),
          dividerThickness: 1.0 * scale,
          columnSpacing: PrimeCareSpacing.scaled(32, scale).toDouble(),
          headingRowHeight: PrimeCareSpacing.scaled(48, scale).toDouble(),
          dataRowMinHeight: PrimeCareSpacing.scaled(56, scale).toDouble(),
          dataRowMaxHeight: PrimeCareSpacing.scaled(56, scale).toDouble(),
          headingTextStyle: GoogleFonts.inter(
            color: ds.colors.textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: PrimeCareSpacing.scaled(12, scale).toDouble(),
            letterSpacing: 0.5 * scale,
          ),
          columns: dataColumns,
          rows: dataRows,
        ),
      ),
    );
  }
}
