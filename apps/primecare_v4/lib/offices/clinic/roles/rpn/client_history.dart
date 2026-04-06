import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnClientHistoryScreen extends ConsumerWidget {
  const RpnClientHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Client History',
      subtitle: 'Review comprehensive medical history and past treatments.',
      kpiCards: [
        KPICardData(
          title: 'Total Records',
          value: '142',
          icon: LucideIcons.folderClosed,
          trend: 0.0,
          trendLabel: 'on file',
        ),
        KPICardData(
          title: 'Recent Discharges',
          value: '1',
          icon: LucideIcons.logOut,
          trend: 0.0,
          trendLabel: 'this month',
        ),
        KPICardData(
          title: 'Alerts Active',
          value: '3',
          icon: LucideIcons.alertCircle,
          trend: -1.0,
          trendLabel: 'allergies & tags',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Client Selection', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search clients...',
                  prefixIcon: const Icon(LucideIcons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
               _buildClientListTile('Maria Garcia', 'Rm 201-A'),
               _buildClientListTile('John Smith', 'Rm 204-B'),
               _buildClientListTile('Eleanor Rigby', 'Rm 205-A'),
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
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Maria Garcia', style: PrimeCareTheme.typography.h2),
                       Text('DOB: 1945-08-12 (78 years) • Female', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                     ],
                   ),
                   Row(
                     children: [
                       _buildAllergyTag('Penicillin'),
                       const SizedBox(width: 8),
                       _buildAllergyTag('Latex'),
                     ],
                   )
                 ],
               ),
               const SizedBox(height: 32),
               Text('Past Medical History', style: PrimeCareTheme.typography.h3),
               const SizedBox(height: 16),
               _buildHistoryEntry(
                 'Type 2 Diabetes Mellitus',
                 'Diagnosed 2010',
                 'Managed with Metformin and dietary controls. Recent HbA1c 7.2%.',
                 LucideIcons.activity
               ),
               _buildHistoryEntry(
                 'Hypertension',
                 'Diagnosed 2015',
                 'Controlled with Lisinopril 10mg daily.',
                 LucideIcons.heart
               ),
                _buildHistoryEntry(
                 'Total Knee Replacement (Right)',
                 'Performed 2021',
                 'Full recovery. Routine physical therapy completed.',
                 LucideIcons.activitySquare
               ),
               const SizedBox(height: 32),
               Text('Recent Encounters', style: PrimeCareTheme.typography.h3),
               const SizedBox(height: 16),
               _buildEncounterEntry(
                 'Routine Follow-up',
                 'May 15, 2024',
                 'Dr. Thorne',
                 'Vitals stable. Patient denies any new concerns. Scheduled for 3-month follow-up.'
               ),
               _buildEncounterEntry(
                 'Wound Care Assessment',
                 'May 01, 2024',
                 'RN Sarah',
                 'Initial assessment of minor skin tear on left forearm. Cleaned and dressed. Healing well.'
               ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClientListTile(String name, String details) {
    return ListTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
        child: Text(name[0], style: TextStyle(color: PrimeCareTheme.colors.navyIndigo, fontSize: 12)),
      ),
      title: Text(name, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(details, style: TextStyle(fontSize: 12, color: PrimeCareTheme.colors.slateGray)),
      contentPadding: EdgeInsets.zero,
      onTap: () {},
    );
  }

  Widget _buildAllergyTag(String allergy) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.coralRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: PrimeCareTheme.colors.coralRed),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.alertTriangle, size: 14, color: PrimeCareTheme.colors.coralRed),
          const SizedBox(width: 4),
          Text(allergy, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.coralRed, fontWeight: FontWeight.bold)),
        ],
      )
    );
  }

  Widget _buildHistoryEntry(String condition, String date, String notes, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(condition, style: PrimeCareTheme.typography.h3),
                    Text(date, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(notes, style: PrimeCareTheme.typography.body),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildEncounterEntry(String type, String date, String provider, String notes) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: PrimeCareTheme.colors.slateGray.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(type, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
               Text(date, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
             ],
           ),
           const SizedBox(height: 4),
           Text('Provider: $provider', style: TextStyle(fontSize: 12, color: PrimeCareTheme.colors.navyIndigo)),
           const SizedBox(height: 8),
           Text(notes, style: PrimeCareTheme.typography.body),
        ],
      )
    );
  }
}
