import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TrainingProgramsScreen extends ConsumerWidget {
  const TrainingProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Training Programs',
      subtitle:
          'Design, deploy, and monitor organizational training curriculum.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search programs...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Create Program',
          icon: LucideIcons.plusCircle,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Active Programs',
          value: '24',
          icon: LucideIcons.folderHeart,
          trend: '+2 this month',
          isUp: true,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Total Enrolled',
          value: '450',
          icon: LucideIcons.users,
          trend: 'Across all active tracks',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Avg Completion Rate',
          value: '88%',
          icon: LucideIcons.checkSquare,
          trend: '+5% YoY',
          isUp: true,
          color: PrimeCareTheme.colors.amberWarning,
        ),
      ],
      sidebarContent: [_buildProgramCategories()],
      mainContent: [_buildProgramsGrid()],
    );
  }

  Widget _buildProgramCategories() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.listTree,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Program Categories', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildCatRow('Clinical Excellence', 8),
          const SizedBox(height: 12),
          _buildCatRow('Compliance & Legal', 5),
          const SizedBox(height: 12),
          _buildCatRow('Leadership', 4),
          const SizedBox(height: 12),
          _buildCatRow('Onboarding', 7),
        ],
      ),
    );
  }

  Widget _buildCatRow(String name, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: PrimeCareTheme.typography.body),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.cloudGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(count.toString(), style: PrimeCareTheme.typography.label),
        ),
      ],
    );
  }

  Widget _buildProgramsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text('Active Curriculum', style: PrimeCareTheme.typography.h2),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildProgramCard(
              title: 'Advanced Life Support (ALS)',
              category: 'Clinical Excellence',
              enrolled: 120,
              completion: 0.85,
              icon: LucideIcons.heartPulse,
              color: PrimeCareTheme.colors.coralRed,
            ),
            _buildProgramCard(
              title: 'Annual HIPAA Compliance',
              category: 'Compliance & Legal',
              enrolled: 350,
              completion: 0.40,
              icon: LucideIcons.shieldCheck,
              color: PrimeCareTheme.colors.navyIndigo,
            ),
            _buildProgramCard(
              title: 'New Hire Onboarding: Caregivers',
              category: 'Onboarding',
              enrolled: 45,
              completion: 0.95,
              icon: LucideIcons.userPlus,
              color: PrimeCareTheme.colors.emeraldTeal,
            ),
            _buildProgramCard(
              title: 'Conflict Resolution',
              category: 'Leadership',
              enrolled: 80,
              completion: 0.65,
              icon: LucideIcons.messageSquare,
              color: PrimeCareTheme.colors.amberWarning,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgramCard({
    required String title,
    required String category,
    required int enrolled,
    required double completion,
    required IconData icon,
    required Color color,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              IconButton(
                icon: const Icon(LucideIcons.moreHorizontal, size: 20),
                onPressed: () {},
                color: PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: PrimeCareTheme.typography.h3,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(category, style: PrimeCareTheme.typography.label),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$enrolled Enrolled',
                style: PrimeCareTheme.typography.label,
              ),
              Text(
                '${(completion * 100).toInt()}% Done',
                style: PrimeCareTheme.typography.label.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: completion,
            backgroundColor: PrimeCareTheme.colors.cloudGray,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
