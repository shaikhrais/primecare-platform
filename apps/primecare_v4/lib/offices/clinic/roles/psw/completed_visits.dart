import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswCompletedVisitsScreen extends ConsumerWidget {
  const PswCompletedVisitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Completed Visits',
      subtitle: 'Review historical visit logs and verify submitted timesheets.',
      kpiCards: [
        KPICardData(title: 'Visits This Month', value: '42', icon: LucideIcons.calendarCheck, trend: 5.0, trendLabel: 'vs last month'),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payroll Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Approved', 30, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('Pending Review', 12, PrimeCareTheme.colors.lavenderLustre),
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
                   Text('Visit History', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.download),
                    label: const Text('Export Timesheet'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                      foregroundColor: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildVisitCard('Sonia Sotomayor', 'May 13, 2024', '09:00 AM - 11:00 AM', 'Approved', PrimeCareTheme.colors.emeraldTeal),
               _buildVisitCard('Elena Kagan', 'May 13, 2024', '13:00 PM - 15:30 PM', 'Pending Review', PrimeCareTheme.colors.lavenderLustre),
               _buildVisitCard('Sonia Sotomayor', 'May 12, 2024', '09:00 AM - 11:00 AM', 'Approved', PrimeCareTheme.colors.emeraldTeal),
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
               Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildVisitCard(String clientName, String date, String timeRange, String status, Color themeColor) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                Text(date, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 4),
                Text(clientName, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 4),
                Text(timeRange, style: PrimeCareTheme.typography.body),
             ],
           ),
           Container(
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
             decoration: BoxDecoration(
               color: themeColor.withOpacity(0.2),
               borderRadius: BorderRadius.circular(12),
             ),
             child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: themeColor, fontWeight: FontWeight.bold)),
           )
        ],
      )
     );
  }
}
