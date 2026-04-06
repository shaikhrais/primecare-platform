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
      subtitle: 'Manage active patient load • Shift 08 / Unit Capacity: 92%',
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
              Text('Units Overview', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 24),
              _buildFilterRow('North Wing', 10, PrimeCareTheme.colors.emeraldTeal),
              _buildFilterRow('South Wing', 8, PrimeCareTheme.colors.navyIndigo),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(32),
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
                    label: const Text('Filter / Sort'),
                    style: ElevatedButton.styleFrom(
                       backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                       foregroundColor: PrimeCareTheme.colors.onSurface,
                       elevation: 0,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 32),
               _buildClientCard(
                 context: context,
                 name: 'Eleanor Shellstrop',
                 room: 'North Wing • Room 204-B',
                 statusLabel: 'Needs Review',
                 acuity: 'Level 5 - Critical',
                 statusColor: PrimeCareTheme.colors.coralRed,
               ),
               _buildClientCard(
                 context: context,
                 name: 'Chidi Anagonye',
                 room: 'North Wing • Room 205-A',
                 statusLabel: 'Stable',
                 acuity: 'Level 2 - Routine',
                 statusColor: PrimeCareTheme.colors.emeraldTeal,
               ),
               _buildClientCard(
                 context: context,
                 name: 'Tahani Al-Jamil',
                 room: 'South Wing • Room 102-C',
                 statusLabel: 'Monitoring',
                 acuity: 'Level 3 - Moderate',
                 statusColor: PrimeCareTheme.colors.lavenderLustre,
               ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
               Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildClientCard({
    required BuildContext context,
    required String name,
    required String room,
    required String statusLabel,
    required String acuity,
    required Color statusColor,
  }) {
     return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLowest.withOpacity(0.8), // Glassmorphic base
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           CircleAvatar(
             radius: 28,
             backgroundColor: statusColor.withOpacity(0.15),
             child: Text(name[0], style: PrimeCareTheme.typography.h3.copyWith(color: statusColor)),
           ),
           const SizedBox(width: 24),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Row(
                    children: [
                      Text(name, style: PrimeCareTheme.typography.h3),
                      const SizedBox(width: 12),
                      // Acuity Chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          acuity, 
                          style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold)
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Status Label
                      Text(
                        statusLabel, 
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray, 
                          fontStyle: FontStyle.italic
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(room, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
               ],
             )
           ),
           // Quick Actions
           Row(
             children: [
                _buildQuickActionBtn(
                  icon: LucideIcons.pill, 
                  label: 'Meds', 
                  color: PrimeCareTheme.colors.primary,
                  onTap: () {}
                ),
                const SizedBox(width: 12),
                _buildQuickActionBtn(
                  icon: LucideIcons.activity, 
                  label: 'Vitals', 
                  color: PrimeCareTheme.colors.lavenderLustre,
                  onTap: () {}
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: PrimeCareTheme.colors.outlineVariant.withOpacity(0.2)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text('View Profile'),
                )
             ],
           )
        ],
      )
     );
  }

  Widget _buildQuickActionBtn({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(label, style: PrimeCareTheme.typography.label.copyWith(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
