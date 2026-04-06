import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class LeadPipelineScreen extends ConsumerWidget {
  const LeadPipelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Lead Pipeline',
      subtitle: 'Manage and orchestrate incoming PrimeCare franchise leads.',
      kpiCards: [
        KPICardData(
          title: 'Total Pipeline Value',
          value: '\$4.2M',
          icon: LucideIcons.dollarSign,
          trend: 15.2,
          trendLabel: 'vs last month',
        ),
        KPICardData(
          title: 'Active Leads',
          value: '34',
          icon: LucideIcons.users,
          trend: 5.4,
          trendLabel: 'vs last week',
        ),
        KPICardData(
          title: 'Conversion Rate',
          value: '12%',
          icon: LucideIcons.trendingUp,
          trend: 2.1,
          trendLabel: 'vs last quarter',
        ),
        KPICardData(
          title: 'Time to Close',
          value: '45d',
          icon: LucideIcons.clock,
          trend: -10.5,
          trendLabel: 'improvement',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pipeline Funnel', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFunnelStage('Inquiry', '150 Leads', 1.0, PrimeCareTheme.colors.navyIndigo),
              _buildFunnelStage('Qualified', '75 Leads', 0.5, PrimeCareTheme.colors.emeraldTeal),
              _buildFunnelStage('Negotiation', '25 Leads', 0.16, PrimeCareTheme.colors.coralRed),
              _buildFunnelStage('Closed', '10 Leads', 0.06, PrimeCareTheme.colors.lavenderLustre),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lead Sources', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildSourceRow('Referrals', '45%'),
              _buildSourceRow('Website Conversion', '30%'),
              _buildSourceRow('Cold Outreach', '15%'),
              _buildSourceRow('Events & Tradeshows', '10%'),
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
                  Text('Active Lead Opportunities', style: PrimeCareTheme.typography.h2),
                  _buildFilterButton(),
                ],
              ),
              const SizedBox(height: 24),
              _buildLeadRow('Dr. Emily Chen', 'Toronto, ON', 'High', 'Qualified', '\$1.2M', 'Contacted 2 days ago'),
              _buildLeadRow('Mark Johnson', 'Vancouver, BC', 'Medium', 'Inquiry', '\$800K', 'New Inquiry'),
              _buildLeadRow('Sarah Peterson', 'Calgary, AB', 'High', 'Negotiation', '\$1.5M', 'Sending draft agreement'),
              _buildLeadRow('Dr. Rajesh Patel', 'Mississauga, ON', 'Very High', 'Closed', '\$2.0M', 'Onboarding phase'),
              _buildLeadRow('Prime Health Group', 'Ottawa, ON', 'Medium', 'Qualified', '\$3.5M', 'Reviewing financials'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFunnelStage(String label, String count, double fill, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600)),
              Text(count, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              widthFactor: fill,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceRow(String source, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(source, style: PrimeCareTheme.typography.body),
          Text(percentage, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600)),
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
          Text('Filter', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
        ],
      ),
    );
  }

  Widget _buildLeadRow(String name, String location, String priority, String stage, String value, String lastAction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(LucideIcons.mapPin, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text(location, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expected Value', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 4),
                Text(value, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: priority == 'High' || priority == 'Very High' 
                        ? PrimeCareTheme.colors.coralRed.withOpacity(0.1) 
                        : PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    priority,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: priority == 'High' || priority == 'Very High' 
                          ? PrimeCareTheme.colors.coralRed 
                          : PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(lastAction, style: PrimeCareTheme.typography.label.copyWith(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
