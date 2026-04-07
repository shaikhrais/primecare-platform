import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswAdlTrackingScreen extends ConsumerWidget {
  const PswAdlTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'ADL Tracking',
      subtitle:
          'Log Activities of Daily Living assistance provided to clients.',
      kpiCards: [
        KPICardData(
          title: 'Logs Today',
          value: '12',
          icon: LucideIcons.clipboardList,
          trend: 2.0,
          trendLabel: 'on track',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ADL Categories', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow(
                'Bathing/Hygiene',
                5,
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildFilterRow('Dressing', 4, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow(
                'Feeding',
                3,
                PrimeCareTheme.colors.lavenderLustre,
              ),
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
                  Text('Recent Logs', style: PrimeCareTheme.typography.h2),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('New ADL Log'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildAdlCard(
                'Ruth Bader Ginsburg',
                'Bathing/Hygiene',
                'May 14, 2024 • 09:30',
                'Assisted with morning shower. Client required mod-assist for lower body washing. Skin intact.',
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildAdlCard(
                'Thurgood Marshall',
                'Feeding',
                'May 14, 2024 • 12:15',
                'Assisted with lunch setup. Client fed self independently after containers were opened. Consumed 80% of meal.',
                PrimeCareTheme.colors.lavenderLustre,
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
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(
            count.toString(),
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdlCard(
    String clientName,
    String category,
    String time,
    String notes,
    Color themeColor,
  ) {
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
                  Text(
                    '•',
                    style: TextStyle(color: PrimeCareTheme.colors.slateGray),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(notes, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }
}
