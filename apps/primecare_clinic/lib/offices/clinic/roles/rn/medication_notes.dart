import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class MedicationAdministrationScreen extends ConsumerWidget {
  const MedicationAdministrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Medication Administration (MAR)',
      subtitle: 'Track, verify, and document client medications.',
      kpiCards: [
        KPICardData(
          title: 'Due Now',
          value: '8',
          icon: LucideIcons.clock,
          trend: 0.0,
          trendLabel: 'across 5 clients',
        ),
        KPICardData(
          title: 'Given Today',
          value: '35',
          icon: LucideIcons.checkCircle2,
          trend: 10.0,
          trendLabel: 'doses administered',
        ),
        KPICardData(
          title: 'Missed/Refused',
          value: '1',
          icon: LucideIcons.xCircle,
          trend: -5.0,
          trendLabel: 'requires follow up',
        ),
        KPICardData(
          title: 'PRN Given',
          value: '4',
          icon: LucideIcons.activity,
          trend: 0.0,
          trendLabel: 'as needed meds',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Schedule Filter', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Morning (08:00 - 12:00)', true),
              _buildFilterRow('Afternoon (12:00 - 17:00)', false),
              _buildFilterRow('Evening (17:00 - 22:00)', false),
              _buildFilterRow('Night (22:00 - 08:00)', false),
              _buildFilterRow('PRN (As Needed)', false),
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
                    'Morning Medications',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  Text(
                    '10:00 AM',
                    style: PrimeCareTheme.typography.h3.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildClientMedicationGroup('Eleanor Rigby', 'Room 204', [
                _MedicationItem(
                  'Lisinopril',
                  '10mg',
                  'PO',
                  '09:00',
                  PrimeCareTheme.colors.emeraldTeal,
                  'Given',
                ),
                _MedicationItem(
                  'Metformin',
                  '500mg',
                  'PO',
                  '09:00',
                  PrimeCareTheme.colors.emeraldTeal,
                  'Given',
                ),
                _MedicationItem(
                  'Furosemide',
                  '20mg',
                  'PO',
                  '10:00',
                  PrimeCareTheme.colors.coralRed,
                  'Due Now',
                ),
              ]),
              const SizedBox(height: 16),
              _buildClientMedicationGroup('John Smith', 'Room 112', [
                _MedicationItem(
                  'Insulin Glargine',
                  '15 units',
                  'SubQ',
                  '08:00',
                  PrimeCareTheme.colors.emeraldTeal,
                  'Given',
                ),
                _MedicationItem(
                  'Aspirin',
                  '81mg',
                  'PO',
                  '10:00',
                  PrimeCareTheme.colors.coralRed,
                  'Due Now',
                ),
              ]),
              const SizedBox(height: 32),
              Text('PRN Requests', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildPrnRequest(
                'Maria Garcia',
                'Acetaminophen',
                '500mg PO for Headache (Reported 6/10)',
                '10:15 AM',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimeCareTheme.colors.navyIndigo.withOpacity(0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: PrimeCareTheme.typography.body.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? PrimeCareTheme.colors.navyIndigo
                  : PrimeCareTheme.colors.textPrimary,
            ),
          ),
          if (isSelected)
            Icon(
              LucideIcons.check,
              size: 16,
              color: PrimeCareTheme.colors.navyIndigo,
            ),
        ],
      ),
    );
  }

  Widget _buildClientMedicationGroup(
    String clientName,
    String location,
    List<_MedicationItem> medications,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(clientName, style: PrimeCareTheme.typography.h3),
              Text(
                location,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...medications.map((med) => _buildMedicationRow(med)).toList(),
        ],
      ),
    );
  }

  Widget _buildMedicationRow(_MedicationItem med) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: med.statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              med.time,
              style: PrimeCareTheme.typography.label.copyWith(
                color: med.statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  med.name,
                  style: PrimeCareTheme.typography.body.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${med.dose} • ${med.route}',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          if (med.status == 'Due Now')
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimeCareTheme.colors.navyIndigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: const Text('Administer'),
            )
          else
            Text(
              med.status,
              style: PrimeCareTheme.typography.label.copyWith(
                color: med.statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPrnRequest(
    String clientName,
    String medication,
    String reason,
    String time,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.lavenderLustre.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareTheme.colors.lavenderLustre.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$clientName - $time',
                style: PrimeCareTheme.typography.label.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(medication, style: PrimeCareTheme.typography.body),
              Text(
                reason,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimeCareTheme.colors.lavenderLustre,
              foregroundColor: Colors.black87,
            ),
            child: const Text('Review PRN'),
          ),
        ],
      ),
    );
  }
}

class _MedicationItem {
  final String name;
  final String dose;
  final String route;
  final String time;
  final Color statusColor;
  final String status;

  _MedicationItem(
    this.name,
    this.dose,
    this.route,
    this.time,
    this.statusColor,
    this.status,
  );
}
