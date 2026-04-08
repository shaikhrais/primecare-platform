import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswClientUpdatesScreen extends ConsumerWidget {
  const PswClientUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Client Updates',
      subtitle:
          'Real-time notifications regarding changes to your assigned clients.',
      kpiCards: [
        KPICardData(
          title: 'Unread Updates',
          value: '3',
          icon: LucideIcons.messageSquare,
          trend: 0.0,
          trendLabel: 'requires review',
        ),
        KPICardData(
          title: 'Care Plan Changes',
          value: '1',
          icon: LucideIcons.refreshCw,
          trend: 0.0,
          trendLabel: 'this week',
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recent Feed', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildUpdateCard(
                'Care Plan Updated',
                'Thurgood Marshall',
                'Medication schedule revised by RN. New AM meds added to routine.',
                '2 hours ago',
                true,
                PrimeCareTheme.colors.amberWarning,
              ),
              _buildUpdateCard(
                'Family Visit Scheduled',
                'Sonia Sotomayor',
                'Daughter arriving at 3:00 PM today. Ensure patient is ready.',
                '5 hours ago',
                true,
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildUpdateCard(
                'Routine Observation Reviewed',
                'Elena Kagan',
                'RN approved daily logs from yesterday. No action needed.',
                '1 day ago',
                false,
                PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateCard(
    String title,
    String patient,
    String detail,
    String timeAgo,
    bool isUnread,
    Color typeColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isUnread
            ? typeColor.withOpacity(0.05)
            : PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: typeColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (isUnread) ...[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: typeColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(title, style: PrimeCareTheme.typography.h3),
                ],
              ),
              Text(
                timeAgo,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                LucideIcons.user,
                size: 14,
                color: PrimeCareTheme.colors.slateGray,
              ),
              const SizedBox(width: 4),
              Text(
                patient,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(detail, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }
}
