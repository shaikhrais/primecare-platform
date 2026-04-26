import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE

class TimesheetDiscrepancyTable extends StatelessWidget {
  TimesheetDiscrepancyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 40,
      columns: [
        DataColumn(label: Text(LocaleKeys.dashboards_common_labels_staff.tr())),
        DataColumn(
          label: Text(LocaleKeys.dashboards_common_labels_variance.tr()),
        ),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(Text(LocaleKeys.dashboards_common_labels_j__doe.tr())),
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
            DataCell(Text(LocaleKeys.dashboards_common_labels_a__smith.tr())),
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
