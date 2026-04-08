import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RmtSessionHistoryScreen extends ConsumerWidget {
  const RmtSessionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Session History',
      subtitle: 'Chronological record of clinic visits and treatment sessions.',
      kpiCards: [
        KPICardData(
          title: 'Sessions This Week',
          value: '18',
          icon: LucideIcons.calendarDays,
          trend: 2.0,
          trendLabel: 'vs last week',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Duration', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('30 Min', 5, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('60 Min', 42, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow(
                '90 Min',
                12,
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
                  Text('Recent Sessions', style: PrimeCareTheme.typography.h2),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.filter),
                    label: const Text('Filter History'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          PrimeCareTheme.colors.surfaceContainerHighest,
                      foregroundColor: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSessionCard(
                'Marie Curie',
                '60 Min Massage Therapy',
                'May 14, 2024 • 14:00',
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildSessionCard(
                'Nikola Tesla',
                '90 Min Massage Therapy',
                'May 14, 2024 • 10:00',
                PrimeCareTheme.colors.lavenderLustre,
              ),
              _buildSessionCard(
                'Thomas Edison',
                '30 Min Specific Area',
                'May 13, 2024 • 16:30',
                PrimeCareTheme.colors.emeraldTeal,
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

  Widget _buildSessionCard(
    String clientName,
    String sessionType,
    String time,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(clientName, style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 4),
              Text(
                sessionType,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: themeColor,
                  fontWeight: FontWeight.bold,
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
    );
  }
}
