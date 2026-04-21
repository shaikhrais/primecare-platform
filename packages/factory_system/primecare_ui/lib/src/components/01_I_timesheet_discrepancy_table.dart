// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

class TimesheetDiscrepancyTable extends StatelessWidget {
  const TimesheetDiscrepancyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 40,
      columns: const [
        DataColumn(label: Text('Staff')),
        DataColumn(label: Text('Variance')),
      ],
      rows: const [
        DataRow(
          cells: [
            DataCell(Text('J. Doe')),
            DataCell(
              Text(
                '+45 mins',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: PrimeCareColors.rose),
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('A. Smith')),
            DataCell(
              Text(
                '-15 mins',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: PrimeCareColors.amber),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
