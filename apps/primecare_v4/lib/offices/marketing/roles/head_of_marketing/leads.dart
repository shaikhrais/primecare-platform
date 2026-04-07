import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LeadsScreen extends ConsumerStatefulWidget {
  const LeadsScreen({super.key});

  @override
  ConsumerState<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends ConsumerState<LeadsScreen> {
  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildMetricCards(),
          const SizedBox(height: 32),
          _buildLeadsList(),
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
              'Lead Monitoring',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enterprise-level lead flow monitoring and distribution',
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
              icon: LucideIcons.filter,
              label: 'Filter',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.download,
              label: 'Export Leads CSV',
              isActive: true, // Primary action
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCards() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Total MQLs (30d)',
            '3,601',
            '+8% vs last month',
            LucideIcons.users,
            PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Total SQLs (30d)',
            '1,620',
            '+15% vs last month',
            LucideIcons.target,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Avg Lead Score',
            '78.4',
            'Strong quality indicator',
            LucideIcons.activity,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Conversion Rate',
            '45.2%',
            'MQL to SQL flow',
            LucideIcons.trendingUp,
            PrimeCareTheme.colors.navyIndigo,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color accentColor,
  ) {
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.display.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadsList() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Lead Intake',
                  style: PrimeCareTheme.typography.h2.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                ClinicalSearchTextField(hintText: 'Search leads...'),
              ],
            ),
          ),
          _buildTableHeader(),
          _buildTableRow(
            id: 'LD-9021',
            name: 'A. Jensen',
            service: 'Physiotherapy',
            type: 'MQL',
            score: 65,
          ),
          _buildTableRow(
            id: 'LD-9022',
            name: 'M. Tran',
            service: 'Chiropractic',
            type: 'SQL',
            score: 92,
          ),
          _buildTableRow(
            id: 'LD-9023',
            name: 'S. Gupta',
            service: 'Massage Therapy',
            type: 'SQL',
            score: 88,
          ),
          _buildTableRow(
            id: 'LD-9024',
            name: 'L. Chen',
            service: 'Wellness Check',
            type: 'MQL',
            score: 45,
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
          ),
          top: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('LEAD ID', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 3,
            child: Text('NAME', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 3,
            child: Text('SERVICE', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 2,
            child: Text('TYPE', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 2,
            child: Text('SCORE', style: PrimeCareTheme.typography.label),
          ),
          Expanded(
            flex: 1,
            child: Text('', style: PrimeCareTheme.typography.label),
          ), // Actions
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required String id,
    required String name,
    required String service,
    required String type,
    required int score,
  }) {
    Color typeColor = type == 'SQL'
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.amberWarning;
    Color scoreColor = score > 80
        ? PrimeCareTheme.colors.emeraldTeal
        : (score > 50
              ? PrimeCareTheme.colors.amberWarning
              : PrimeCareTheme.colors.coralRed);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  LucideIcons.userPlus,
                  color: PrimeCareTheme.colors.slateGray,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  id,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              service,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: typeColor.withValues(alpha: 0.2)),
                ),
                child: Text(
                  type,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: typeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  score.toString(),
                  style: PrimeCareTheme.typography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scoreColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: score / 100,
                    backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
                    valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  LucideIcons.moreVertical,
                  color: PrimeCareTheme.colors.slateGray,
                ),
                onPressed: () {},
                splashRadius: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
