import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswCompletedVisitsScreen extends ConsumerWidget {
  const PswCompletedVisitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Completed Visits',
      subtitle: 'Archive of past visits, verified hours, and client sign-offs.',
      kpiCards: [
        KPICardData(
          title: 'Visits This Week',
          value: '18',
          icon: LucideIcons.calendarCheck,
          trend: 0.0,
          trendLabel: 'completed',
        ),
        KPICardData(
          title: 'Client Sign-offs',
          value: '100%',
          icon: LucideIcons.penTool,
          trend: 0.0,
          trendLabel: 'verified',
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
                  Text('Visit Archive', style: PrimeCareTheme.typography.h2),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.filter),
                    label: const Text('Filter'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildVisitRow(
                'Thurgood Marshall',
                'Mar 24, 2026',
                '11:00 AM - 1:00 PM',
                '2.0 hrs',
                true,
              ),
              _buildVisitRow(
                'Sonia Sotomayor',
                'Mar 24, 2026',
                '08:00 AM - 10:00 AM',
                '2.0 hrs',
                true,
              ),
              _buildVisitRow(
                'Elena Kagan',
                'Mar 23, 2026',
                '02:00 PM - 05:00 PM',
                '3.0 hrs',
                true,
              ),
              _buildVisitRow(
                'Ruth Bader Ginsburg',
                'Mar 23, 2026',
                '09:00 AM - 1:00 PM',
                '4.0 hrs',
                true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVisitRow(
    String name,
    String date,
    String time,
    String duration,
    bool signedOff,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Row(
        children: [
          Icon(
            LucideIcons.calendarCheck,
            color: PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: PrimeCareTheme.typography.h3),
                Text(
                  date,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: PrimeCareTheme.typography.body),
                Text(
                  'Verified duration: $duration',
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          if (signedOff)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.check,
                    size: 14,
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Signed Off',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
