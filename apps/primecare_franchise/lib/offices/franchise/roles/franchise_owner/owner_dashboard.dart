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
      title: 'Financial Executive Summary',
      subtitle: 'Overview of franchise health and revenue tracking',
      headerTrailing: Row(
        children: [
          ClinicalGlassButton(
            label: 'Generate Report',
            icon: LucideIcons.fileText,
            onPressed: () {},
            isPrimary: false,
          ),
        ],
      ),
      kpiCards: [
        KPICardData(
          title: 'YTD Revenue',
          value: '\$1.42M',
          icon: LucideIcons.dollarSign,
          trend: 12.4,
          trendLabel: 'vs last year',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Overdue Receivables',
          value: '\$42K',
          icon: LucideIcons.alertCircle,
          trend: -5.2,
          trendLabel: 'decrease in overdue',
          color: PrimeCareTheme.colors.coralRed,
          isUp: false,
        ),
        KPICardData(
          title: 'Net Profit Margin',
          value: '22.4%',
          icon: LucideIcons.pieChart,
          trend: 2.1,
          trendLabel: 'vs last quarter',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Avg Revenue per Client',
          value: '\$3,240',
          icon: LucideIcons.users,
          trend: 4.8,
          trendLabel: 'vs last year',
          color: PrimeCareTheme.colors.emeraldTeal,
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
                    'Revenue Growth (Yoy)',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.filter,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'This Year vs Last Year',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest
                      .withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        LucideIcons.lineChart,
                        size: 48,
                        color: Colors.white24,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '[ Revenue Growth Area Chart Rendering ]',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Expense Breakdown', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 24),
              _buildExpenseItem(
                'Caregiver Payroll',
                '\$842,500',
                65,
                PrimeCareTheme.colors.navyIndigo,
              ),
              const SizedBox(height: 16),
              _buildExpenseItem(
                'Administrative Costs',
                '\$142,000',
                12,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              const SizedBox(height: 16),
              _buildExpenseItem(
                'Marketing & Sales',
                '\$98,000',
                8,
                Colors.orange,
              ),
              const SizedBox(height: 16),
              _buildExpenseItem(
                'Technology & Software',
                '\$42,000',
                4,
                Colors.blue,
              ),
              const SizedBox(height: 16),
              _buildExpenseItem(
                'Other Expenses',
                '\$120,500',
                11,
                PrimeCareTheme.colors.coralRed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem(
    String label,
    String amount,
    int percentage,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              amount,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor:
                      PrimeCareTheme.colors.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 40,
              child: Text(
                '$percentage%',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
