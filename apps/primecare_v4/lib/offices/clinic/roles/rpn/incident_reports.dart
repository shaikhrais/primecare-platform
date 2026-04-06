import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class IncidentReportsScreen extends ConsumerWidget {
  const IncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildOverviewCards(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildRecentIncidentsTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: _buildIncidentTrendsCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Incident Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage and document clinical and safety incidents.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.filePlus,
          label: 'File New Incident',
        ),
      ],
    );
  }

  Widget _buildOverviewCards() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Reports This Month',
            value: '12',
            trend: '+2 from last month',
            trendUp: true,
            icon: LucideIcons.fileWarning,
            color: PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Pending Reviews',
            value: '3',
            trend: 'Requires immediate action',
            trendUp: false,
            icon: LucideIcons.clock,
            color: Colors.orange.shade700,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Closed Incidents',
            value: '45',
            trend: 'Year to date',
            trendUp: true,
            icon: LucideIcons.checkCircle2,
            color: PrimeCareTheme.colors.navyIndigo,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String trend,
    required bool trendUp,
    required IconData icon,
    required Color color,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Icon(
                trendUp ? LucideIcons.trendingUp : LucideIcons.trendingDown,
                color: trendUp ? PrimeCareTheme.colors.emeraldTeal : Colors.red,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            value,
            style: PrimeCareTheme.typography.heroTitle.copyWith(
              fontSize: 36,
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            trend,
            style: PrimeCareTheme.typography.label.copyWith(
              color: trendUp ? PrimeCareTheme.colors.emeraldTeal : Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentIncidentsTable() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Incident Logs',
                style: PrimeCareTheme.typography.h2.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.listFilter, size: 16),
                label: const Text('Filter'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildIncidentRow('INC-1042', 'Medication Error', 'Oct 12, 14:30', 'Pending', Colors.orange),
          const Divider(height: 32, color: Colors.black12),
          _buildIncidentRow('INC-1041', 'Patient Fall', 'Oct 10, 09:15', 'Under Review', Colors.blue),
          const Divider(height: 32, color: Colors.black12),
          _buildIncidentRow('INC-1040', 'Equipment Failure', 'Oct 08, 11:00', 'Resolved', PrimeCareTheme.colors.emeraldTeal),
          const Divider(height: 32, color: Colors.black12),
          _buildIncidentRow('INC-1039', 'Staff Injury', 'Oct 05, 16:45', 'Resolved', PrimeCareTheme.colors.emeraldTeal),
        ],
      ),
    );
  }

  Widget _buildIncidentRow(String id, String type, String date, String status, MaterialColor color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ID: $id',
                style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            date,
            style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.shade50,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.shade200),
          ),
          child: Text(
            status,
            style: PrimeCareTheme.typography.label.copyWith(
              color: color.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIncidentTrendsCard() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Severity Breakdown',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildSeverityBar('Low', 0.6, PrimeCareTheme.colors.emeraldTeal),
          const SizedBox(height: 16),
          _buildSeverityBar('Medium', 0.3, Colors.orange),
          const SizedBox(height: 16),
          _buildSeverityBar('High', 0.1, Colors.red),
        ],
      ),
    );
  }

  Widget _buildSeverityBar(String label, double fill, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.slateGray.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fill,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
