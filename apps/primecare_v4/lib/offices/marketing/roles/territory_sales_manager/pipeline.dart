import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TerritoryPipelineScreen extends ConsumerStatefulWidget {
  const TerritoryPipelineScreen({super.key});

  @override
  ConsumerState<TerritoryPipelineScreen> createState() => _TerritoryPipelineScreenState();
}

class _TerritoryPipelineScreenState extends ConsumerState<TerritoryPipelineScreen> {
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
            _buildPipelineMetrics(),
            const SizedBox(height: 32),
            _buildKanbanBoard(),
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
              'B2B Sales Pipeline',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage high-value corporate deals and preferred provider negotiations.',
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
              label: 'Filter Reps',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'New Opportunity',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPipelineMetrics() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Total Pipeline Value',
            value: '\$4.2M',
            trend: '+12%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Closed Won (YTD)',
            value: '\$1.8M',
            trend: '+5%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg Deal Size',
            value: '\$85k',
            trend: '+2%',
            positiveTrend: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Sales Velocity',
            value: '45 days',
            trend: '-5 days',
            positiveTrend: true, // faster is better
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required String trend, required bool positiveTrend}) {
    Color trendColor = positiveTrend ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed;
    IconData trendIcon = positiveTrend ? LucideIcons.trendingUp : LucideIcons.trendingDown;

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(trendIcon, size: 16, color: trendColor),
              const SizedBox(width: 4),
              Text(
                '$trend vs. Prior Qtr',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: trendColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanBoard() {
    return SizedBox(
      height: 600, // Fixed height for scrolling columns
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildKanbanColumn(
              title: 'Prospecting',
              count: 12,
              value: '\$1.1M',
              cards: [
                _buildKanbanCard(company: 'TechCorp Industries', value: '\$120k', rep: 'Sarah J.', daysInStage: 12),
                _buildKanbanCard(company: 'Global Logistics Hub', value: '\$85k', rep: 'Mike C.', daysInStage: 4),
                _buildKanbanCard(company: 'City Transit Auth', value: '\$250k', rep: 'Sarah J.', daysInStage: 1),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _buildKanbanColumn(
              title: 'Initial Meeting',
              count: 8,
              value: '\$850k',
              cards: [
                _buildKanbanCard(company: 'Apex Manufacturing', value: '\$150k', rep: 'Aisha P.', daysInStage: 5),
                _buildKanbanCard(company: 'Regional School District', value: '\$400k', rep: 'David R.', daysInStage: 14, isStalled: true),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _buildKanbanColumn(
              title: 'Negotiation / Proposal',
              count: 5,
              value: '\$1.45M',
              cards: [
                _buildKanbanCard(company: 'Sunrise Tech Village', value: '\$800k', rep: 'Mike C.', daysInStage: 2),
                _buildKanbanCard(company: 'Local Retail Assoc.', value: '\$650k', rep: 'Sarah J.', daysInStage: 8),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _buildKanbanColumn(
              title: 'Closed Won (This Qtr)',
              count: 3,
              value: '\$800k',
              isFinalStage: true,
              cards: [
                _buildKanbanCard(company: 'Evergreen Construction', value: '\$450k', rep: 'Aisha P.', daysInStage: 0, isWon: true),
                _buildKanbanCard(company: 'Central Media Group', value: '\$350k', rep: 'Sarah J.', daysInStage: 0, isWon: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanColumn({
    required String title,
    required int count,
    required String value,
    required List<Widget> cards,
    bool isFinalStage = false,
  }) {
    Color stageColor = isFinalStage ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.navyIndigo;

    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: PrimeCareTheme.typography.h3.copyWith(color: stageColor),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        count.toString(),
                        style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: PrimeCareTheme.typography.h4.copyWith(color: PrimeCareTheme.colors.navyIndigo),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...cards,
                // Add Drop Target hint
                if (!isFinalStage)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest, style: BorderStyle.none), // Dashed in a real app
                      color: Colors.transparent,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanCard({
    required String company,
    required String value,
    required String rep,
    required int daysInStage,
    bool isStalled = false,
    bool isWon = false,
  }) {
    Color borderColor = Colors.white;
    if (isStalled) borderColor = PrimeCareTheme.colors.coralRed;
    if (isWon) borderColor = PrimeCareTheme.colors.emeraldTeal;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: isStalled || isWon ? 2 : 1.5),
        boxShadow: [
          BoxShadow(
            color: PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  company,
                  style: PrimeCareTheme.typography.h4.copyWith(color: PrimeCareTheme.colors.navyIndigo),
                ),
              ),
              Icon(LucideIcons.moreHorizontal, size: 16, color: PrimeCareTheme.colors.slateGray),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.emeraldTeal,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                    child: Text(rep[0], style: TextStyle(color: PrimeCareTheme.colors.navyIndigo, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  Text(rep, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontSize: 11)),
                ],
              ),
              if (!isWon)
                Row(
                  children: [
                    Icon(LucideIcons.clock, size: 12, color: isStalled ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text('${daysInStage}d', style: PrimeCareTheme.typography.label.copyWith(color: isStalled ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.slateGray, fontSize: 11)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
