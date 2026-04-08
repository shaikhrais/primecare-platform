import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswIncidentReportsScreen extends ConsumerWidget {
  const PswIncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Incident Reports',
      subtitle: 'File and track critical incident reports during your shift.',
      kpiCards: [
        KPICardData(
          title: 'Total Reports',
          value: '1',
          icon: LucideIcons.fileWarning,
          trend: 0.0,
          trendLabel: 'this month',
        ),
        KPICardData(
          title: 'Under Review',
          value: '0',
          icon: LucideIcons.search,
          trend: 0.0,
          trendLabel: 'pending action',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Emergency actions', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.alertTriangle),
                label: const Text('File New Report'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimeCareTheme.colors.brickRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.phoneCall),
                label: const Text('Call On-Call RN'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: PrimeCareTheme.colors.brickRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
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
              Text('Report History', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildReportCard(
                'INC-2026-042',
                'Patient Fall (No Injury)',
                'Ruth Bader Ginsburg',
                'Mar 12, 2026',
                'Closed',
                PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReportCard(
    String reportId,
    String title,
    String patient,
    String date,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.amberWarning.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.alertCircle,
                  color: PrimeCareTheme.colors.amberWarning,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: PrimeCareTheme.typography.h3),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        reportId,
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        patient,
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
