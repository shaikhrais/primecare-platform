import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswDocumentsScreen extends ConsumerWidget {
  const PswDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Resource Library',
      subtitle:
          'Access safety manuals, care plan definitions, and standard operating procedures.',
      kpiCards: [
        KPICardData(
          title: 'Unread Polices',
          value: '2',
          icon: LucideIcons.bell,
          trend: 0.0,
          trendLabel: 'action required',
        ),
        KPICardData(
          title: 'Care Plans',
          value: '12',
          icon: LucideIcons.files,
          trend: 0.0,
          trendLabel: 'active',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Categories', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildCategory('Patient Care Plans', true),
              _buildCategory('Safety Protocols', false),
              _buildCategory('HR & Compliance', false),
              _buildCategory('Training Materials', false),
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
              Text('Patient Care Plans', style: PrimeCareTheme.typography.h2),
              const SizedBox(height: 24),
              _buildDocItem(
                'Dementia Support Protocol - Level 2',
                'PDF • 2.4 MB',
                LucideIcons.fileText,
              ),
              _buildDocItem(
                'Post-Op Mobility Guidelines',
                'PDF • 1.1 MB',
                LucideIcons.fileText,
              ),
              _buildDocItem(
                'Dietary Restrictions & Feeding Assistance',
                'DOCX • 500 KB',
                LucideIcons.fileType2,
              ),
              _buildDocItem(
                'Emergency Evacuation Plan for Bedbound Clients',
                'PDF • 3.2 MB',
                LucideIcons.fileText,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategory(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimeCareTheme.colors.navyIndigo.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? PrimeCareTheme.colors.navyIndigo
                : PrimeCareTheme.colors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildDocItem(String title, String subtitle, IconData icon) {
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PrimeCareTheme.typography.h3),
                Text(
                  subtitle,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              LucideIcons.download,
              color: PrimeCareTheme.colors.slateGray,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
