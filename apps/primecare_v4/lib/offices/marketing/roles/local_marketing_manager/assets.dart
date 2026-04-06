import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalAssetsScreen extends ConsumerWidget {
  const LocalAssetsScreen({super.key});

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
                      'Local Brand Assets',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Download approved branding and templates for local use.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalSearchTextField(hintText: 'Search assets...'),
              ],
            ),
            const SizedBox(height: 32),
            Text('Quick Downloads', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.0,
              children: [
                 _buildAssetCard('Clinic Logo Pack', 'SVG/PNG', LucideIcons.image),
                 _buildAssetCard('Standard Intake Form', 'PDF', LucideIcons.fileText),
                 _buildAssetCard('Corporate Fonts', 'ZIP', LucideIcons.downloadCloud),
              ],
            ),
             const SizedBox(height: 32),
            Text('Promotional Templates', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.0,
              children: [
                 _buildAssetCard('Facebook Ad Template', 'PSD', LucideIcons.facebook),
                 _buildAssetCard('Grand Opening Flyer', 'PDF', LucideIcons.layout),
                 _buildAssetCard('Local Email Header', 'PNG', LucideIcons.mail),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetCard(String title, String format, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: PrimeCareTheme.typography.h3),
                  Text(format, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                ],
              ),
            ],
          ),
          Icon(LucideIcons.download, size: 20, color: PrimeCareTheme.colors.emeraldTeal),
        ],
      ),
    );
  }
}
