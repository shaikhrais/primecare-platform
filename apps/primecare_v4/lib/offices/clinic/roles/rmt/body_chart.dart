import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RmtBodyChartScreen extends ConsumerWidget {
  const RmtBodyChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Anatomical Body Charts',
      subtitle: 'Visual representations of trigger points, tension areas, and pain mapping.',
      kpiCards: [
        KPICardData(title: 'Charts Updated', value: '4', icon: LucideIcons.user, trend: 0.0, trendLabel: 'today'),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Regions', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Cervical/Upper Back', PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('Lumbar/Pelvis', PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('Upper Extremity', PrimeCareTheme.colors.lavenderLustre),
              _buildFilterRow('Lower Extremity', PrimeCareTheme.colors.coralBlush),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(LucideIcons.userPlus, size: 64, color: PrimeCareTheme.colors.slateGray),
                 const SizedBox(height: 24),
                 Text('Interactive Body Chart Editor', style: PrimeCareTheme.typography.h2),
                 const SizedBox(height: 8),
                 Text('Select a region on the left to map trigger points, hypertonicity, and pain referral patterns for the active client.', textAlign: TextAlign.center, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                 const SizedBox(height: 24),
                 ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('Create New Chart Form'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
               ],
             )
          )
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, Color color) {
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
        ],
      ),
    );
  }
}
