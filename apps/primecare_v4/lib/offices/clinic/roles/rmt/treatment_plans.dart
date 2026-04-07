import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RmtTreatmentPlansScreen extends ConsumerWidget {
  const RmtTreatmentPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Treatment Plans',
      subtitle:
          'Long-term clinic goals, modalities, and reassessment schedules.',
      kpiCards: [
        KPICardData(
          title: 'Active Plans',
          value: '45',
          icon: LucideIcons.map,
          trend: 5.0,
          trendLabel: 'this month',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Plan Goals', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow(
                'Pain Reduction',
                25,
                PrimeCareTheme.colors.coralBlush,
              ),
              _buildFilterRow(
                'Increased ROM',
                12,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildFilterRow(
                'Maintenance',
                8,
                PrimeCareTheme.colors.navyIndigo,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Active Plans',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.fileSignature),
                    label: const Text('Create Plan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildPlanCard(
                'John Doe',
                'Chronic Lower Back Pain',
                'Reassess in: 2 weeks',
                'Goal: Reduce pain scale to <3/10. Increase lumbar flexion ROM safely. Strategy: 1x/week 60min massage incorporating deep tissue and myofascial release on glutes/QL. Encourage daily core stabilization exercises.',
                PrimeCareTheme.colors.coralBlush,
                0.6,
              ),
              _buildPlanCard(
                'Jane Smith',
                'General Maintenance',
                'Reassess in: 8 weeks',
                'Goal: Maintain muscle suppleness and reduce stress. Strategy: 1x/month 90min relaxation massage. Focus on upper back and neck tension.',
                PrimeCareTheme.colors.navyIndigo,
                0.2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
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
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(
            count.toString(),
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    String clientName,
    String condition,
    String reassess,
    String plan,
    Color themeColor,
    double progress,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(clientName, style: PrimeCareTheme.typography.h3),
                  const SizedBox(width: 8),
                  Text(
                    '•',
                    style: TextStyle(color: PrimeCareTheme.colors.slateGray),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    condition,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
              Text(
                reassess,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(plan, style: PrimeCareTheme.typography.body),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Plan Progress', style: PrimeCareTheme.typography.label),
              const SizedBox(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor:
                        PrimeCareTheme.colors.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(progress * 100).toInt()}%',
                style: PrimeCareTheme.typography.label,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
