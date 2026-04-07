import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class LocalCampaignsScreen extends ConsumerWidget {
  const LocalCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Regional Campaigns Heatmap',
      subtitle: 'Orchestrating neighborhood campaigns, clinic lead generation, and local brand presence.',
      headerTrailing: Row(
        children: [
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.download,
            label: 'Export Data',
            isPrimary: false,
          ),
          const SizedBox(width: 16),
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.plus,
            label: 'New Local Campaign',
            isPrimary: true,
          ),
        ],
      ),
      kpiCards: [
        KPICardData(
          title: 'Local Leads',
          value: '4,208',
          icon: LucideIcons.users,
          trend: 8.4,
          trendLabel: 'vs last month',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Region Reach',
          value: '1.2M',
          icon: LucideIcons.eye,
          trend: 2.1,
          trendLabel: 'vs last month',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Avg CPL',
          value: '\$82',
          icon: LucideIcons.dollarSign,
          trend: -12.0,
          trendLabel: 'vs target',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Active Campaigns',
          value: '14',
          icon: LucideIcons.flag,
          trend: 0.0,
          trendLabel: 'running',
          color: PrimeCareTheme.colors.slateGray,
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Campaign Performance Heatmap',
                      style: PrimeCareTheme.typography.h3.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.flame,
                          color: PrimeCareTheme.colors.emeraldTeal,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'High Lead Density',
                          style: PrimeCareTheme.typography.label.copyWith(
                            color: PrimeCareTheme.colors.emeraldTeal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&q=80&w=1200',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.globe,
                        size: 48,
                        color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.8),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Geospatial Heatmap Rendering...',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Active Regional Campaigns',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(height: 24),
              _buildCampaignRow(
                'Brampton: Healthy Aging',
                'Door-to-Door / Flyers',
                'ACTIVE',
                '342 Leads',
              ),
              const Divider(color: Colors.white12, height: 24),
              _buildCampaignRow(
                'Toronto: Post-Op Care',
                'Local Pharmacy Ads',
                'ACTIVE',
                '124 Leads',
              ),
              const Divider(color: Colors.white12, height: 24),
              _buildCampaignRow(
                'Vaughan: Mobility Hub',
                'Google Maps / Local',
                'PAUSED',
                '12 Leads',
                isPaused: true,
              ),

              const SizedBox(height: 48),

              Text(
                'Local Growth Feed',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(height: 16),
              _buildFeedItem(
                time: '14:32',
                action: 'Campaign Launched',
                target: 'Brampton North Expansion',
                isSuccess: true,
              ),
              _buildFeedLine(),
              _buildFeedItem(
                time: '11:15',
                action: 'Budget Alert',
                target: 'Toronto: Post-Op Care at 90%',
                isSuccess: false,
              ),
              _buildFeedLine(),
              _buildFeedItem(
                time: '09:00',
                action: 'Milestone Reached',
                target: '100th Lead in Vaughan',
                isSuccess: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignRow(
    String title,
    String type,
    String status,
    String performance, {
    bool isPaused = false,
  }) {
    Color iconColor = isPaused ? PrimeCareTheme.colors.slateGray : PrimeCareTheme.colors.emeraldTeal;
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            LucideIcons.store,
            color: iconColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                type,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              performance,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
            Text(
              status,
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeedLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 19),
      child: Container(
        height: 24,
        width: 2,
        color: PrimeCareTheme.colors.surfaceContainerHighest,
      ),
    );
  }

  Widget _buildFeedItem({
    required String time,
    required String action,
    required String target,
    required bool isSuccess,
  }) {
    Color stateColor = isSuccess ? PrimeCareTheme.colors.emeraldTeal : Colors.amber.shade700;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            time,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: stateColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isSuccess ? LucideIcons.checkCircle : LucideIcons.alertTriangle,
            size: 16,
            color: stateColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                action,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                target,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
