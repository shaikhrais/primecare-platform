import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswAssignedClientsScreen extends ConsumerWidget {
  const PswAssignedClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Assigned Clients',
      subtitle: 'View your regular clients and key care plan highlights.',
      kpiCards: [
        KPICardData(
          title: 'Active Clients',
          value: '18',
          icon: LucideIcons.users,
          trend: 1.0,
          trendLabel: 'new this week',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Care Needs', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow(
                'High Acuity',
                3,
                PrimeCareTheme.colors.coralBlush,
              ),
              _buildFilterRow(
                'Moderate Care',
                10,
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildFilterRow(
                'Independent',
                5,
                PrimeCareTheme.colors.emeraldTeal,
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
                  Text('Client Roster', style: PrimeCareTheme.typography.h2),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.search),
                    label: const Text('Search Clients'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          PrimeCareTheme.colors.surfaceContainerHighest,
                      foregroundColor: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildClientCard(
                'Sonia Sotomayor',
                'Moderate Care',
                'Scheduled: Today, 1:00 PM',
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildClientCard(
                'Elena Kagan',
                'High Acuity',
                'Scheduled: Tomorrow, 9:00 AM',
                PrimeCareTheme.colors.coralBlush,
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

  Widget _buildClientCard(
    String clientName,
    String careLevel,
    String nextVisit,
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
                nextVisit,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: themeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              careLevel,
              style: PrimeCareTheme.typography.label.copyWith(
                color: themeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
