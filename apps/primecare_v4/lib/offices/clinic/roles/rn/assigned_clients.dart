import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class AssignedClientsScreen extends ConsumerWidget {
  const AssignedClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Assigned Clients',
      subtitle: 'Manage and monitor your nursing caseload.',
      kpiCards: [
        KPICardData(
          title: 'Total Caseload',
          value: '18',
          icon: LucideIcons.users,
          trend: 2.0,
          trendLabel: 'vs last week',
        ),
        KPICardData(
          title: 'High Acuity',
          value: '4',
          icon: LucideIcons.activity,
          trend: 0.0,
          trendLabel: 'Requires daily check',
        ),
        KPICardData(
          title: 'Pending Assessments',
          value: '3',
          icon: LucideIcons.clipboardList,
          trend: -1.0,
          trendLabel: 'due this week',
        ),
        KPICardData(
          title: 'Recent Admissions',
          value: '2',
          icon: LucideIcons.userPlus,
          trend: 1.0,
          trendLabel: 'in last 7 days',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Acuity Breakdown', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildAcuityRow('High (Daily)', 4, PrimeCareTheme.colors.coralRed),
              _buildAcuityRow('Medium (Weekly)', 8, PrimeCareTheme.colors.navyIndigo),
              _buildAcuityRow('Low (Monthly)', 6, PrimeCareTheme.colors.emeraldTeal),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Client Roster', style: PrimeCareTheme.typography.h2),
                  _buildFilterButton(),
                ],
              ),
              const SizedBox(height: 24),
              _buildClientRow(
                'Eleanor Rigby',
                '82 yrs',
                'Post-op Hip Replacement',
                'High',
                'Visited Yesterday',
                LucideIcons.user,
              ),
              _buildClientRow(
                'John Smith',
                '65 yrs',
                'Diabetic Foot Ulcer',
                'High',
                'Visited Today 9:00 AM',
                LucideIcons.user,
              ),
              _buildClientRow(
                'Maria Garcia',
                '71 yrs',
                'Hypertension Management',
                'Medium',
                'Visited 3 days ago',
                LucideIcons.user,
              ),
              _buildClientRow(
                'Robert Chen',
                '58 yrs',
                'IV Antibiotics (PICC line)',
                'High',
                'Visited Today 1:30 PM',
                LucideIcons.user,
              ),
              _buildClientRow(
                'Margaret Atwood',
                '88 yrs',
                'Palliative Care',
                'Medium',
                'Visited Yesterday',
                LucideIcons.user,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAcuityRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.filter, size: 16, color: PrimeCareTheme.colors.navyIndigo),
          const SizedBox(width: 8),
          Text('Filter clients', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
        ],
      ),
    );
  }

  Widget _buildClientRow(String name, String age, String diagnosis, String acuity, String lastVisit, IconData icon) {
    Color acuityColor = acuity == 'High' ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.navyIndigo;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: acuityColor, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                  child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: PrimeCareTheme.typography.h3),
                    const SizedBox(height: 4),
                    Text('$age • $diagnosis', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Acuity', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: acuityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    acuity,
                    style: PrimeCareTheme.typography.label.copyWith(color: acuityColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Last Visit', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 4),
                Text(lastVisit, style: PrimeCareTheme.typography.label.copyWith(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
