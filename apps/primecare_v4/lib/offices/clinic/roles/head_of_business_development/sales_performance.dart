import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class SalesPerformanceScreen extends ConsumerWidget {
  const SalesPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Sales Performance',
      subtitle: 'Track team performance against quota and revenue goals.',
      kpiCards: [
        KPICardData(
          title: 'YTD Revenue Closed',
          value: '\$18.5M',
          icon: LucideIcons.barChart2,
          trend: 104.0,
          trendLabel: '% to annual quota',
        ),
        KPICardData(
          title: 'Avg Deal Size',
          value: '\$1.2M',
          icon: LucideIcons.briefcase,
          trend: 12.5,
          trendLabel: 'vs last year',
        ),
        KPICardData(
          title: 'Sales Cycle Length',
          value: '82 Days',
          icon: LucideIcons.calendarDays,
          trend: -5.4,
          trendLabel: 'shorter than avg',
        ),
        KPICardData(
          title: 'Win Rate',
          value: '38%',
          icon: LucideIcons.trophy,
          trend: 4.2,
          trendLabel: 'improvement',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Top Performers', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildRepRow('Sarah Jenkins', '125% to Quota', LucideIcons.medal, PrimeCareTheme.colors.navyIndigo),
              _buildRepRow('Michael Chang', '110% to Quota', LucideIcons.star, PrimeCareTheme.colors.emeraldTeal),
              _buildRepRow('David Ross', '105% to Quota', LucideIcons.star, PrimeCareTheme.colors.slateGray),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Win/Loss Reasons', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildReasonRow('Territory Exclusivity (Win)', '45%'),
              _buildReasonRow('Brand Reputation (Win)', '30%'),
              _buildReasonRow('Capital Requirements (Loss)', '15%'),
              _buildReasonRow('Competitor Offer (Loss)', '10%'),
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
                  Text('Team Pipeline Activity', style: PrimeCareTheme.typography.h2),
                  _buildTimeframeSelector(),
                ],
              ),
              const SizedBox(height: 24),
              _buildActivityRow(
                'Sarah Jenkins',
                'Closed Won',
                'Oakville West Franchise',
                '\$1.5M',
                'Today, 10:30 AM',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildActivityRow(
                'Michael Chang',
                'Moved to Negotiation',
                'Vancouver Central',
                '\$2.0M',
                'Yesterday, 3:15 PM',
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildActivityRow(
                'Elena Rodriguez',
                'Discovery Day Held',
                'Halifax Partner Clinic',
                '\$850K',
                'Yesterday, 9:00 AM',
                PrimeCareTheme.colors.lavenderLustre,
              ),
              _buildActivityRow(
                'David Ross',
                'Closed Lost',
                'Winnipeg South',
                '\$1.2M',
                'Oct 12, 4:45 PM',
                PrimeCareTheme.colors.coralRed,
              ),
              _buildActivityRow(
                'Sarah Jenkins',
                'Initial Meeting',
                'Calgary North',
                'TBD',
                'Oct 10, 1:00 PM',
                PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRepRow(String name, String performance, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: PrimeCareTheme.typography.body)),
          Text(performance, style: PrimeCareTheme.typography.label.copyWith(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildReasonRow(String reason, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(reason, style: PrimeCareTheme.typography.body)),
          Text(percentage, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text('This Week', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
          const SizedBox(width: 8),
          Icon(LucideIcons.chevronDown, size: 16, color: PrimeCareTheme.colors.navyIndigo),
        ],
      ),
    );
  }

  Widget _buildActivityRow(String rep, String action, String deal, String value, String time, Color actionColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
            child: Text(rep.substring(0, 1), style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(rep, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: actionColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(action, style: PrimeCareTheme.typography.label.copyWith(color: actionColor, fontSize: 10)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(deal, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(value, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600)),
          ),
          Expanded(
            flex: 1,
            child: Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray), textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
