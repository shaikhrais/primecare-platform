import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class BrandAssetsScreen extends ConsumerWidget {
  const BrandAssetsScreen({super.key});

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
                      'Brand Assets',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'A library of approved digital assets, logos, and collateral.',
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
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logos & Typography', style: PrimeCareTheme.typography.h2),
                      ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.upload, label: 'Upload New'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildAssetCard('Primary Logo (Dark)', 'SVG, PNG', LucideIcons.image),
                      _buildAssetCard('Primary Logo (Light)', 'SVG, PNG', LucideIcons.image),
                      _buildAssetCard('Brand Fonts Package', 'OTF, TTF', LucideIcons.type),
                      _buildAssetCard('Clinical Color Palette', 'ASE, PDF', LucideIcons.palette),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Marketing Collateral', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildAssetCard('Print Brochures v3', 'PDF', LucideIcons.fileText),
                _buildAssetCard('Social Media Templates', 'PSD, FIG', LucideIcons.layout),
                _buildAssetCard('Email Signatures', 'HTML', LucideIcons.mail),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: PrimeCareTheme.colors.navyIndigo, size: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: PrimeCareTheme.typography.h3, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(format, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  Icon(LucideIcons.download, size: 16, color: PrimeCareTheme.colors.emeraldTeal),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
