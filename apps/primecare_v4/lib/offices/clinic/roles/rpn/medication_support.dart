import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class MedicationSupportScreen extends ConsumerWidget {
  const MedicationSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Medication Support (eMAR)',
      subtitle: 'Track and administer medications, manage schedules, and ensure compliance.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search patients or medications...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Scan Barcode',
          icon: LucideIcons.scanLine,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Due Next 2h',
          value: '18',
          icon: LucideIcons.clock,
          trend: '+3 from yesterday',
          isUp: false,
        ),
        MetricCardData(
          title: 'Administered',
          value: '104',
          icon: LucideIcons.checkCircle,
          trend: '94% Compliance',
          isUp: true,
        ),
        MetricCardData(
          title: 'Missed / Refused',
          value: '2',
          icon: LucideIcons.alertTriangle,
          trend: 'Requires follow-up',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
      ],
      sidebarContent: [
        _buildPRNPanel(),
        const SizedBox(height: 24),
        _buildPharmacyAlerts(),
      ],
      mainContent: [
        _buildEMARTimeline(),
      ],
    );
  }

  Widget _buildPRNPanel() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.pill, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Quick PRN Access', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildQuickPRNBtn('Morphine 2mg', 'Sylvia P.', LucideIcons.syringe),
          const SizedBox(height: 8),
          _buildQuickPRNBtn('Tylenol 500mg', 'Marcus aurelius', LucideIcons.pill),
        ],
      ),
    );
  }

  Widget _buildQuickPRNBtn(String drug, String patient, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: PrimeCareTheme.colors.royalPurple, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(drug, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold)),
                Text(patient, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight, size: 16, color: PrimeCareTheme.colors.slateGray),
        ],
      ),
    );
  }

  Widget _buildPharmacyAlerts() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      border: Border.all(color: PrimeCareTheme.colors.amberWarning.withOpacity(0.3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.alertCircle, color: PrimeCareTheme.colors.amberWarning, size: 20),
              const SizedBox(width: 8),
              Text('Pharmacy Alerts', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Supply for "Atorvastatin 20mg" running low for 3 patients.',
            style: PrimeCareTheme.typography.body,
          ),
          const SizedBox(height: 12),
          ClinicalGlassButton(
            onPressed: () {},
            label: 'Request Refill',
            icon: LucideIcons.refreshCw,
          ),
        ],
      ),
    );
  }

  Widget _buildEMARTimeline() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Scheduled Administrations', style: PrimeCareTheme.typography.h2),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter: 12:00 PM',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildMedicationRow(
            time: '12:00 PM',
            patient: 'John Carmichael',
            room: 'Room 204A',
            medication: 'Metformin 500mg',
            route: 'Oral (PO)',
            status: 'Due',
          ),
          const Divider(height: 1),
          _buildMedicationRow(
            time: '12:00 PM',
            patient: 'Eleanor Vance',
            room: 'Room 205B',
            medication: 'Lisinopril 10mg',
            route: 'Oral (PO)',
            status: 'Due',
          ),
          const Divider(height: 1),
          _buildMedicationRow(
            time: '01:00 PM',
            patient: 'Arthur Dent',
            room: 'Room 102A',
            medication: 'Insulin Glargine 10u',
            route: 'Subcutaneous (SubQ)',
            status: 'Upcoming',
          ),
          const Divider(height: 1),
          _buildMedicationRow(
            time: '08:30 AM',
            patient: 'Sylvia Plath',
            room: 'Room 201A',
            medication: 'Morphine 5mg',
            route: 'Subcutaneous (SubQ) - PRN',
            status: 'Administered',
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationRow({
    required String time,
    required String patient,
    required String room,
    required String medication,
    required String route,
    required String status,
  }) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'Due':
        statusColor = PrimeCareTheme.colors.amberWarning;
        statusIcon = LucideIcons.clock;
        break;
      case 'Upcoming':
        statusColor = PrimeCareTheme.colors.royalPurple;
        statusIcon = LucideIcons.calendarClock;
        break;
      case 'Administered':
        statusColor = PrimeCareTheme.colors.emeraldTeal;
        statusIcon = LucideIcons.checkCircle;
        break;
      default:
        statusColor = PrimeCareTheme.colors.slateGray;
        statusIcon = LucideIcons.circle;
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              time,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.bold,
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medication, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 4),
                Text(route, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(LucideIcons.user, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text(patient, style: PrimeCareTheme.typography.body),
                    const SizedBox(width: 16),
                    Icon(LucideIcons.doorOpen, size: 14, color: PrimeCareTheme.colors.slateGray),
                    const SizedBox(width: 4),
                    Text(room, style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          if (status == 'Due')
            ClinicalGlassButton(
              onPressed: () {},
              label: 'Administer',
              icon: LucideIcons.scan,
            )
          else if (status == 'Upcoming')
            ClinicalGlassButton(
              onPressed: () {},
              label: 'Details',
              icon: LucideIcons.info,
            )
          else
             Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Verified',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.emeraldTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
