import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Documents',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Access protocol manuals, training guides, and timesheets.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalSearchTextField(
                  hintText: 'Search documents...',
                ),
              ],
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: [
                _buildDocumentCard('PSW Protocol Manual', 'PDF • 2.4 MB • Updated Aug 10', LucideIcons.book),
                _buildDocumentCard('Emergency Procedures', 'PDF • 1.1 MB • Updated Jan 05', LucideIcons.alertTriangle),
                _buildDocumentCard('Timesheet Template', 'XLSX • 0.5 MB • Updated Sep 01', LucideIcons.tableRowsSplit),
                _buildDocumentCard('Dementia Care Guide', 'PDF • 4.8 MB • Updated Mar 15', LucideIcons.brain),
                _buildDocumentCard('WHMIS Certificate', 'PDF • 1.0 MB • Expires 2027', LucideIcons.award),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard(String title, String subtitle, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: PrimeCareTheme.typography.h3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(LucideIcons.downloadCloud, color: PrimeCareTheme.colors.emeraldTeal),
          ),
        ],
      ),
    );
  }
}
