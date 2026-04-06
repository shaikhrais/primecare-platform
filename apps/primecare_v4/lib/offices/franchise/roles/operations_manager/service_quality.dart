import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ServiceQualityScreen extends StatelessWidget {
  const ServiceQualityScreen({super.key});

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
                                _buildQualityAudits(context),
                                const SizedBox(height: 24),
                                _buildSatisfactionMetric(context),
                            ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildTopPerformers(context),
                            const SizedBox(height: 24),
                            _buildRecentFeedback(context),
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
              'Service Quality Control',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Monitor franchise client satisfaction, audits, and performance',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.star, 'Run Audit'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.download, 'Quality Report'),
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
        Expanded(child: _buildKPIUnit(context, 'Avg CSAT Score', '4.8/5', LucideIcons.heartCore, '+0.2 YoY', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Incident Rate', '0.4%', LucideIcons.alertTriangle, '-0.1% this month', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Audits Passed', '98%', LucideIcons.clipboardCheck, 'Top 10% region', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Client Churn', '1.2%', LucideIcons.userMinus, 'Below threshold', Colors.blue)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String subtitle, Color color) {
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
           )
        ],
      ),
    );
  }

  Widget _buildQualityAudits(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Recent Quality Audits',
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
                DataColumn(label: Text('Audit Target')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Date Evaluated')),
                DataColumn(label: Text('Score')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                _buildDataRow('Sarah J. (RN)', 'Field Observation', 'Oct 14, 2024', '98/100', PrimeCareTheme.emeraldTeal, 'Passed'),
                _buildDataRow('Downtown Core Route A', 'Logistics Check', 'Oct 12, 2024', '100/100', PrimeCareTheme.emeraldTeal, 'Passed - Exemplary'),
                _buildDataRow('Mike R. (PSW)', 'Infection Control', 'Oct 10, 2024', '75/100', Colors.orange, 'Action Required'),
                _buildDataRow('Equipment Room B', 'Sanitation Log', 'Oct 08, 2024', '92/100', PrimeCareTheme.emeraldTeal, 'Passed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String target, String type, String date, String score, Color statusColor, String status) {
    return DataRow(
      cells: [
        DataCell(Text(target, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(type)),
        DataCell(Text(date, style: const TextStyle(color: Colors.white70))),
         DataCell(Text(score, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(
             Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                     color: statusColor.withValues(alpha: 0.2),
                     borderRadius: BorderRadius.circular(12),
                     border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                 ),
                 child: Text(
                     status,
                     style: TextStyle(
                         color: statusColor,
                         fontSize: 12,
                         fontWeight: FontWeight.w500,
                     ),
                 ),
             )
        ),
      ],
    );
  }

    Widget _buildSatisfactionMetric(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.smile, color: PrimeCareTheme.emeraldTeal, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Client Satisfaction Breakdown (CSAT)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    Expanded(child: _buildCategoryBar('Exceeds', 75, PrimeCareTheme.emeraldTeal)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildCategoryBar('Meets', 15, Colors.blue)),
                     const SizedBox(width: 12),
                    Expanded(child: _buildCategoryBar('Below', 5, Colors.orange)),
                     const SizedBox(width: 12),
                    Expanded(child: _buildCategoryBar('Critical', 3, Colors.redAccent)),
                ]
            )
          ],
        ),
      );
    }

     Widget _buildCategoryBar(String label, double height, Color color) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Text('$height%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                    height: height * 1.5,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                    )
                ),
                const SizedBox(height: 8),
                Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 11)),
            ]
        );
     }

    Widget _buildTopPerformers(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Row(
                    children: [
                        const Icon(LucideIcons.medal, color: Colors.amber, size: 24),
                        const SizedBox(width: 12),
                        Text(
                        'Top Performers',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                    ],
                    ),
                ]
            ),
            const SizedBox(height: 24),
            _buildPerformerItem('Lisa Wong (LPN)', '100% CSAT this month', '120 shifts', PrimeCareTheme.emeraldTeal),
            const Divider(color: Colors.white12, height: 24),
            _buildPerformerItem('John Smith (PSW)', '0 Incidents Q3', '98 shifts', PrimeCareTheme.emeraldTeal),
             const Divider(color: Colors.white12, height: 24),
            _buildPerformerItem('Downtown Core A', 'Lowest absence rate', 'Franchise Avg', Colors.blue),
          ],
        ),
      );
  }

     Widget _buildPerformerItem(String name, String stat, String details, Color badgeColor) {
        return Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Container(
                     padding: const EdgeInsets.all(8),
                     decoration: BoxDecoration(color: badgeColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                     child: Icon(LucideIcons.star, size: 16, color: badgeColor),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                     child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                             Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                     Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                     Text(details, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                                 ]
                             ),
                             const SizedBox(height: 4),
                             Text(stat, style: TextStyle(color: badgeColor, fontSize: 13, fontWeight: FontWeight.w500)),
                         ]
                     )
                 )
             ]
        );
    }

    Widget _buildRecentFeedback(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                        children: [
                            Icon(LucideIcons.messageSquare, color: PrimeCareTheme.emeraldTeal, size: 24),
                            const SizedBox(width: 12),
                            Text(
                            'Recent Client Feedback',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                        ],
                    ),
                    const SizedBox(height: 24),
                    _buildFeedbackItem('"Sarah was exceptional today. Highly recommend!"', 5, 'Client A.M.'),
                    const SizedBox(height: 16),
                    _buildFeedbackItem('"Caregiver arrived 15 mins late due to traffic."', 3, 'Client B.R.'),
                    const SizedBox(height: 16),
                    _buildFeedbackItem('"Excellent service as always from PrimeCare."', 5, 'Client C.J.'),
                ]
            )
        );
    }

    Widget _buildFeedbackItem(String quote, int stars, String author) {
        return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1))
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        children: List.generate(5, (index) {
                            return Icon(
                                index < stars ? LucideIcons.star : LucideIcons.starHalf,
                                color: Colors.amber,
                                size: 14,
                            );
                        }),
                    ),
                    const SizedBox(height: 8),
                    Text(quote, style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 13)),
                    const SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text('- $author', style: const TextStyle(color: Colors.white54, fontSize: 11))],
                    )
                ]
            )
        );
    }
}
