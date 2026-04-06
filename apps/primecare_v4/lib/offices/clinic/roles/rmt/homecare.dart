import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RmtHomecareScreen extends ConsumerWidget {
  const RmtHomecareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Homecare Prescriptions',
      subtitle: 'Exercises, stretching, and hydrotherapy instructions prescribed to clients.',
      kpiCards: [
        KPICardData(title: 'Active Rx', value: '28', icon: LucideIcons.home, trend: 2.0, trendLabel: 'this week'),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Homecare Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Stretching', 15, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('Strengthening', 8, PrimeCareTheme.colors.emeraldTeal),
               _buildFilterRow('Hydrotherapy', 5, PrimeCareTheme.colors.lavenderLustre),
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
                   Text('Recent Prescriptions', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('New Homecare Plan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildNoteCard(
                 'Mike Jones',
                 'Stretching',
                 'May 14, 2024',
                 'Pec major/minor doorway stretches. Hold 30s x 3 sets. B/L upper trapezius stretches. Ensure shoulder depression during stretch. Daily.',
                 PrimeCareTheme.colors.navyIndigo
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

  Widget _buildNoteCard(String clientName, String category, String time, String note, Color themeColor) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
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
                    Text(category, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold, color: themeColor)),
                  ],
                ),
                Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
             ],
           ),
           const SizedBox(height: 16),
           Text(note, style: PrimeCareTheme.typography.body),
        ],
      )
     );
  }
}
