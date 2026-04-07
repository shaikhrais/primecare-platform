import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FranchiseClaimsScreen extends ConsumerStatefulWidget {
  const FranchiseClaimsScreen({super.key});

  @override
  ConsumerState<FranchiseClaimsScreen> createState() =>
      _FranchiseClaimsScreenState();
}

class _FranchiseClaimsScreenState extends ConsumerState<FranchiseClaimsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildKPIs(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildRecentBatches(),
                    const SizedBox(height: 32),
                    _buildClaimsAging(),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildAdjudicationSummary(),
                    const SizedBox(height: 32),
                    _buildTopDenialReasons(),
                  ],
                ),
              ),
            ],
          ),
        ],
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
              'Claims Management',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Franchise billing, adjudication workflows, and remittance tracking.',
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
              icon: LucideIcons.uploadCloud,
              label: 'Upload 837P',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.filter,
              label: 'Filter Claims',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildKPIUnit(
            title: 'Total Submitted',
            value: '\$1.4M',
            icon: LucideIcons.receipt,
            subtitle: 'Year to Date',
            color: PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildKPIUnit(
            title: 'Clean Claim Rate',
            value: '94.2%',
            icon: LucideIcons.checkSquare,
            subtitle: 'First-pass acceptance',
            color: PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildKPIUnit(
            title: 'Denial Rate',
            value: '4.1%',
            icon: LucideIcons.xCircle,
            subtitle: 'Target: < 5.0%',
            color: Colors.amber.shade700,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildKPIUnit(
            title: 'Awaiting ERA',
            value: '\$214k',
            icon: LucideIcons.clock,
            subtitle: 'Outstanding balance',
            color: PrimeCareTheme.colors.coralRed,
          ),
        ),
      ],
    );
  }

  Widget _buildKPIUnit({
    required String title,
    required String value,
    required IconData icon,
    required String subtitle,
    required Color color,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: PrimeCareTheme.typography.label.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBatches() {
    return ClinicalGlassPanel(
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
                  'Recent Claim Batches',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Text(
                  'View All',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.emeraldTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: PrimeCareTheme.colors.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'BATCH ID',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'SUBMITTED',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'TYPE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'VALUE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'STATUS',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBatchRow(
            id: 'CTL-84920',
            date: 'Today, 09:14 AM',
            type: 'Medicare',
            value: '\$24,500.00',
            status: 'Accepted',
            color: PrimeCareTheme.colors.emeraldTeal,
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildBatchRow(
            id: 'CTL-84919',
            date: 'Yesterday, 14:22 PM',
            type: 'Private Ins',
            value: '\$12,420.50',
            status: 'Processing',
            color: PrimeCareTheme.colors.navyIndigo,
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildBatchRow(
            id: 'CTL-84918',
            date: 'Oct 12, 08:00 AM',
            type: 'WSIB',
            value: '\$8,940.00',
            status: 'Partial Rejection',
            color: Colors.amber.shade700,
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildBatchRow(
            id: 'CTL-84917',
            date: 'Oct 11, 16:45 PM',
            type: 'Medicare',
            value: '\$31,200.00',
            status: 'Paid',
            color: PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildBatchRow({
    required String id,
    required String date,
    required String type,
    required String value,
    required String status,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              id,
              style: PrimeCareTheme.typography.h4.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              date,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              type,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: PrimeCareTheme.typography.h4.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                status,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimsAging() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.barChart3,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'AR Aging Summary',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAgingRow(
            '0 - 30 Days',
            '\$124,500',
            0.65,
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildAgingRow(
            '31 - 60 Days',
            '\$42,100',
            0.22,
            PrimeCareTheme.colors.navyIndigo,
          ),
          const SizedBox(height: 16),
          _buildAgingRow(
            '61 - 90 Days',
            '\$18,400',
            0.09,
            Colors.amber.shade700,
          ),
          const SizedBox(height: 16),
          _buildAgingRow(
            '90+ Days',
            '\$6,420',
            0.04,
            PrimeCareTheme.colors.coralRed,
          ),
        ],
      ),
    );
  }

  Widget _buildAgingRow(
    String bucket,
    String value,
    double percent,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bucket,
              style: PrimeCareTheme.typography.h4.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            Text(
              value,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percent,
          backgroundColor: PrimeCareTheme.colors.surfaceContainerLowest,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }

  Widget _buildAdjudicationSummary() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Adjudication',
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildStatList(
            'Pending Remittance',
            '124',
            PrimeCareTheme.colors.navyIndigo,
          ),
          const SizedBox(height: 16),
          _buildStatList(
            'Ready to Post',
            '42',
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildStatList('Requires Review', '18', Colors.amber.shade700),
          const SizedBox(height: 16),
          _buildStatList(
            'Appeals Processing',
            '9',
            PrimeCareTheme.colors.coralRed,
          ),
        ],
      ),
    );
  }

  Widget _buildStatList(String title, String count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
                fontSize: 13,
              ),
            ),
          ],
        ),
        Text(
          count,
          style: PrimeCareTheme.typography.h4.copyWith(
            color: PrimeCareTheme.colors.navyIndigo,
          ),
        ),
      ],
    );
  }

  Widget _buildTopDenialReasons() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.alertOctagon,
                color: Colors.amber.shade700,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Top Denial Reasons',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDenialReason('CO-16: Lacks Information', '24%'),
          const Divider(height: 24),
          _buildDenialReason('CO-29: Timely Filing Limit', '15%'),
          const Divider(height: 24),
          _buildDenialReason('CO-B11: Procedure Not Covered', '9%'),
        ],
      ),
    );
  }

  Widget _buildDenialReason(String code, String rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          code,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
            fontSize: 12,
          ),
        ),
        Text(
          rate,
          style: PrimeCareTheme.typography.h4.copyWith(
            color: Colors.amber.shade700,
          ),
        ),
      ],
    );
  }
}
