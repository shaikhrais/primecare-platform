import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FeatureAdoptionScreen extends StatelessWidget {
  const FeatureAdoptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildModuleRetention(context),
                            const SizedBox(height: 24),
                            _buildUserFeedback(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildActiveUsersPerFeature(context),
                            const SizedBox(height: 24),
                            _buildFeatureTimeline(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Feature Adoption & Telemetry',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Track active module usage, retention rates, and feature rollout performance.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(
              context,
              LucideIcons.pieChart,
              'Generate Report',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.settings,
              'Metrics Settings',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(
    BuildContext context,
    IconData icon,
    String tooltip,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildKPIUnit(
            context,
            'Total Active Users',
            '24,510',
            LucideIcons.users,
            '+1,200 this week',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Avg Core Feature Usage',
            '82%',
            LucideIcons.activity,
            'Above 75% target',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Time to First Value',
            '1.2h',
            LucideIcons.timer,
            '-0.4h vs last quarter',
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Churn Rate',
            '1.4%',
            LucideIcons.userMinus,
            'Lowest YTD',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
      ],
    );
  }

  Widget _buildKPIUnit(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    String subtitle,
    Color color,
  ) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveUsersPerFeature(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Users per Module (DAU)',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Filter by cohort...',
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(
                      LucideIcons.filter,
                      color: Colors.white54,
                      size: 18,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Feature / Module')),
                DataColumn(label: Text('Daily Active Users')),
                DataColumn(label: Text('Adoption Penetration')),
                DataColumn(label: Text('WoW Trend')),
              ],
              rows: [
                _buildDataRow(
                  'Clinical EMR Hub',
                  '18,420',
                  0.85,
                  '+4.2%',
                  PrimeCareTheme.emeraldTeal,
                ),
                _buildDataRow(
                  'Shift Scheduling',
                  '12,150',
                  0.65,
                  '+1.8%',
                  Colors.blue,
                ),
                _buildDataRow(
                  'Telehealth Video',
                  '6,800',
                  0.35,
                  '+12.5%',
                  PrimeCareTheme.emeraldTeal,
                ),
                _buildDataRow(
                  'Advanced Analytics',
                  '1,200',
                  0.15,
                  '-2.0%',
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String feature,
    String dau,
    double penetration,
    String trend,
    Color trendColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(feature, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Text(dau)),
        DataCell(
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: penetration,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.blueAccent,
                    ),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(penetration * 100).toInt()}%',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            trend,
            style: TextStyle(color: trendColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildModuleRetention(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.barChart,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Module Retention (D30)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildRetentionRow('Core EMR', 0.94, PrimeCareTheme.emeraldTeal),
          const SizedBox(height: 16),
          _buildRetentionRow('Messaging', 0.88, Colors.blue),
          const SizedBox(height: 16),
          _buildRetentionRow('Telehealth', 0.65, Colors.orange),
          const SizedBox(height: 16),
          _buildRetentionRow('Billing', 0.42, Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildRetentionRow(String title, double retention, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              '${(retention * 100).toInt()}%',
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: retention,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureTimeline(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.rocket, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Text(
                'Recent Rollouts & Impact',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Text(
                'View Roadmap',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTimelineItem(
            'AI Note Dictation (v4.2)',
            'Launched 2 weeks ago. 15% adoption rate so far.',
            '15% Adoption',
            PrimeCareTheme.emeraldTeal,
          ),
          const Divider(color: Colors.white12, height: 24),
          _buildTimelineItem(
            'Offline Mode Sync (v4.1)',
            'Launched 1 month ago. Solved 90% of connectivity drops.',
            '45% Adoption',
            Colors.blue,
          ),
          const Divider(color: Colors.white12, height: 24),
          _buildTimelineItem(
            'Advanced Analytics Hub (v4.0)',
            'Launched 2 months ago. Low engagement in rural clinics.',
            '12% Adoption',
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String feature,
    String context,
    String metric,
    Color dotColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    feature,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: dotColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      metric,
                      style: TextStyle(
                        color: dotColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                context,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserFeedback(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.messageSquare,
                color: Colors.purpleAccent,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'User Feedback Score',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                const Text(
                  '4.8/5.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      LucideIcons.star,
                      color: index == 4 ? Colors.white54 : Colors.orange,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildFeedbackRow(
            'UI Responsiveness',
            '+12 NPS',
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildFeedbackRow('Search Accuracy', '-4 NPS', Colors.redAccent),
          const SizedBox(height: 16),
          _buildFeedbackRow('Mobile Parity', '+8 NPS', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildFeedbackRow(String metric, String score, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          metric,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        Text(
          score,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
