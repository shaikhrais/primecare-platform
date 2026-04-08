import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TerritoryMapScreen extends ConsumerWidget {
  const TerritoryMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Territory Atlas',
      subtitle:
          'Geospatial representation of clinical expansion zones and pipeline activity.',
      kpiCards: [
        KPICardData(
          title: 'Total Opportunity Value',
          value: '\$24.8M',
          icon: LucideIcons.dollarSign,
          trend: 12.5,
          trendLabel: 'vs last quarter',
        ),
        KPICardData(
          title: 'Lead Conversion Rate',
          value: '18.5%',
          icon: LucideIcons.barChart2,
          trend: 2.1,
          trendLabel: 'rolling 30 days',
        ),
        KPICardData(
          title: 'Active Expansion Leads',
          value: '142',
          icon: LucideIcons.users,
          trend: 8.0,
          trendLabel: 'qualified leads',
        ),
        KPICardData(
          title: 'Strategic Priorities',
          value: '4',
          icon: LucideIcons.target,
          trend: 0.0,
          trendLabel: 'focus regions',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Expansion Pipeline', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 24),
              _buildPipelineRow(
                'Discovery',
                45,
                PrimeCareTheme.colors.slateGray,
              ),
              _buildPipelineRow(
                'Qualified',
                32,
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildPipelineRow(
                'Negotiation',
                18,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildPipelineRow(
                'Closed Won',
                12,
                PrimeCareTheme.colors.tealEmerald,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Market Dynamics', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterToggle(
                'Show Competitors',
                true,
                PrimeCareTheme.colors.coralRed,
              ),
              _buildFilterToggle(
                'Show Open Whitespace',
                true,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildFilterToggle(
                'Show Corporate Clinics',
                false,
                PrimeCareTheme.colors.navyIndigo,
              ),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(0), // No padding for full map impact
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Geospatial Expansion Map',
                      style: PrimeCareTheme.typography.h2,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(LucideIcons.filter),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.maximize2),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Map Visual Area
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest
                      .withOpacity(0.3),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://via.placeholder.com/1200x500/0f172a/00685b?text=Geospatial+Territory+Atlas',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClinicalGlassButton(
                      label: 'Recenter Map',
                      icon: LucideIcons.crosshair,
                      onPressed: () {},
                      isPrimary: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Strategic Growth Targets',
                style: PrimeCareTheme.typography.h3,
              ),
              const SizedBox(height: 24),
              _buildTargetProgress(
                'EMEA Oncology Hubs',
                0.65,
                '\$4.2M / \$6.5M',
              ),
              const SizedBox(height: 16),
              _buildTargetProgress(
                'APAC Genomic Labs',
                0.32,
                '\$1.8M / \$5.6M',
              ),
              const SizedBox(height: 16),
              _buildTargetProgress(
                'North America Primary Care',
                0.88,
                '\$12.5M / \$14.2M',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPipelineRow(String stage, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(stage, style: PrimeCareTheme.typography.body)),
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

  Widget _buildFilterToggle(String label, bool value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            value ? LucideIcons.checkSquare : LucideIcons.square,
            color: value ? color : PrimeCareTheme.colors.slateGray,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(label, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }

  Widget _buildTargetProgress(String target, double progress, String valueStr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              target,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(valueStr, style: PrimeCareTheme.typography.label),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(
            PrimeCareTheme.colors.emeraldTeal,
          ),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
