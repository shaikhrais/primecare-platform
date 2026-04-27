// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/utils/report_exporter.dart';

class ExportReportsDialog extends StatefulWidget {
  const ExportReportsDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => const ExportReportsDialog(),
    );
  }

  @override
  State<ExportReportsDialog> createState() => _ExportReportsDialogState();
}

class _ExportReportsDialogState extends State<ExportReportsDialog> {
  String _selectedReportType = 'Audit';
  ReportFormat _selectedFormat = ReportFormat.pdf;
  DateTimeRange? _selectedDateRange;
  bool _isExporting = false;

  final List<String> _reportTypes = ['Audit', 'Clinical', 'Staff Activity'];

  Future<void> _handleExport(WidgetRef ref) async {
    setState(() => _isExporting = true);
    try {
      final exporter = ref.read(reportExporterProvider);

      switch (_selectedReportType) {
        case 'Audit':
          await exporter.exportAuditReport(
            startDate: _selectedDateRange?.start,
            endDate: _selectedDateRange?.end,
            format: _selectedFormat,
          );
          break;
        case 'Clinical':
          await exporter.exportClinicalComplianceReport(
            startDate: _selectedDateRange?.start,
            endDate: _selectedDateRange?.end,
            format: _selectedFormat,
          );
          break;
        case 'Staff Activity':
          await exporter.exportStaffActivityReport(
            startDate: _selectedDateRange?.start,
            endDate: _selectedDateRange?.end,
            format: _selectedFormat,
          );
          break;
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocaleKeys
                  .dashboards_common_labels_selectedreporttype_report_exported_successfully_as____selectedformat_name_touppercase
                  .tr(),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocaleKeys.dashboards_common_labels_export_failed___e.tr(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return AlertDialog(
          title: Text(
            LocaleKeys.dashboards_common_labels_institutional_compliance_export
                .tr(),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.dashboards_common_labels_select_report_type.tr(),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedReportType,
                  items: _reportTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _selectedReportType = val!),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  LocaleKeys.dashboards_common_labels_report_format.tr(),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RadioListTile<ReportFormat>(
                        title: Text(
                          LocaleKeys.dashboards_common_labels_pdf.tr(),
                        ),
                        value: ReportFormat.pdf,
                        // ignore: deprecated_member_use
                        groupValue: _selectedFormat,
                        // ignore: deprecated_member_use
                        onChanged: (val) =>
                            setState(() => _selectedFormat = val!),
                      ),
                    ),
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RadioListTile<ReportFormat>(
                        title: Text(
                          LocaleKeys.dashboards_common_labels_csv.tr(),
                        ),
                        value: ReportFormat.csv,
                        // ignore: deprecated_member_use
                        groupValue: _selectedFormat,
                        // ignore: deprecated_member_use
                        onChanged: (val) =>
                            setState(() => _selectedFormat = val!),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  LocaleKeys.dashboards_common_labels_date_range__optional.tr(),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    final range = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (range != null)
                      setState(() => _selectedDateRange = range);
                  },
                  icon: Icon(Icons.date_range),
                  label: Text(
                    _selectedDateRange == null
                        ? 'Selected: All Time'
                        : 'Period: ${DateFormat('MM/dd/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('MM/dd/yyyy').format(_selectedDateRange!.end)}',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: _isExporting
                  ? null
                  : () => Navigator.of(context).pop(),
              child: Text(
                LocaleKeys.dashboards_common_labels_cancel.tr(),
              ),
            ),
            PrimeCareButton(
              onPressed: _isExporting ? null : () => _handleExport(ref),
              text: 'Generate and Export',
              isLoading: _isExporting,
              isPrimary: true,
            ),
          ],
        );
      },
    );
  }
}
