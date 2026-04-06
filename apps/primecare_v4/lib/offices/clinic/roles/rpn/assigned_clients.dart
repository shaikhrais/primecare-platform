import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnAssignedClientsScreen extends ConsumerWidget {
  const RpnAssignedClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Assigned Clients',
      subtitle: 'Manage your active patient load and assignments.',
      kpiCards: [
        KPICardData(
          title: 'Total Active',
          value: '18',
          icon: LucideIcons.users,
          trend: 2.0,
          trendLabel: 'vs last week',
        ),
        KPICardData(
          title: 'High Acuity',
          value: '4',
          icon: LucideIcons.alertCircle,
          trend: 0.0,
          trendLabel: 'stable',
        ),
        KPICardData(
          title: 'New Admits',
          value: '2',
          icon: LucideIcons.userPlus,
          trend: 1.0,
          trendLabel: 'this shift',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Units', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('North Wing', 10, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow('South Wing', 8, PrimeCareTheme.colors.lavenderLustre),
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
                    icon: const Icon(LucideIcons.filter),
                    label: const Text('Filter'),
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white.withOpacity(0.1),
                       foregroundColor: PrimeCareTheme.colors.navyIndigo,
                       elevation: 0,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildClientCard(
                 'Maria Garcia',
                 'Room 201-A',
                 'Diabetic Management, Hypertension',
                 'High',
                 PrimeCareTheme.colors.coralRed
               ),
               _buildClientCard(
                 'John Smith',
                 'Room 204-B',
                 'Post-Op Recovery, Wound Care',
                 'Medium',
                 PrimeCareTheme.colors.lavenderLustre
               ),
               _buildClientCard(
                 'Eleanor Rigby',
                 'Room 205-A',
                 'Routine Monitoring, Mobility Assist',
                 'Low',
                 PrimeCareTheme.colors.emeraldTeal
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
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildClientCard(String name, String room, String careDetails, String acuity, Color statusColor) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: statusColor, width: 4)),
      ),
      child: Row(
        children: [
           CircleAvatar(
             radius: 24,
             backgroundColor: statusColor.withOpacity(0.2),
             child: Text(name[0], style: PrimeCareTheme.typography.h3.copyWith(color: statusColor)),
           ),
           const SizedBox(width: 16),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Row(
                    children: [
                      Text(name, style: PrimeCareTheme.typography.h3),
                      const SizedBox(width: 8),
                       Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(acuity, style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('$room • $careDetails', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
               ],
             )
           ),
           OutlinedButton(
             onPressed: () {},
             child: const Text('View Profile'),
           )
        ],
      )
     );
  }
}
