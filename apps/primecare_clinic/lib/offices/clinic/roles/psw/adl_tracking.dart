import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswAdlTrackingScreen extends ConsumerWidget {
  const PswAdlTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'ADL Tracking',
      subtitle: 'Log Activities of Daily Living for your current patient.',
      kpiCards: [
        KPICardData(
          title: 'ADLs Logged',
          value: '18',
          icon: LucideIcons.checkSquare,
          trend: 0.0,
          trendLabel: 'today',
        ),
        KPICardData(
          title: 'Pending ADLs',
          value: '4',
          icon: LucideIcons.clock,
          trend: 0.0,
          trendLabel: 'current visit',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Current Visit', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      radius: 32,
                      child: const Text(
                        'TM',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Thurgood Marshall',
                      style: PrimeCareTheme.typography.h3,
                    ),
                    const Text(
                      'Post-Op Recovery',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.save),
                label: const Text('Submit Session Logs'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimeCareTheme.colors.emeraldTeal,
                  foregroundColor: Colors.white,
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
              Text('Hygiene & Grooming', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 16),
              _buildAdlRow('Bathing Assistance', true),
              _buildAdlRow('Oral Care', true),
              _buildAdlRow('Dressing', false),
              const SizedBox(height: 32),

              Text('Mobility & Transfer', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 16),
              _buildAdlRow('Bed to Chair Transfer', false),
              _buildAdlRow('Walking Assistance', false),
              const SizedBox(height: 32),

              Text('Nutrition & Feeding', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 16),
              _buildAdlRow('Meal Preparation', true),
              _buildAdlRow('Feeding Assistance', true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdlRow(String title, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCompleted
            ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1)
            : PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted
              ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.5)
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCompleted ? LucideIcons.checkCircle2 : LucideIcons.circle,
            color: isCompleted
                ? PrimeCareTheme.colors.emeraldTeal
                : PrimeCareTheme.colors.slateGray,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                color: isCompleted
                    ? PrimeCareTheme.colors.textPrimary
                    : PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          if (!isCompleted)
            OutlinedButton(onPressed: () {}, child: const Text('Mark Done')),
        ],
      ),
    );
  }
}
