import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class BrandAssetsScreen extends ConsumerStatefulWidget {
  const BrandAssetsScreen({super.key});

  @override
  ConsumerState<BrandAssetsScreen> createState() => _BrandAssetsScreenState();
}

class _BrandAssetsScreenState extends ConsumerState<BrandAssetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildAssetFilters(),
            const SizedBox(height: 32),
            _buildAssetGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Brand Assets Hub',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage and distribute approved PrimeCare logos, brand guidelines, and marketing collateral.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.downloadCloud,
              label: 'Download Brand Kit',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.upload,
              label: 'Upload New Asset',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAssetFilters() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildFilterChip('All Assets', isActive: true),
              const SizedBox(width: 12),
              _buildFilterChip('Logos', isActive: false),
              const SizedBox(width: 12),
              _buildFilterChip('Print Templates', isActive: false),
              const SizedBox(width: 12),
              _buildFilterChip('Digital Ads', isActive: false),
              const SizedBox(width: 12),
              _buildFilterChip('Social Media', isActive: false),
            ],
          ),
          SizedBox(
            width: 300,
            child: ClinicalSearchTextField(hintText: 'Search assets by name or tag...'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {required bool isActive}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? PrimeCareTheme.colors.navyIndigo : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? PrimeCareTheme.colors.navyIndigo : PrimeCareTheme.colors.surfaceContainerHighest,
          ),
        ),
        child: Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(
            color: isActive ? Colors.white : PrimeCareTheme.colors.slateGray,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAssetGrid() {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.8,
      children: [
        _buildAssetCard(
          name: 'Primary Logo (Dark)',
          category: 'Logos',
          status: 'Approved',
          icon: LucideIcons.image,
          size: '1.2 MB',
          date: 'Updated Oct 12',
          extension: 'PNG',
        ),
        _buildAssetCard(
          name: 'Primary Logo (Light)',
          category: 'Logos',
          status: 'Approved',
          icon: LucideIcons.image,
          size: '1.1 MB',
          date: 'Updated Oct 12',
          extension: 'PNG',
        ),
        _buildAssetCard(
          name: 'Q3 Flyer Template',
          category: 'Print Templates',
          status: 'Pending',
          icon: LucideIcons.fileText,
          size: '15 MB',
          date: 'Updated Nov 02',
          extension: 'PDF',
        ),
        _buildAssetCard(
          name: 'Facebook Ad - Flu Shot',
          category: 'Digital Ads',
          status: 'Approved',
          icon: LucideIcons.share2,
          size: '540 KB',
          date: 'Updated Nov 05',
          extension: 'JPG',
        ),
        _buildAssetCard(
          name: 'Brand Typography Guidelines',
          category: 'Logos & Brand',
          status: 'Archived',
          icon: LucideIcons.type,
          size: '3 MB',
          date: 'Updated Jan 15',
          extension: 'PDF',
        ),
        _buildAssetCard(
          name: 'LinkedIn Ad - B2B Wellness',
          category: 'Digital Ads',
          status: 'Pending',
          icon: LucideIcons.target,
          size: '1.5 MB',
          date: 'Updated Nov 08',
          extension: 'PSD',
        ),
      ],
    );
  }

  Widget _buildAssetCard({
    required String name,
    required String category,
    required String status,
    required IconData icon,
    required String size,
    required String date,
    required String extension,
  }) {
    Color statusColor;
    if (status == 'Approved') {
      statusColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (status == 'Pending') {
      statusColor = Colors.amber.shade700;
    } else {
      statusColor = PrimeCareTheme.colors.slateGray;
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview Area
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerLow,
                border: Border(
                  bottom: BorderSide(
                    color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5),
                  ),
                ),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Center(
                child: Icon(icon, size: 64, color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.8)),
              ),
            ),
          ),
          // Details Area
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        extension,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: PrimeCareTheme.typography.base.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$category • $size',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                        fontSize: 11,
                      ),
                    ),
                    Icon(LucideIcons.download, size: 16, color: PrimeCareTheme.colors.secondary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
