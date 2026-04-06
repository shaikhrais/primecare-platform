import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TerritoryMapScreen extends ConsumerWidget {
  const TerritoryMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Territory Coverage',
      subtitle: 'Geographical distribution of active franchises and corporate clinics.',
      kpiCards: [
        KPICardData(
          title: 'Total Covered Regions',
          value: '42',
          icon: LucideIcons.map,
          trend: 5.0,
          trendLabel: 'vs last year',
        ),
        KPICardData(
          title: 'Open White Space',
          value: '18',
          icon: LucideIcons.scanLine,
          trend: -2.0,
          trendLabel: 'territories targeted',
        ),
        KPICardData(
          title: 'Market Penetration',
          value: '34%',
          icon: LucideIcons.pieChart,
          trend: 1.5,
          trendLabel: 'overall market share',
        ),
        KPICardData(
          title: 'Highest Density',
          value: 'Ontario',
          icon: LucideIcons.mapPin,
          trend: 0.0,
          trendLabel: '15 locations',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Map Filters', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterToggle('Corporate Clinics', true, PrimeCareTheme.colors.navyIndigo),
              _buildFilterToggle('Franchise Locations', true, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterToggle('Target Territories', false, PrimeCareTheme.colors.coralRed),
              _buildFilterToggle('Competitor Hotspots', false, PrimeCareTheme.colors.slateGray),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Region Breakdown', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildRegionRow('East Coast', 18),
              _buildRegionRow('Central', 15),
              _buildRegionRow('West Coast', 9),
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
                  Text('Interactive Territory Map', style: PrimeCareTheme.typography.h2),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.zoomIn),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.zoomOut),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Placeholder for actual interactive map
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/800x400/e2e8f0/64748b?text=Geospatial+Map+Visualization'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Map Widget Placeholder',
                      style: PrimeCareTheme.typography.h3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Territory Analytics', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildAnalyticsRow('GTA (Greater Toronto Area)', 'High Density', '92%', 'Saturated'),
              _buildAnalyticsRow('Calgary Metropolitan', 'Medium Density', '45%', 'Growth Opportunity'),
              _buildAnalyticsRow('Halifax Regional Municipality', 'Low Density', '15%', 'Prime Target'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterToggle(String label, bool value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            value ? LucideIcons.checkSquare : LucideIcons.square,
            color: value ? color : PrimeCareTheme.colors.slateGray,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(label, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }

  Widget _buildRegionRow(String region, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(region, style: PrimeCareTheme.typography.body),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsRow(String region, String density, String penetration, String recommendation) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(region, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600))),
          Expanded(flex: 1, child: Text(density, style: PrimeCareTheme.typography.body)),
          Expanded(flex: 1, child: Text(penetration, style: PrimeCareTheme.typography.body)),
          Expanded(flex: 1, child: Text(recommendation, style: PrimeCareTheme.typography.label.copyWith(
            color: recommendation == 'Prime Target' ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.navyIndigo,
            fontWeight: FontWeight.bold,
          ), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
