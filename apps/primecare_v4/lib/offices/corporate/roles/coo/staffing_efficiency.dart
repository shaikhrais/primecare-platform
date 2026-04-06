import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StaffingEfficiencyScreen extends StatelessWidget {
  const StaffingEfficiencyScreen({super.key});

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
                        flex: 2,
                        child: Column(
                            children: [
                                _buildOvertimeAnalysis(context),
                                const SizedBox(height: 24),
                                _buildRecruitmentPipeline(context),
                            ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildUtilizationRate(context),
                            const SizedBox(height: 24),
                            _buildTrainingCompletion(context),
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
              'Staffing Efficiency',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Analyze workforce utilization, overtime costs, and pipeline health',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.calendar, 'Select Month'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.download, 'Export Report'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
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
        Expanded(child: _buildKPIUnit(context, 'Total Overtime Cost', '\$42.5k', LucideIcons.circleDollarSign, '-5.2%', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Avg Utilization Base', '88%', LucideIcons.users, '+2%', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Open Requisitions', '24', LucideIcons.userPlus, '-3', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Compliance Training', '94%', LucideIcons.graduationCap, '+1%', PrimeCareTheme.emeraldTeal)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String trend, Color trendColor) {
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
              Icon(icon, color: PrimeCareTheme.emeraldTeal, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: trendColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                    children: [
                        Text(
                          trend,
                          style: TextStyle(
                            color: trendColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOvertimeAnalysis(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Overtime Cost Centers',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                ),
                const Icon(LucideIcons.moreHorizontal, color: Colors.white70),
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
                DataColumn(label: Text('Branch')),
                DataColumn(label: Text('Total OT Cost')),
                DataColumn(label: Text('Vs Target')),
                DataColumn(label: Text('Primary Cause')),
              ],
              rows: [
                _buildDataRow('Vancouver West', '\$15.2k', '+12%', 'RN Shortage', Colors.redAccent),
                _buildDataRow('Calgary North', '\$12.1k', '+8%', 'Sick Calls', Colors.orange),
                _buildDataRow('Toronto Central', '\$8.5k', '-2%', 'Expected Baseline', PrimeCareTheme.emeraldTeal),
                _buildDataRow('Montreal Hub', '\$6.7k', '-5%', 'Expected Baseline', PrimeCareTheme.emeraldTeal),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String branch, String cost, String vsTarget, String cause, Color vsTargetColor) {
    return DataRow(
      cells: [
        DataCell(Text(branch, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(cost)),
        DataCell(
             Text(
                vsTarget,
                style: TextStyle(color: vsTargetColor, fontWeight: FontWeight.bold),
             )
        ),
        DataCell(Text(cause, style: const TextStyle(color: Colors.white70))),
      ],
    );
  }

  Widget _buildUtilizationRate(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.activitySquare, color: PrimeCareTheme.emeraldTeal, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Resource Utilization',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildUtilizationMetric('PSW Network', 0.92, PrimeCareTheme.emeraldTeal),
            const SizedBox(height: 16),
             _buildUtilizationMetric('RN Network', 0.85, Colors.orange),
            const SizedBox(height: 16),
             _buildUtilizationMetric('Administrative', 0.75, Colors.blue),
          ],
        ),
      );
  }

    Widget _buildUtilizationMetric(String title, double percentage, Color color) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                         Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                         Text('${(percentage * 100).toInt()}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                    ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        minHeight: 6,
                    ),
                ),
            ],
        );
    }

    Widget _buildRecruitmentPipeline(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                    'Active Recruitment Pipeline',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                ],
            ),
            const SizedBox(height: 24),
            Row(
                 children: [
                     Expanded(child: _buildPipelineStage('Sourcing', '142')),
                      const SizedBox(width: 16),
                     Expanded(child: _buildPipelineStage('Interviewing', '58')),
                      const SizedBox(width: 16),
                     Expanded(child: _buildPipelineStage('Screening', '34')),
                      const SizedBox(width: 16),
                     Expanded(child: _buildPipelineStage('Onboarding', '12')),
                 ]
            )
          ],
        ),
      );
  }

  Widget _buildPipelineStage(String label, String count) {
         return Column(
             children: [
                 Container(
                     width: double.infinity,
                     padding: const EdgeInsets.symmetric(vertical: 24),
                     decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                     child: Center(
                         child: Text(count, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
                     )
                 ),
                 const SizedBox(height: 12),
                 Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
             ]
         );
    }

    Widget _buildTrainingCompletion(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                        children: [
                            Icon(LucideIcons.award, color: PrimeCareTheme.emeraldTeal, size: 24),
                            const SizedBox(width: 12),
                            Text(
                            'Compliance Training',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                        ],
                    ),
                    const SizedBox(height: 24),
                    _buildTrainingRow('Annual Safety Proc', '98%', PrimeCareTheme.emeraldTeal),
                    const SizedBox(height: 12),
                    _buildTrainingRow('Privacy / HIPAA', '95%', PrimeCareTheme.emeraldTeal),
                    const SizedBox(height: 12),
                    _buildTrainingRow('New Equipment Cert', '82%', Colors.orange),
                ]
            )
        );
    }

    Widget _buildTrainingRow(String label, String value, Color color) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(label, style: const TextStyle(color: Colors.white70)),
                Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ]
        );
    }
}
