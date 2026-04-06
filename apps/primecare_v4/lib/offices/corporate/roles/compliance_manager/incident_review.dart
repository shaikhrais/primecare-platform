import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class IncidentReviewScreen extends ConsumerWidget {
  const IncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Incident Review',
      subtitle: 'Analyze reported incidents, classify severity, and conduct root cause analyses.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search incidents by ID or type...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Export Report',
          icon: LucideIcons.download,
        ),
        const SizedBox(width: 12),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Log Incident',
          icon: LucideIcons.plus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Critical Incidents',
          value: '3',
          icon: LucideIcons.alertOctagon,
          trend: 'Requires immediate action',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
        MetricCardData(
          title: 'Under Review',
          value: '14',
          icon: LucideIcons.search,
          trend: '-2 from last week',
          isUp: true,
        ),
        MetricCardData(
          title: 'Resolved (30d)',
          value: '42',
          icon: LucideIcons.checkCircle,
          trend: 'Avg resolution: 4.2 days',
          isUp: true,
        ),
      ],
      sidebarContent: [
        _buildSeverityBreakdown(),
        const SizedBox(height: 24),
        _buildRecentUpdates(),
      ],
      mainContent: [
        _buildIncidentList(),
      ],
    );
  }

  Widget _buildSeverityBreakdown() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.barChart2, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Severity Breakdown', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildSeverityItem('Critical (Level 1)', 3, PrimeCareTheme.colors.coralRed),
          const SizedBox(height: 12),
          _buildSeverityItem('Major (Level 2)', 8, PrimeCareTheme.colors.amberWarning),
          const SizedBox(height: 12),
          _buildSeverityItem('Moderate (Level 3)', 15, PrimeCareTheme.colors.royalPurple),
          const SizedBox(height: 12),
          _buildSeverityItem('Minor (Level 4)', 32, PrimeCareTheme.colors.slateGray),
        ],
      ),
    );
  }

  Widget _buildSeverityItem(String label, int count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(label, style: PrimeCareTheme.typography.body),
          ],
        ),
        Text(
          count.toString(),
          style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildRecentUpdates() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.history, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Recent Updates', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildUpdateRow('INC-9021', 'Status changed to "Under Review"', '10m ago'),
          const SizedBox(height: 12),
          _buildUpdateRow('INC-9018', 'Root Cause Analysis completed', '2h ago'),
          const SizedBox(height: 12),
          _buildUpdateRow('INC-8992', 'Closed by Compliance Director', 'Yesterday'),
        ],
      ),
    );
  }

  Widget _buildUpdateRow(String id, String description, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(id, style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
              color: PrimeCareTheme.colors.navyIndigo,
            )),
            Text(time, style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            )),
          ],
        ),
        const SizedBox(height: 4),
        Text(description, style: PrimeCareTheme.typography.body),
      ],
    );
  }

  Widget _buildIncidentList() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active Incidents', style: PrimeCareTheme.typography.h2),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildIncidentItem(
            id: 'INC-9024',
            type: 'Medication Error',
            date: 'Today, 08:30 AM',
            severity: 'Critical',
            status: 'New',
            reporter: 'R. Simmons (RN)',
            department: 'ICU Wing B',
          ),
          const Divider(height: 1),
          _buildIncidentItem(
            id: 'INC-9021',
            type: 'Patient Fall',
            date: 'Yesterday, 02:15 PM',
            severity: 'Major',
            status: 'Under Review',
            reporter: 'L. Chen (PSW)',
            department: 'Rehabilitation',
          ),
          const Divider(height: 1),
          _buildIncidentItem(
            id: 'INC-9018',
            type: 'Equipment Failure',
            date: 'Oct 12, 11:45 AM',
            severity: 'Moderate',
            status: 'RCA Pending',
            reporter: 'M. Johnson (Tech)',
            department: 'Radiology',
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentItem({
    required String id,
    required String type,
    required String date,
    required String severity,
    required String status,
    required String reporter,
    required String department,
  }) {
    Color severityColor;
    switch (severity) {
      case 'Critical':
        severityColor = PrimeCareTheme.colors.coralRed;
        break;
      case 'Major':
        severityColor = PrimeCareTheme.colors.amberWarning;
        break;
      case 'Moderate':
        severityColor = PrimeCareTheme.colors.royalPurple;
        break;
      default:
        severityColor = PrimeCareTheme.colors.slateGray;
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: severityColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.alertTriangle, color: severityColor, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Text(id, style: PrimeCareTheme.typography.body.copyWith(
                       color: PrimeCareTheme.colors.slateGray,
                     )),
                     const SizedBox(width: 12),
                     Text(type, style: PrimeCareTheme.typography.h3),
                   ],
                 ),
                 const SizedBox(height: 8),
                 Row(
                   children: [
                     Icon(LucideIcons.calendar, size: 14, color: PrimeCareTheme.colors.slateGray),
                     const SizedBox(width: 4),
                     Text(date, style: PrimeCareTheme.typography.label),
                     const SizedBox(width: 16),
                     Icon(LucideIcons.mapPin, size: 14, color: PrimeCareTheme.colors.slateGray),
                     const SizedBox(width: 4),
                     Text(department, style: PrimeCareTheme.typography.label),
                     const SizedBox(width: 16),
                     Icon(LucideIcons.user, size: 14, color: PrimeCareTheme.colors.slateGray),
                     const SizedBox(width: 4),
                     Text(reporter, style: PrimeCareTheme.typography.label),
                   ],
                 ),
               ],
             ),
          ),
          Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
                Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                 decoration: BoxDecoration(
                   color: PrimeCareTheme.colors.cloudGray,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Text(
                   status,
                   style: PrimeCareTheme.typography.label.copyWith(
                     color: PrimeCareTheme.colors.navyIndigo,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                ),
                const SizedBox(height: 12),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Review',
                  icon: LucideIcons.arrowRight,
                ),
             ],
          ),
        ],
      ),
    );
  }
}
