import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RiskRegisterScreen extends ConsumerWidget {
  const RiskRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Risk Register',
      subtitle: 'Identify, assess, and monitor organizational and clinical risks.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search risks by ID, title, or category...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Export Matrix',
          icon: LucideIcons.grid,
        ),
        const SizedBox(width: 12),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Add Risk',
          icon: LucideIcons.plus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Extreme / High Risks',
          value: '4',
          icon: LucideIcons.flame,
          trend: '-1 mitigated this period',
          isUp: true,
          color: PrimeCareTheme.colors.coralRed,
        ),
        MetricCardData(
          title: 'Total Active Risks',
          value: '38',
          icon: LucideIcons.shieldAlert,
          trend: 'Active tracking',
          isUp: false,
        ),
        MetricCardData(
          title: 'Mitigation Rate',
          value: '82%',
          icon: LucideIcons.activity,
          trend: 'Target: >90%',
          isUp: true,
        ),
      ],
      sidebarContent: [
        _buildRiskHeatmapSummary(),
        const SizedBox(height: 24),
        _buildRiskCategories(),
      ],
      mainContent: [
        _buildRiskList(),
      ],
    );
  }

  Widget _buildRiskHeatmapSummary() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.grid, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Heatmap Summary', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildHeatmapStat('Extreme (5x5)', 1, PrimeCareTheme.colors.coralRed),
          const SizedBox(height: 12),
          _buildHeatmapStat('High', 3, PrimeCareTheme.colors.coralRed.withOpacity(0.7)),
          const SizedBox(height: 12),
          _buildHeatmapStat('Medium', 12, PrimeCareTheme.colors.amberWarning),
          const SizedBox(height: 12),
          _buildHeatmapStat('Low', 22, PrimeCareTheme.colors.emeraldTeal),
        ],
      ),
    );
  }

  Widget _buildHeatmapStat(String label, int count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 12, height: 12, color: color),
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

  Widget _buildRiskCategories() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.pieChart, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('By Domain', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildCatRow('Clinical / Patient Care', '18'),
          const SizedBox(height: 12),
          _buildCatRow('IT / Cyber Security', '8'),
          const SizedBox(height: 12),
          _buildCatRow('Financial / Audit', '5'),
          const SizedBox(height: 12),
          _buildCatRow('HR / Staffing shortages', '7'),
        ],
      ),
    );
  }

  Widget _buildCatRow(String name, String count) {
     return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(name, style: PrimeCareTheme.typography.body),
         Text(count, style: PrimeCareTheme.typography.label.copyWith(
           color: PrimeCareTheme.colors.slateGray,
           fontWeight: FontWeight.bold,
         )),
       ],
     );
  }

  Widget _buildRiskList() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active Risks Directory', style: PrimeCareTheme.typography.h2),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter: High/Extreme',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildRiskItem(
            id: 'RSK-102',
            title: 'Critical systems ransomware attack',
            domain: 'IT / Cyber Security',
            owner: 'CISO / IT Dept',
            rating: 'Extreme (25)',
            status: 'Mitigation in progress',
          ),
          const Divider(height: 1),
          _buildRiskItem(
            id: 'RSK-185',
            title: 'Medication administration delay due to staffing',
            domain: 'Clinical / Patient Care',
            owner: 'Director of Nursing',
            rating: 'High (16)',
            status: 'Action Plan Active',
          ),
          const Divider(height: 1),
          _buildRiskItem(
            id: 'RSK-186',
            title: 'Vendor data privacy breach (Third-party)',
            domain: 'IT / Cyber Security',
            owner: 'Compliance Manager',
            rating: 'High (15)',
            status: 'Reviewing vendor contracts',
          ),
        ],
      ),
    );
  }

  Widget _buildRiskItem({
    required String id,
    required String title,
    required String domain,
    required String owner,
    required String rating,
    required String status,
  }) {
    Color ratingColor = rating.contains('Extreme') ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.amberWarning;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ratingColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.alertTriangle, color: ratingColor, size: 20),
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
                      fontWeight: FontWeight.bold,
                    )),
                    const SizedBox(width: 12),
                    Text(title, style: PrimeCareTheme.typography.h3),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(LucideIcons.tag, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text(domain, style: PrimeCareTheme.typography.label),
                    const SizedBox(width: 16),
                    Icon(LucideIcons.user, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text('Owner: $owner', style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
                Text(
                  rating,
                  style: PrimeCareTheme.typography.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ratingColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                const SizedBox(height: 12),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Update Status',
                  icon: LucideIcons.edit2,
                ),
             ],
          ),
        ],
      ),
    );
  }
}
