import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnNotesScreen extends ConsumerWidget {
  const RpnNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'RPN Field Notes',
      subtitle: 'Ad-hoc clinical observations and reminders.',
      kpiCards: [
        KPICardData(
          title: 'Notes',
          value: '6',
          icon: LucideIcons.clipboardEdit,
          trend: 0.0,
          trendLabel: 'active',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tags', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildTag('Follow-up', PrimeCareTheme.colors.coralRed),
              _buildTag('Pharmacy', PrimeCareTheme.colors.navyIndigo),
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
              Text('Quick Notes', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildNoteItem(
                'Check with pharmacy regarding John\'s prescription refill status (Lisinopril).',
                'Pharmacy',
              ),
              _buildNoteItem(
                'Remember to chart Maria\'s dietary intake for lunch.',
                'Follow-up',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: PrimeCareTheme.typography.label.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNoteItem(String text, String tag) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: PrimeCareTheme.colors.slateGray.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tag,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                LucideIcons.moreHorizontal,
                size: 16,
                color: PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(text, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }
}
