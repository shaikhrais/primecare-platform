import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildAvailableReports(context),
                            const SizedBox(height: 24),
                            _buildReportBuilder(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildComplianceStatus(context),
                            const SizedBox(height: 24),
                            _buildRecentDownloads(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Franchise Reports',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Access operational, compliance, and financial reporting dashboards',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(
              context,
              LucideIcons.calendar,
              'Scheduled Reports',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.cloudLightning,
              'Sync Data Source',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(
    BuildContext context,
    IconData icon,
    String tooltip,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildKPIUnit(
            context,
            'Reports Generated',
            '142',
            LucideIcons.fileText,
            'This Month',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Compliance Filings',
            '100%',
            LucideIcons.shieldCheck,
            'All branches',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Data Freshness',
            '< 5m',
            LucideIcons.refreshCw,
            'Real-time sync',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Scheduled Exports',
            '8',
            LucideIcons.clock,
            'Next run: 18:00',
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildKPIUnit(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    String subtitle,
    Color color,
  ) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableReports(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Reporting Suites',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Filter: All',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Report Name')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Last Run')),
                DataColumn(label: Text('Format')),
                DataColumn(label: Text('Action')),
              ],
              rows: [
                _buildDataRow(
                  'Daily Shift Summary',
                  'Operations',
                  'Today, 08:00',
                  'PDF / CSV',
                ),
                _buildDataRow(
                  'Branch Utilization',
                  'Financial',
                  'Yesterday',
                  'Excel',
                ),
                _buildDataRow(
                  'Staff Compliance Matrix',
                  'Compliance',
                  'Oct 1, 2024',
                  'PDF',
                ),
                _buildDataRow(
                  'Client Feedback Score',
                  'Quality',
                  'Weekly (Mon)',
                  'Dashboard',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String name,
    String category,
    String lastRun,
    String format,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              const Icon(
                LucideIcons.fileText,
                color: PrimeCareTheme.emeraldTeal,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        DataCell(Text(category, style: const TextStyle(color: Colors.white70))),
        DataCell(Text(lastRun)),
        DataCell(Text(format, style: const TextStyle(color: Colors.white70))),
        DataCell(
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              LucideIcons.download,
              size: 14,
              color: PrimeCareTheme.emeraldTeal,
            ),
            label: const Text(
              'Download',
              style: TextStyle(color: PrimeCareTheme.emeraldTeal, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportBuilder(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.wrench, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Text(
                'Custom Report Builder',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Select Data Sources:',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildDataChip('Staff Attendance', true),
              _buildDataChip('Client Billing', false),
              _buildDataChip('Logistics GPS', false),
              _buildDataChip('Incident Logs', true),
              _buildDataChip('Inventory Levels', false),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimeCareTheme.emeraldTeal,
                foregroundColor: PrimeCareTheme.navyIndigo,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              icon: const Icon(LucideIcons.playCircle, size: 20),
              label: const Text(
                'Generate Build',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimeCareTheme.emeraldTeal.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? PrimeCareTheme.emeraldTeal
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? PrimeCareTheme.emeraldTeal : Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildComplianceStatus(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.shieldAlert,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Reporting Compliance',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildComplianceRow(
            'MOH Data Submission',
            'Complete',
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildComplianceRow('WSIB Incident Log', 'Due Oct 31', Colors.orange),
          const SizedBox(height: 16),
          _buildComplianceRow(
            'Staff Certification Audit',
            'Complete',
            PrimeCareTheme.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceRow(String title, String status, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentDownloads(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.history, color: Colors.blue, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Recent Workspace Downloads',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDownloadItem(
            'Weekly Utilization_Sep_W4.xlsx',
            '12 MB',
            '1h ago',
          ),
          const Divider(color: Colors.white12, height: 24),
          _buildDownloadItem('Payroll_Export_B3.csv', '2.4 MB', 'Yesterday'),
          const Divider(color: Colors.white12, height: 24),
          _buildDownloadItem('Compliance_Audit_Q3.pdf', '15 MB', 'A week ago'),
        ],
      ),
    );
  }

  Widget _buildDownloadItem(String filename, String size, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            LucideIcons.fileArchive,
            size: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filename,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    size,
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
