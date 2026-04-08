import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class WoundCareScreen extends ConsumerWidget {
  const WoundCareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Wound Care Management',
      subtitle: 'Monitor healing progress and document wound assessments.',
      kpiCards: [
        KPICardData(
          title: 'Active Wounds',
          value: '14',
          icon: LucideIcons.activitySquare,
          trend: 2.0,
          trendLabel: 'new this week',
        ),
        KPICardData(
          title: 'Healing Progress',
          value: '85%',
          icon: LucideIcons.trendingUp,
          trend: 5.0,
          trendLabel: 'showing improvement',
        ),
        KPICardData(
          title: 'Dressings Due',
          value: '6',
          icon: LucideIcons.package2,
          trend: 0.0,
          trendLabel: 'today',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Wound Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildTypeRow('Surgical', 5, PrimeCareTheme.colors.emeraldTeal),
              _buildTypeRow(
                'Pressure Ulcer',
                4,
                PrimeCareTheme.colors.coralRed,
              ),
              _buildTypeRow(
                'Diabetic Ulcer',
                3,
                PrimeCareTheme.colors.navyIndigo,
              ),
              _buildTypeRow(
                'Venous Leg Ulcer',
                2,
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
                  Text(
                    'Recent Assessments',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.camera),
                    label: const Text('Add Image'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildWoundCard(
                'John Smith',
                'Diabetic Foot Ulcer',
                'Right Heel',
                'Length: 4cm, Width: 3cm, Depth: 0.5cm. Granulation tissue present. Minimal exudate.',
                'Dressing Changed Today',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildWoundCard(
                'Eleanor Rigby',
                'Surgical Incision',
                'Left Hip',
                'Incision site healing well. Margins approximated. No redness or swelling.',
                'Staples Removed',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildWoundCard(
                'William Davis',
                'Pressure Ulcer (Stage 2)',
                'Sacrum',
                'Length: 2cm, Width: 2cm, Depth: <0.1cm. Slight maceration around edges. Barrier cream applied.',
                'Needs Review',
                PrimeCareTheme.colors.coralRed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypeRow(String label, int count, Color color) {
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

  Widget _buildWoundCard(
    String clientName,
    String woundType,
    String location,
    String notes,
    String status,
    Color statusColor,
  ) {
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
              Text(clientName, style: PrimeCareTheme.typography.h3),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                woundType,
                style: PrimeCareTheme.typography.label.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '•',
                style: TextStyle(color: PrimeCareTheme.colors.slateGray),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Icon(
                    LucideIcons.mapPin,
                    size: 14,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(notes, style: PrimeCareTheme.typography.body),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.history, size: 16),
                  label: const Text('View History'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.edit2, size: 16),
                  label: const Text('Update'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimeCareTheme.colors.navyIndigo,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
