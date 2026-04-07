import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Franchise Dashboard',
      subtitle: 'Executive overview of clinical and financial operations',
      icon: LucideIcons.building,
      actions: [
        Container(
          decoration: BoxDecoration(
            color: PrimeCareTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  LucideIcons.calendar,
                  color: PrimeCareTheme.onSurfaceVariant,
                ),
                onPressed: () {},
              ),
              Text('Today, Oct 6', style: PrimeCareTheme.labelMedium),
              const SizedBox(width: PrimeCareTheme.spacing3),
            ],
          ),
        ),
        const SizedBox(width: PrimeCareTheme.spacing3),
        Container(
          decoration: BoxDecoration(
            color: PrimeCareTheme.primaryContainer,
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
          ),
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: PrimeCareTheme.spacing5,
                vertical: PrimeCareTheme.spacing3,
              ),
            ),
            icon: const Icon(
              LucideIcons.download,
              color: PrimeCareTheme.primary,
            ),
            label: Text(
              'Export Report',
              style: PrimeCareTheme.titleSmall.copyWith(
                color: PrimeCareTheme.primary,
              ),
            ),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Row: Financial & Daily Ops Summaries
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: _buildFinancialSection()),
                const SizedBox(width: PrimeCareTheme.spacing5),
                Expanded(flex: 4, child: _buildDailyOpsSection()),
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Bottom Row: CSAT & Marketing
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildCustomerSatisfactionSection()),
                const SizedBox(width: PrimeCareTheme.spacing5),
                Expanded(child: _buildMarketingOversightSection()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialSection() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    LucideIcons.dollarSign,
                    color: PrimeCareTheme.primary,
                  ),
                  const SizedBox(width: PrimeCareTheme.spacing3),
                  Text('Financial Snapshot', style: PrimeCareTheme.titleLarge),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View Ledger',
                  style: PrimeCareTheme.labelLarge.copyWith(
                    color: PrimeCareTheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: PrimeCareTheme.spacing5),

          Row(
            children: [
              Expanded(
                child: _buildMetricBlock(
                  label: 'Gross Rev (MTD)',
                  value: '\$142,500',
                  trend: '+12.4%',
                  trendPositive: true,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: PrimeCareTheme.outlineVariant,
              ),
              Expanded(
                child: _buildMetricBlock(
                  label: 'Op Expenses',
                  value: '\$84,200',
                  trend: '-2.1%',
                  trendPositive: true,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: PrimeCareTheme.outlineVariant,
              ),
              Expanded(
                child: _buildMetricBlock(
                  label: 'Net Margin',
                  value: '40.9%',
                  trend: '+4.5%',
                  trendPositive: true,
                  highlightGlow: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: PrimeCareTheme.spacing6),

          // Placeholder for Revenue Chart
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: PrimeCareTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd),
            ),
            child: const Center(
              child: Text(
                '[ Revenue vs Target Line Chart ]',
                style: TextStyle(color: PrimeCareTheme.onSurfaceVariant),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyOpsSection() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.activity, color: PrimeCareTheme.tertiary),
              const SizedBox(width: PrimeCareTheme.spacing3),
              Text('Real-time Operations', style: PrimeCareTheme.titleLarge),
            ],
          ),
          const SizedBox(height: PrimeCareTheme.spacing5),

          _buildOpsRow(
            LucideIcons.checkSquare,
            'Appointments Today',
            '142',
            '96% Full',
          ),
          const SizedBox(height: PrimeCareTheme.spacing4),
          _buildOpsRow(
            LucideIcons.users,
            'Staff on Duty',
            '28 / 30',
            '2 Call-outs',
          ),
          const SizedBox(height: PrimeCareTheme.spacing4),
          _buildOpsRow(
            LucideIcons.alertCircle,
            'Pending Issue Reports',
            '3',
            'Urgent',
            isWarning: true,
          ),

          const SizedBox(height: PrimeCareTheme.spacing6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimeCareTheme.surfaceContainerHigh,
                foregroundColor: PrimeCareTheme.onSurface,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {},
              child: const Text('Open Operations Center'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerSatisfactionSection() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.heart, color: PrimeCareTheme.error),
              const SizedBox(width: PrimeCareTheme.spacing3),
              Text('Customer Satisfaction', style: PrimeCareTheme.titleLarge),
            ],
          ),
          const SizedBox(height: PrimeCareTheme.spacing5),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '4.8',
                      style: PrimeCareTheme.headlineLarge.copyWith(
                        color: PrimeCareTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Average CSAT',
                      style: PrimeCareTheme.labelMedium.copyWith(
                        color: PrimeCareTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '+72',
                      style: PrimeCareTheme.headlineLarge.copyWith(
                        color: PrimeCareTheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Net Promoter Score',
                      style: PrimeCareTheme.labelMedium.copyWith(
                        color: PrimeCareTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: PrimeCareTheme.spacing5),

          Text('Recent Feedback', style: PrimeCareTheme.titleMedium),
          const SizedBox(height: PrimeCareTheme.spacing3),
          _buildFeedbackRow('Excellent care from Arthur today!', 5),
          const SizedBox(height: PrimeCareTheme.spacing2),
          _buildFeedbackRow('Wait time was a bit long.', 3),
        ],
      ),
    );
  }

  Widget _buildMarketingOversightSection() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.target, color: PrimeCareTheme.primary),
              const SizedBox(width: PrimeCareTheme.spacing3),
              Text('Marketing Oversight', style: PrimeCareTheme.titleLarge),
            ],
          ),
          const SizedBox(height: PrimeCareTheme.spacing5),

          _buildMarketingRow('Fall Checkup Campaign', 'Active', '+120 Leads'),
          const SizedBox(height: PrimeCareTheme.spacing3),
          _buildMarketingRow('Senior Wellness Local', 'Completed', 'ROI: 240%'),
          const SizedBox(height: PrimeCareTheme.spacing3),
          _buildMarketingRow('Facebook Retargeting', 'Active', 'CAC: \$42'),

          const SizedBox(height: PrimeCareTheme.spacing5),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.arrowRight, size: 16),
            label: const Text('View Marketing Dashboard'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBlock({
    required String label,
    required String value,
    required String trend,
    required bool trendPositive,
    bool highlightGlow = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PrimeCareTheme.spacing4),
      decoration: highlightGlow
          ? BoxDecoration(
              radialGradient: RadialGradient(
                colors: [
                  PrimeCareTheme.primary.withOpacity(0.15),
                  Colors.transparent,
                ],
                radius: 1.5,
              ),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: PrimeCareTheme.labelMedium.copyWith(
              color: PrimeCareTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: PrimeCareTheme.spacing2),
          Text(
            value,
            style: PrimeCareTheme.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: PrimeCareTheme.onSurface,
            ),
          ),
          const SizedBox(height: PrimeCareTheme.spacing2),
          Row(
            children: [
              Icon(
                trendPositive
                    ? LucideIcons.trendingUp
                    : LucideIcons.trendingDown,
                size: 16,
                color: trendPositive
                    ? PrimeCareTheme.tertiary
                    : PrimeCareTheme.error,
              ),
              const SizedBox(width: PrimeCareTheme.spacing1),
              Text(
                trend,
                style: PrimeCareTheme.labelSmall.copyWith(
                  color: trendPositive
                      ? PrimeCareTheme.tertiary
                      : PrimeCareTheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpsRow(
    IconData icon,
    String title,
    String val1,
    String val2, {
    bool isWarning = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isWarning
                ? PrimeCareTheme.errorContainer
                : PrimeCareTheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isWarning
                ? PrimeCareTheme.error
                : PrimeCareTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: PrimeCareTheme.spacing4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: PrimeCareTheme.titleSmall),
              Text(
                val2,
                style: PrimeCareTheme.labelSmall.copyWith(
                  color: isWarning
                      ? PrimeCareTheme.error
                      : PrimeCareTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Text(
          val1,
          style: PrimeCareTheme.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackRow(String comment, int stars) {
    return Container(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing3),
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                LucideIcons.star,
                size: 14,
                color: index < stars
                    ? PrimeCareTheme.tertiary
                    : PrimeCareTheme.outlineVariant,
              ),
            ),
          ),
          const SizedBox(width: PrimeCareTheme.spacing3),
          Expanded(
            child: Text(
              '"$comment"',
              style: PrimeCareTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketingRow(String campaign, String status, String metric) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(campaign, style: PrimeCareTheme.titleSmall),
            Text(
              status,
              style: PrimeCareTheme.labelSmall.copyWith(
                color: PrimeCareTheme.primary,
              ),
            ),
          ],
        ),
        Text(
          metric,
          style: PrimeCareTheme.labelMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
