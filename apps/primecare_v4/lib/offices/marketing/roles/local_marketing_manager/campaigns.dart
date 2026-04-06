import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalCampaignsScreen extends ConsumerStatefulWidget {
  const LocalCampaignsScreen({super.key});

  @override
  ConsumerState<LocalCampaignsScreen> createState() => _LocalCampaignsScreenState();
}

class _LocalCampaignsScreenState extends ConsumerState<LocalCampaignsScreen> {
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
            _buildCampaignsGrid(),
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
              'Local Campaigns',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage and monitor local marketing campaigns running in your territory.',
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
              icon: LucideIcons.calendar,
              label: 'View Calendar',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Launch New Campaign',
              isActive: true,
            ),
          ],
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
              _buildFilterTab('All Campaigns', isActive: true),
              const SizedBox(width: 12),
              _buildFilterTab('Active', isActive: false),
              const SizedBox(width: 12),
              _buildFilterTab('Scheduled', isActive: false),
              const SizedBox(width: 12),
              _buildFilterTab('Completed', isActive: false),
            ],
          ),
          SizedBox(
            width: 300,
            child: ClinicalSearchTextField(hintText: 'Search campaigns...'),
          ),
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

  Widget _buildCampaignsGrid() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      children: [
        _buildCampaignCard(
          title: 'Fall Flu Shot Awareness',
          status: 'Active',
          channel: 'Omnichannel (Social + Print)',
          dates: 'Sep 01 - Oct 31, 2026',
          reach: 12500,
          spend: 1200.0,
          budget: 1500.0,
        ),
        _buildCampaignCard(
          title: 'Back to School Physicals',
          status: 'Completed',
          channel: 'Digital Ads',
          dates: 'Aug 01 - Sep 15, 2026',
          reach: 45000,
          spend: 2500.0,
          budget: 2500.0,
        ),
        _buildCampaignCard(
          title: 'Senior Health Check Prep',
          status: 'Scheduled',
          channel: 'Direct Mail',
          dates: 'Nov 01 - Nov 30, 2026',
          reach: 0,
          spend: 0.0,
          budget: 850.0,
        ),
        _buildCampaignCard(
          title: 'Weekend Walk-in Promo',
          status: 'Active',
          channel: 'Local SEO / Search',
          dates: 'Ongoing',
          reach: 8900,
          spend: 420.0,
          budget: 500.0, // Monthly budget
        ),
      ],
    );
  }

  Widget _buildCampaignCard({
    required String title,
    required String status,
    required String channel,
    required String dates,
    required int reach,
    required double spend,
    required double budget,
  }) {
    Color statusColor;
    if (status == 'Active') {
      statusColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (status == 'Scheduled') {
      statusColor = Colors.amber.shade700;
    } else {
      statusColor = PrimeCareTheme.colors.slateGray;
    }

    final budgetPct = budget > 0 ? (spend / budget).clamp(0.0, 1.0) : 0.0;
    
    String formatNumber(int val) {
      if (val >= 1000) return '${(val / 1000).toStringAsFixed(1)}k';
      return val.toString();
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(LucideIcons.moreHorizontal, size: 20, color: PrimeCareTheme.colors.slateGray),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(LucideIcons.radio, size: 14, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 6),
              Text(channel, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(LucideIcons.calendar, size: 14, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 6),
              Text(dates, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Est. Reach', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontSize: 11)),
                  Text(formatNumber(reach), style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Spend vs Budget', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontSize: 11)),
                  Text('\$${spend.toStringAsFixed(0)} / \$${budget.toStringAsFixed(0)}', style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: budgetPct,
            backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
            valueColor: AlwaysStoppedAnimation<Color>(
               budgetPct > 0.9 ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.navyIndigo,
            ),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                foregroundColor: PrimeCareTheme.colors.navyIndigo,
                side: BorderSide(color: PrimeCareTheme.colors.surfaceContainerHighest),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Manage Campaign'),
            ),
          )
        ],
      ),
    );
  }
}
