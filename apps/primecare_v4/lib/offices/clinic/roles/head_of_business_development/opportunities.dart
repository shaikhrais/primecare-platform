import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class OpportunitiesScreen extends ConsumerWidget {
  const OpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Growth Opportunities',
      subtitle: 'Identify and track potential market expansions and acquisitions.',
      kpiCards: [
        KPICardData(
          title: 'Total Potential Value',
          value: '\$15.8M',
          icon: LucideIcons.trendingUp,
          trend: 12.5,
          trendLabel: 'identified vs last Q',
        ),
        KPICardData(
          title: 'M&A Targets',
          value: '8',
          icon: LucideIcons.building,
          trend: 2.0,
          trendLabel: 'new this week',
        ),
        KPICardData(
          title: 'New Markets',
          value: '4',
          icon: LucideIcons.map,
          trend: 0.0,
          trendLabel: 'in feasibility study',
        ),
        KPICardData(
          title: 'Win Rate',
          value: '42%',
          icon: LucideIcons.target,
          trend: 5.4,
          trendLabel: 'historical avg',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Opportunity Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildTypeRow('Mergers & Acquisitions', '45%'),
              _buildTypeRow('New Franchise Territories', '30%'),
              _buildTypeRow('Strategic Partnerships', '15%'),
              _buildTypeRow('Service Expansions', '10%'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Feasibility Stage', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFeasibilityRow('Initial Scoping', 12),
              _buildFeasibilityRow('Market Analysis', 8),
              _buildFeasibilityRow('Financial Modeling', 5),
              _buildFeasibilityRow('Executive Review', 2),
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
              Text('High Priority Opportunities', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildOpportunityCard(
                'Oakbridge Clinic Acquisition',
                'Mergers & Acquisitions',
                '\$3.2M',
                'Financial Modeling',
                'High probability. Awaiting Q2 financials from target.',
                PrimeCareTheme.colors.coralRed,
              ),
              _buildOpportunityCard(
                'Vancouver Island Expansion',
                'New Franchise Territory',
                '\$1.5M',
                'Market Analysis',
                'Demographics look strong. Competitor presence is low.',
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildOpportunityCard(
                'National Pharmacy Partnership',
                'Strategic Partnerships',
                '\$5.0M',
                'Executive Review',
                'Drafting MoU for pilot program in 5 locations.',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildOpportunityCard(
                'Telehealth Platform Integration',
                'Service Expansion',
                '\$800K',
                'Initial Scoping',
                'Reviewing API compatibility with current systems.',
                PrimeCareTheme.colors.lavenderLustre,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypeRow(String type, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(type, style: PrimeCareTheme.typography.body)),
          Text(percentage, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildFeasibilityRow(String stage, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(stage, style: PrimeCareTheme.typography.body),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: PrimeCareTheme.typography.label,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityCard(String title, String type, String value, String stage, String notes, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: PrimeCareTheme.typography.h3),
              Text(value, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: PrimeCareTheme.typography.label.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Icon(LucideIcons.arrowRight, size: 14, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 12),
              Text(stage, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
          const SizedBox(height: 16),
          Text(notes, style: PrimeCareTheme.typography.body.copyWith(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
