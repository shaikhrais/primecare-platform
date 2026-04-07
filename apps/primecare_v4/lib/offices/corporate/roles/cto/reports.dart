import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            _buildReportLibrary(context),
                            const SizedBox(height: 24),
                            _buildScheduledReports(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildComplianceArchives(context),
                            const SizedBox(height: 24),
                            _buildDistributionList(context),
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
              'IT & Tech Reports',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Audit summaries, capacity reports, and compliance exports.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.calendar, 'Schedules'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.plus, 'New Report'),
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
            '1,420',
            LucideIcons.fileText,
            'This month',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Scheduled Jobs',
            '42',
            LucideIcons.calendarClock,
            'Active schedules',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Data Exported',
            '18.4 GB',
            LucideIcons.hardDrive,
            'Last 30 days',
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Failed Gens',
            '2',
            LucideIcons.alertTriangle,
            '< 0.1% failure rate',
            Colors.orange,
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

  Widget _buildReportLibrary(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Report Library',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
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
                DataColumn(label: Text('Actions')),
              ],
              rows: [
                _buildReportRow(
                  'Monthly Access Audit',
                  'Security',
                  'Oct 1, 2026',
                  'PDF/CSV',
                ),
                _buildReportRow(
                  'Q3 Infrastructure Spend',
                  'Finance',
                  'Oct 5, 2026',
                  'Excel',
                ),
                _buildReportRow(
                  'API Integrations Health',
                  'System',
                  'Today 08:00',
                  'PDF',
                ),
                _buildReportRow(
                  'Feature Adoption Tracker',
                  'Analytics',
                  'Yesterday',
                  'CSV',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildReportRow(
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
              Icon(
                LucideIcons.fileText,
                color: PrimeCareTheme.emeraldTeal,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        DataCell(Text(category, style: const TextStyle(color: Colors.white70))),
        DataCell(Text(lastRun)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              format,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              Icon(LucideIcons.download, color: Colors.white70, size: 18),
              const SizedBox(width: 12),
              Icon(
                LucideIcons.play,
                color: PrimeCareTheme.emeraldTeal,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduledReports(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.calendarClock,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Active Schedules',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildScheduleRow(
            'Weekly Threat Intel Summary',
            'Every Monday 06:00 UTC',
            true,
          ),
          const Divider(color: Colors.white12, height: 24),
          _buildScheduleRow(
            'Daily Cost Anomaly Alert',
            'Daily 00:00 UTC',
            true,
          ),
          const Divider(color: Colors.white12, height: 24),
          _buildScheduleRow(
            'SOC2 Compliance Snapshot',
            'Last Day of Month',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleRow(String title, String schedule, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              schedule,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
        Switch(
          value: isActive,
          onChanged: (val) {},
          activeColor: PrimeCareTheme.emeraldTeal,
          activeTrackColor: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.3),
          inactiveThumbColor: Colors.white54,
          inactiveTrackColor: Colors.white12,
        ),
      ],
    );
  }

  Widget _buildComplianceArchives(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compliance Archives',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildArchiveFolder('SOC 2 Type II', '2025 Audit Package', '5 files'),
          const SizedBox(height: 16),
          _buildArchiveFolder('HIPAA Risk Assmt', 'Q3 2026', '12 files'),
          const SizedBox(height: 16),
          _buildArchiveFolder('Pen Test Reports', 'Annual External', '3 files'),
        ],
      ),
    );
  }

  Widget _buildArchiveFolder(String name, String sub, String count) {
    return Row(
      children: [
        Icon(LucideIcons.folder, color: Colors.blueAccent, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                sub,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
        Text(
          count,
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDistributionList(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.users, color: Colors.orange, size: 24),
              const SizedBox(width: 12),
              Text(
                'Distribution Lists',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDistRow('Executive Leadership', '12 members'),
          const SizedBox(height: 12),
          _buildDistRow('Engineering Managers', '24 members'),
          const SizedBox(height: 12),
          _buildDistRow('External Auditors', '3 members'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.5),
                ),
                foregroundColor: PrimeCareTheme.emeraldTeal,
              ),
              child: const Text('Manage Lists'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistRow(String listName, String members) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          listName,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        Text(
          members,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}
