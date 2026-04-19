import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:intl/intl.dart';
import '../../../utils/report_exporter.dart';

class ExportReportsDialog extends StatefulWidget {
  const ExportReportsDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
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
            content: Text('$_selectedReportType report exported successfully as ${_selectedFormat.name.toUpperCase()}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
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
          title: const Text('Institutional Compliance Export'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Report Type'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedReportType,
                  items: _reportTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedReportType = val!),
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                const Text('Report Format'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RadioListTile<ReportFormat>(
                        title: const Text('PDF'),
                        value: ReportFormat.pdf,
                        // ignore: deprecated_member_use
                        groupValue: _selectedFormat,
                        // ignore: deprecated_member_use
                        onChanged: (val) => setState(() => _selectedFormat = val!),
                      ),
                    ),
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RadioListTile<ReportFormat>(
                        title: const Text('CSV'),
                        value: ReportFormat.csv,
                        // ignore: deprecated_member_use
                        groupValue: _selectedFormat,
                        // ignore: deprecated_member_use
                        onChanged: (val) => setState(() => _selectedFormat = val!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Date Range (Optional)'),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    final range = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (range != null) setState(() => _selectedDateRange = range);
                  },
                  icon: const Icon(Icons.date_range),
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
              onPressed: _isExporting ? null : () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
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
