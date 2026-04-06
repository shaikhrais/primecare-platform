import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ServiceDeliveryScreen extends StatelessWidget {
  const ServiceDeliveryScreen({super.key});

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
                                _buildServiceDeliveryTable(context),
                                const SizedBox(height: 24),
                                _buildCarePlanAdherence(context),
                            ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildCriticalCareAlerts(context),
                            const SizedBox(height: 24),
                            _buildClientSatisfaction(context),
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
              'Service Delivery Quality',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Monitor care plan adherence, patient satisfaction, and service KPIs',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.calendar, 'Select Period'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.download, 'Export Data'),
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
        Expanded(child: _buildKPIUnit(context, 'Avg Patient Sat.', '4.8/5.0', LucideIcons.star, '+0.1', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Time to First Care', '4.2h', LucideIcons.clock, '-0.8h', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Care Plan Adherence', '95.2%', LucideIcons.fileCheck, '+2.1%', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Critical Alerts', '4', LucideIcons.siren, '-1', Colors.orange)),
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

  Widget _buildServiceDeliveryTable(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Branch Delivery Metrics',
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
                DataColumn(label: Text('Satisfaction')),
                DataColumn(label: Text('Time to Care')),
                DataColumn(label: Text('Adherence')),
              ],
              rows: [
                _buildDataRow('Toronto Central', '4.9', '3.5h', '98%', PrimeCareTheme.emeraldTeal),
                _buildDataRow('Vancouver West', '4.7', '4.5h', '92%', Colors.white),
                _buildDataRow('Calgary North', '4.5', '5.2h', '88%', Colors.orange),
                _buildDataRow('Montreal Hub', '4.8', '3.8h', '96%', PrimeCareTheme.emeraldTeal),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String branch, String score, String time, String adherence, Color adherenceColor) {
    return DataRow(
      cells: [
        DataCell(Text(branch, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Row(
            children: [
                const Icon(LucideIcons.star, color: Colors.amber, size: 14),
                const SizedBox(width: 4),
                Text(score),
            ]
        )),
        DataCell(Text(time)),
        DataCell(
             Text(
                adherence,
                style: TextStyle(color: adherenceColor, fontWeight: FontWeight.bold),
             )
        ),
      ],
    );
  }

  Widget _buildCriticalCareAlerts(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.siren, color: Colors.redAccent, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Critical Care Alerts',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildAlertItem('Medication Missed (x3)', 'Patient #1092 • Calgary North', 'Immediate Follow-up required', Colors.redAccent),
            const Divider(color: Colors.white12, height: 32),
             _buildAlertItem('No-Show for Wound Care', 'Patient #4410 • Vancouver West', 'RN dispatched', Colors.orange),
             const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                child: const Text('View All Incident Reports'),
              ),
            ),
          ],
        ),
      );
  }

    Widget _buildAlertItem(String title, String desc, String action, Color color) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 Row(
                     children: [
                         Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
                         const SizedBox(width: 8),
                         Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                     ]
                 ),
                 const SizedBox(height: 6),
                 Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                 const SizedBox(height: 6),
                 Text(action, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
        );
    }

    Widget _buildCarePlanAdherence(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                    'Care Plan Adherence Gap Analysis',
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
                     Expanded(child: _buildAdherenceBar('Medication', 0.98)),
                      const SizedBox(width: 16),
                     Expanded(child: _buildAdherenceBar('Therapy', 0.85)),
                      const SizedBox(width: 16),
                     Expanded(child: _buildAdherenceBar('ADL Support', 0.95)),
                      const SizedBox(width: 16),
                     Expanded(child: _buildAdherenceBar('Vitals Check', 0.99)),
                 ]
            )
          ],
        ),
      );
  }

  Widget _buildAdherenceBar(String label, double value) {
         Color barColor = value >= 0.95 ? PrimeCareTheme.emeraldTeal : Colors.orange;
         return Column(
             children: [
                 SizedBox(
                     height: 100,
                     width: 40,
                     child: Stack(
                         alignment: Alignment.bottomCenter,
                         children: [
                             Container(
                                 decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(4)),
                             ),
                             FractionallySizedBox(
                                 heightFactor: value,
                                 child: Container(
                                     decoration: BoxDecoration(color: barColor, borderRadius: BorderRadius.circular(4)),
                                 ),
                             )
                         ]
                     )
                 ),
                 const SizedBox(height: 12),
                 Text('${(value * 100).toInt()}%', style: TextStyle(color: barColor, fontWeight: FontWeight.bold, fontSize: 16)),
                 const SizedBox(height: 4),
                 Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 11)),
             ]
         );
    }

    Widget _buildClientSatisfaction(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                        children: [
                            Icon(LucideIcons.smilePlus, color: PrimeCareTheme.emeraldTeal, size: 24),
                            const SizedBox(width: 12),
                            Text(
                            'Client Feedback Trends',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                        ],
                    ),
                    const SizedBox(height: 24),
                    _buildFeedbackRow('Caregiver Punctuality', '4.9'),
                    const SizedBox(height: 12),
                    _buildFeedbackRow('Care Quality', '4.8'),
                    const SizedBox(height: 12),
                    _buildFeedbackRow('Communication', '4.5'),
                ]
            )
        );
    }

    Widget _buildFeedbackRow(String label, String score) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(label, style: const TextStyle(color: Colors.white70)),
                Row(
                    children: [
                         const Icon(LucideIcons.star, color: Colors.amber, size: 14),
                         const SizedBox(width: 4),
                         Text(score, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ]
                )
            ]
        );
    }
}
