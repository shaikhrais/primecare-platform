import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class VitalsScreen extends ConsumerWidget {
  const VitalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Vitals & Flowsheets',
      subtitle: 'Monitor continuous patient metrics and clinical observations.',
      kpiCards: [
        KPICardData(
          title: 'Measurements Today',
          value: '45',
          icon: LucideIcons.activity,
          trend: 10.0,
          trendLabel: 'vs yesterday',
        ),
        KPICardData(
          title: 'Alerts Active',
          value: '2',
          icon: LucideIcons.alertCircle,
          trend: -1.0,
          trendLabel: 'requiring review',
        ),
        KPICardData(
          title: 'Devices Synced',
          value: '100%',
          icon: LucideIcons.radio,
          trend: 0.0,
          trendLabel: 'Bluetooth active',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alerts Filter', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Critical (Action Req)', 1, PrimeCareTheme.colors.coralRed),
               _buildFilterRow('Warning (Monitor)', 1, PrimeCareTheme.colors.lavenderLustre),
              _buildFilterRow('Normal', 43, PrimeCareTheme.colors.emeraldTeal),
               _buildFilterRow('Missing Data', 0, PrimeCareTheme.colors.slateGray),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('Active Alerts', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('Add Reading'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildVitalsCard(
                 'Maria Garcia',
                 'Blood Pressure (High)',
                 '155 / 95 mmHg',
                 '10 mins ago',
                 'Re-check in 1 hour. Consider PRN medication if >160/100.',
                 PrimeCareTheme.colors.coralRed
               ),
               _buildVitalsCard(
                 'John Smith',
                 'Blood Glucose (Low)',
                 '3.8 mmol/L',
                 '30 mins ago',
                 'Provided 15g fast-acting carbohydrate.',
                 PrimeCareTheme.colors.lavenderLustre
               ),
               const SizedBox(height: 32),
               Text('Recent Normal Readings', style: PrimeCareTheme.typography.h3),
               const SizedBox(height: 16),
               _buildVitalsCard(
                 'Eleanor Rigby',
                 'Temperature',
                 '36.8 °C',
                 '1 hour ago',
                 'Normal reading. Continuing scheduled observations.',
                 PrimeCareTheme.colors.emeraldTeal
               ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
               Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildVitalsCard(String clientName, String metric, String value, String time, String notes, Color statusColor) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: statusColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                Row(
                  children: [
                    Text(clientName, style: PrimeCareTheme.typography.h3),
                    const SizedBox(width: 8),
                    Text('•', style: TextStyle(color: PrimeCareTheme.colors.slateGray)),
                    const SizedBox(width: 8),
                    Text(metric, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold, color: statusColor)),
                  ],
                ),
                 Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
             ],
           ),
           const SizedBox(height: 12),
           Row(
             children: [
               Text(value, style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
               const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.lineChart, size: 16),
                  label: const Text('Trend'),
                )
             ],
           ),
           const SizedBox(height: 16),
           Text(notes, style: PrimeCareTheme.typography.body),
        ],
      )
     );
  }
}
