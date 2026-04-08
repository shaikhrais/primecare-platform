import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnCarePlansScreen extends ConsumerWidget {
  const RpnCarePlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Care Plans (RPN)',
      subtitle:
          'Review and execute active nursing care plans for assigned patients.',
      kpiCards: [
        KPICardData(
          title: 'Active Plans',
          value: '18',
          icon: LucideIcons.clipboardList,
          trend: 0.0,
          trendLabel: 'currently assigned',
        ),
        KPICardData(
          title: 'Interventions Due',
          value: '5',
          icon: LucideIcons.clock,
          trend: 2.0,
          trendLabel: 'this shift',
        ),
        KPICardData(
          title: 'Goals Met',
          value: '2',
          icon: LucideIcons.checkCircle,
          trend: 1.0,
          trendLabel: 'this week',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Plan Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow(
                'Wound Care Protocol',
                4,
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildFilterRow(
                'Diabetic Management',
                8,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildFilterRow(
                'Post-Op Recovery',
                6,
                PrimeCareTheme.colors.lavenderLustre,
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
                    'Active Interventions',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('Log Intervention'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildCarePlanCard(
                'Maria Garcia',
                'Diabetic Management',
                'Requires Q6H blood glucose monitoring and dietary assistance. Ensure foot check performed daily.',
                '1 Goal Met • 2 Active',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildCarePlanCard(
                'John Smith',
                'Post-Op Recovery',
                'Monitor surgical site for signs of infection. Administer PRN analgesics as prescribed. Assist with early ambulation.',
                '0 Goals Met • 3 Active',
                PrimeCareTheme.colors.lavenderLustre,
              ),
              _buildCarePlanCard(
                'Eleanor Rigby',
                'Wound Care Protocol',
                'Stage 2 pressure ulcer on sacrum. Perform dressing change every 48 hours or when soiled. Apply barrier cream.',
                '1 Goal Met • 1 Active',
                PrimeCareTheme.colors.navyIndigo,
                requiresAction: true,
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

  Widget _buildCarePlanCard(
    String clientName,
    String planType,
    String details,
    String goals,
    Color themeColor, {
    bool requiresAction = false,
  }) {
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
                    planType,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
              if (requiresAction)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.coralRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'DUE TODAY',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.coralRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(details, style: PrimeCareTheme.typography.body),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                goals,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.fileText, size: 16),
                label: const Text('View Full Plan'),
                style: TextButton.styleFrom(
                  foregroundColor: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
