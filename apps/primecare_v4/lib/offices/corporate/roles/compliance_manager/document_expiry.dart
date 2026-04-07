import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class DocumentExpiryScreen extends ConsumerWidget {
  const DocumentExpiryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Facility & Corporate Document Expiry',
      subtitle:
          'Monitor corporate permits, facility licenses, and vendor insurance expiry dates.',
      headerTrailing: [
        ClinicalSearchTextField(
          hintText: 'Search by document name or facility...',
        ),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Add Document',
          icon: LucideIcons.plus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Expiring (<60 days)',
          value: '12',
          icon: LucideIcons.calendarMinus,
          trend: 'Focus on Fire Safety permits',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        MetricCardData(
          title: 'Total Active Docs',
          value: '345',
          icon: LucideIcons.fileArchive,
          trend: '+12 this month',
          isUp: true,
        ),
        MetricCardData(
          title: 'Missing/Expired',
          value: '0',
          icon: LucideIcons.checkCircle,
          trend: 'Fully Compliant',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      sidebarContent: [
        _buildDocumentCategories(),
        const SizedBox(height: 24),
        _buildFacilityStatus(),
      ],
      mainContent: [_buildExpiringList()],
    );
  }

  Widget _buildDocumentCategories() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.layers,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Categories', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildCategoryRow('Facility Licenses', '89'),
          const SizedBox(height: 12),
          _buildCategoryRow('Health & Safety', '124'),
          const SizedBox(height: 12),
          _buildCategoryRow('Vendor Insurance', '56'),
          const SizedBox(height: 12),
          _buildCategoryRow('IT & Data Processing', '76'),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String title, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: PrimeCareTheme.typography.body),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.cloudGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(count, style: PrimeCareTheme.typography.label),
        ),
      ],
    );
  }

  Widget _buildFacilityStatus() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.building,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Alerts by Facility', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildAlertRow('Oakville Campus', 3),
          const SizedBox(height: 8),
          _buildAlertRow('Downtown Clinic', 1),
          const SizedBox(height: 8),
          _buildAlertRow('Northside Rehab', 2),
        ],
      ),
    );
  }

  Widget _buildAlertRow(String facility, int alerts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(facility, style: PrimeCareTheme.typography.body),
        Text(
          '$alerts Alerts',
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.amberWarning,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiringList() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Expirations (60 Days)',
                  style: PrimeCareTheme.typography.h2,
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Export to Excel',
                  icon: LucideIcons.download,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildDocItem(
            name: 'Annual Fire Safety Inspection',
            facility: 'Oakville Campus',
            category: 'Health & Safety',
            expiryDate: 'Dec 12, 2026',
            daysLeft: 22,
          ),
          const Divider(height: 1),
          _buildDocItem(
            name: 'Bio-Hazard Waste Disposal Permit',
            facility: 'All Campuses',
            category: 'Facility Licenses',
            expiryDate: 'Jan 05, 2027',
            daysLeft: 46,
          ),
          const Divider(height: 1),
          _buildDocItem(
            name: 'Cisco Systems SLA Support',
            facility: 'Corporate HQ',
            category: 'IT & Data Processing',
            expiryDate: 'Jan 10, 2027',
            daysLeft: 51,
          ),
        ],
      ),
    );
  }

  Widget _buildDocItem({
    required String name,
    required String facility,
    required String category,
    required String expiryDate,
    required int daysLeft,
  }) {
    final color = daysLeft <= 30
        ? PrimeCareTheme.colors.coralRed
        : PrimeCareTheme.colors.amberWarning;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.fileWarning, color: color, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      LucideIcons.building,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(facility, style: PrimeCareTheme.typography.label),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.tag,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(category, style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$daysLeft Days Left',
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                'Expires $expiryDate',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'Update Document',
                icon: LucideIcons.upload,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
