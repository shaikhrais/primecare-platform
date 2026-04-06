import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalAssetsScreen extends ConsumerStatefulWidget {
  const LocalAssetsScreen({super.key});

  @override
  ConsumerState<LocalAssetsScreen> createState() => _LocalAssetsScreenState();
}

class _LocalAssetsScreenState extends ConsumerState<LocalAssetsScreen> {
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
            _buildFilters(),
            const SizedBox(height: 32),
            _buildAssetGallery(),
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
              'Local Marketing Assets',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Access and download corporate-approved templates customized for your local clinic.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 300,
          child: ClinicalSearchTextField(hintText: 'Search flyers, social posts...'),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildFilterTab('All Materials', isActive: true),
              const SizedBox(width: 12),
              _buildFilterTab('Print & Mailers', isActive: false),
              const SizedBox(width: 12),
              _buildFilterTab('Social Media', isActive: false),
              const SizedBox(width: 12),
              _buildFilterTab('Digital Ads', isActive: false),
            ],
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.arrowDownToLine, size: 16),
            label: const Text('Download Selected'),
            style: OutlinedButton.styleFrom(
              foregroundColor: PrimeCareTheme.colors.navyIndigo,
              side: BorderSide(color: PrimeCareTheme.colors.surfaceContainerHighest),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, {required bool isActive}) {
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

  Widget _buildAssetGallery() {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.85,
      children: [
        _buildAssetCard(
          name: 'Q3 Wellness Check Flyer',
          type: 'Print Materials',
          format: 'PDF',
          status: 'Active',
          icon: LucideIcons.fileText,
        ),
        _buildAssetCard(
          name: 'FB Retargeting - Local',
          type: 'Social Media',
          format: 'PNG',
          status: 'Active',
          icon: LucideIcons.image,
        ),
        _buildAssetCard(
          name: 'Welcome Mailer (New Patient)',
          type: 'Direct Mail',
          format: 'PDF',
          status: 'Active',
          icon: LucideIcons.mail,
        ),
        _buildAssetCard(
          name: 'Local Event Banner',
          type: 'Print Materials',
          format: 'EPS',
          status: 'Archived',
          icon: LucideIcons.layoutTemplate,
        ),
        _buildAssetCard(
          name: 'Community Outreach Post',
          type: 'Social Media',
          format: 'JPG',
          status: 'Active',
          icon: LucideIcons.share2,
        ),
        _buildAssetCard(
          name: 'Flu Season Reminder',
          type: 'Digital Banner',
          format: 'HTML5',
          status: 'Upcoming',
          icon: LucideIcons.globe,
        ),
      ],
    );
  }

  Widget _buildAssetCard({
    required String name,
    required String type,
    required String format,
    required String status,
    required IconData icon,
  }) {
    Color statusColor;
    if (status == 'Active') {
      statusColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (status == 'Upcoming') {
      statusColor = Colors.amber.shade700;
    } else {
      statusColor = PrimeCareTheme.colors.slateGray;
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerLow,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                border: Border(bottom: BorderSide(color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5))),
              ),
              child: Center(
                child: Icon(icon, size: 48, color: PrimeCareTheme.colors.surfaceContainerHighest),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
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
                    Text(
                      format,
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.download, size: 14, color: Colors.white),
                        label: Text('Download', style: PrimeCareTheme.typography.label.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimeCareTheme.colors.navyIndigo,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
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
