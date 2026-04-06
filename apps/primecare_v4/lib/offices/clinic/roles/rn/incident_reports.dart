import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class IncidentReportsScreen extends ConsumerWidget {
  const IncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Incident Reports',
      subtitle: 'Log, review, and track clinical incidents and near misses.',
      kpiCards: [
        KPICardData(
          title: 'Total Incidents',
          value: '4',
          icon: LucideIcons.alertTriangle,
          trend: -1.0,
          trendLabel: 'vs last month',
        ),
        KPICardData(
          title: 'Open Investigations',
          value: '1',
          icon: LucideIcons.search,
          trend: 0.0,
          trendLabel: 'currently active',
        ),
        KPICardData(
          title: 'Resolved',
          value: '3',
          icon: LucideIcons.checkCircle,
          trend: 2.0,
          trendLabel: 'recently closed',
        ),
        KPICardData(
          title: 'Near Misses',
          value: '2',
          icon: LucideIcons.eye,
          trend: 1.0,
          trendLabel: 'reported this period',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report Categories', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildCategoryRow('Falls', 2, PrimeCareTheme.colors.coralRed),
              _buildCategoryRow('Medication Errors', 1, PrimeCareTheme.colors.navyIndigo),
              _buildCategoryRow('Equipment Failure', 0, PrimeCareTheme.colors.lavenderLustre),
              _buildCategoryRow('Other', 1, PrimeCareTheme.colors.slateGray),
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
                  Text('Recent Reports', style: PrimeCareTheme.typography.h2),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('New Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildIncidentCard(
                'IR-2026-089',
                'Client Fall',
                'Client found on floor in bathroom. No apparent injuries. Vital signs stable.',
                'Open Investigation',
                'Oct 18, 2026',
                PrimeCareTheme.colors.coralRed,
              ),
              _buildIncidentCard(
                'IR-2026-088',
                'Medication Near Miss',
                'Wrong dosage dispensed by pharmacy, caught before administration.',
                'Resolved',
                'Oct 12, 2026',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildIncidentCard(
                'IR-2026-085',
                'Unwitnessed Fall',
                'Client reported falling previous night. Bruising observed on left hip.',
                'Resolved',
                'Sep 28, 2026',
                PrimeCareTheme.colors.emeraldTeal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryRow(String label, int count, Color color) {
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

  Widget _buildIncidentCard(String id, String type, String abstractInfo, String status, String date, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(id, style: PrimeCareTheme.typography.h3),
                  const SizedBox(width: 8),
                  Text('•', style: TextStyle(color: PrimeCareTheme.colors.slateGray)),
                  const SizedBox(width: 8),
                  Text(type, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
               Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(abstractInfo, style: PrimeCareTheme.typography.body),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reported: $date', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              TextButton(
                 onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: PrimeCareTheme.colors.navyIndigo,
                ),
                child: const Text('View Details'),
              )
            ],
          )
        ],
      ),
    );
  }
}
