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
      title: 'Care Documents',
      subtitle: 'Access client care plans, agency policies, and specific instructions.',
      kpiCards: [
         KPICardData(title: 'New Documents', value: '1', icon: LucideIcons.filePlus, trend: 1.0, trendLabel: 'this week'),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Document Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Care Plans', PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('Agency Policies', PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('Home Entry Info', PrimeCareTheme.colors.lavenderLustre),
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
                   Text('Document Library', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.search),
                    label: const Text('Search Library'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                      foregroundColor: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildDocCard('Sonia Sotomayor Care Plan', 'Care Plans', 'Updated: May 10, 2024', PrimeCareTheme.colors.emeraldTeal),
               _buildDocCard('Elena Kagan Entry Instructions', 'Home Entry Info', 'Updated: April 22, 2024', PrimeCareTheme.colors.lavenderLustre),
               _buildDocCard('Infection Control Policy 2024', 'Agency Policies', 'Updated: Jan 15, 2024', PrimeCareTheme.colors.navyIndigo),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
               Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocCard(String docName, String category, String date, Color themeColor) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                Row(
                  children: [
                    Icon(LucideIcons.fileText, color: themeColor, size: 20),
                    const SizedBox(width: 8),
                    Text(docName, style: PrimeCareTheme.typography.h3),
                  ]
                ),
                const SizedBox(height: 8),
                Text('$category • $date', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
             ],
           ),
           IconButton(
             icon: const Icon(LucideIcons.download),
             color: PrimeCareTheme.colors.navyIndigo,
             onPressed: () {},
           )
        ],
      )
     );
  }
}
