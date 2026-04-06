import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ClientHistoryScreen extends ConsumerWidget {
  const ClientHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Client History',
      subtitle: 'Comprehensive longitudinal health records and clinical history.',
      kpiCards: [
        KPICardData(
          title: 'Total Records Viewed',
          value: '42',
          icon: LucideIcons.history,
          trend: 15.0,
          trendLabel: 'this week',
        ),
        KPICardData(
          title: 'Missing Docs',
          value: '3',
          icon: LucideIcons.fileWarning,
          trend: -1.0,
          trendLabel: 'resolved today',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Available Views', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildViewSelector('Comprehensive Summary', true),
              _buildViewSelector('Encounter History', false),
              _buildViewSelector('Medication History', false),
              _buildViewSelector('Lab Results', false),
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
                  Text('Timeline of Encounters', style: PrimeCareTheme.typography.h2),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: 24),
              _buildTimelineEvent(
                'Home Care Visit',
                'Completed by: Sarah Jenkins, RN',
                'Oct 12, 2026',
                'Wound care performed on lower right extremity. Dressing changed. No signs of infection. Client reported pain level 2/10.',
                LucideIcons.home,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildTimelineEvent(
                'Telehealth Follow-up',
                'Completed by: Dr. Aris Thorne',
                'Oct 05, 2026',
                'Medication review. Adjusted Lisinopril dosage due to reported dizziness.',
                LucideIcons.video,
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildTimelineEvent(
                'Initial Assessment',
                'Completed by: Sarah Jenkins, RN',
                'Sep 28, 2026',
                'Comprehensive admission assessment. Fall risk identified. Care plan established.',
                LucideIcons.clipboardCheck,
                PrimeCareTheme.colors.lavenderLustre,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildViewSelector(String name, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? PrimeCareTheme.colors.navyIndigo.withOpacity(0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: PrimeCareTheme.typography.body.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? PrimeCareTheme.colors.navyIndigo : PrimeCareTheme.colors.textPrimary,
            ),
          ),
          if (isSelected)
            Icon(LucideIcons.chevronRight, size: 16, color: PrimeCareTheme.colors.navyIndigo),
        ],
      ),
    );
  }

  Widget _buildTimelineEvent(String title, String subtitle, String date, String details, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: PrimeCareTheme.typography.h3),
                    Text(date, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                  ),
                  child: Text(details, style: PrimeCareTheme.typography.body),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
