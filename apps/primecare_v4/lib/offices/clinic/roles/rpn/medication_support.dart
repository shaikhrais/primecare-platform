import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnMedicationSupportScreen extends ConsumerWidget {
  const RpnMedicationSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Medication Administration Record',
      subtitle: 'Securely track, verify, and administer patient medications.',
      kpiCards: [
        KPICardData(
          title: 'Morning Pass',
          value: '12 / 14',
          icon: LucideIcons.sun,
          trend: 1.0,
          trendLabel: 'on time',
        ),
        KPICardData(
          title: 'Overdue',
          value: '1',
          icon: LucideIcons.alertOctagon,
          trend: -1.0,
          trendLabel: 'requires action',
        ),
         KPICardData(
          title: 'PRN Given',
          value: '3',
          icon: LucideIcons.pill,
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
              Text('Medication Pass Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 24),
              _buildStatusFilter('Completed', 12, PrimeCareTheme.colors.tertiary),
              _buildStatusFilter('Pending (Soon)', 4, PrimeCareTheme.colors.primary),
              _buildStatusFilter('Overdue', 1, PrimeCareTheme.colors.error),
              _buildStatusFilter('Refused / Held', 1, PrimeCareTheme.colors.secondary),
            ],
          ),
        ),
      ],
      mainContent: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     'Current Administration Block',
                     style: PrimeCareTheme.typography.h2,
                   ),
                   Row(
                     children: [
                       Icon(LucideIcons.calendarClock, size: 18, color: PrimeCareTheme.colors.primary),
                       const SizedBox(width: 8),
                       Text('10:00 AM Pass', style: TextStyle(color: PrimeCareTheme.colors.primary, fontWeight: FontWeight.bold)),
                     ],
                   )
                 ],
               ),
             ),
             _buildMedicationCard(
               patientName: 'Arthur Dent',
               room: 'Room 201-B',
               medicationName: 'Amlodipine',
               dosage: '5mg',
               route: 'PO (Oral)',
               scheduledTime: '10:00 AM',
               instructions: 'Take with food. New order from Dr. Thorne. Check BP before administration.',
               status: 'Overdue',
               isHighAlert: true,
             ),
             const SizedBox(height: 16),
             _buildMedicationCard(
               patientName: 'Maria Garcia',
               room: 'Room 201-A',
               medicationName: 'Metformin',
               dosage: '500mg',
               route: 'PO (Oral)',
               scheduledTime: '10:00 AM',
               instructions: 'Give with morning meal.',
               status: 'Pending',
               isHighAlert: false,
             ),
             const SizedBox(height: 16),
             _buildMedicationCard(
               patientName: 'John Smith',
               room: 'Room 204-B',
               medicationName: 'Atorvastatin',
               dosage: '20mg',
               route: 'PO (Oral)',
               scheduledTime: '10:00 AM',
               instructions: 'Routine daily dose.',
               status: 'Completed',
               isHighAlert: false,
             ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusFilter(String label, int count, Color color) {
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
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
              ),
              const SizedBox(width: 12),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.onSurface,
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard({
    required String patientName,
    required String room,
    required String medicationName,
    required String dosage,
    required String route,
    required String scheduledTime,
    required String instructions,
    required String status,
    required bool isHighAlert,
  }) {
    final bool isCompleted = status == 'Completed';
    final bool isOverdue = status == 'Overdue';
    
    // Choose theme colors based on state
    Color accentColor = PrimeCareTheme.colors.primary;
    if (isCompleted) accentColor = PrimeCareTheme.colors.tertiary;
    if (isOverdue) accentColor = PrimeCareTheme.colors.error;

    return Stack(
      children: [
        if (isHighAlert || isOverdue)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 3.0,
                  colors: [
                    accentColor.withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: PrimeCareTheme.colors.surface.withOpacity(0.5),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
            ]
          ),
          child: ClinicalGlassPanel(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(LucideIcons.user, size: 18, color: PrimeCareTheme.colors.secondary),
                        const SizedBox(width: 8),
                        Text(patientName, style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                        const SizedBox(width: 16),
                        Icon(LucideIcons.mapPin, size: 16, color: PrimeCareTheme.colors.outline),
                        const SizedBox(width: 8),
                        Text(room, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.outline)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: accentColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCompleted ? LucideIcons.checkCircle : (isOverdue ? LucideIcons.alertOctagon : LucideIcons.clock),
                            size: 14,
                            color: accentColor,
                          ),
                          const SizedBox(width: 8),
                          Text(status.toUpperCase(), style: PrimeCareTheme.typography.label.copyWith(
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isCompleted ? PrimeCareTheme.colors.surfaceContainerHighest : PrimeCareTheme.colors.navyIndigo.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        LucideIcons.pill, 
                        size: 32, 
                        color: isCompleted ? PrimeCareTheme.colors.outline : PrimeCareTheme.colors.primaryFixed
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(medicationName, style: PrimeCareTheme.typography.display.copyWith(fontSize: 28)),
                              const SizedBox(width: 12),
                              Text(dosage, style: PrimeCareTheme.typography.h2.copyWith(color: PrimeCareTheme.colors.primary)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Route: $route', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.outline)),
                              const SizedBox(width: 16),
                              Text('•', style: TextStyle(color: PrimeCareTheme.colors.outline)),
                              const SizedBox(width: 16),
                              Text('Scheduled: $scheduledTime', style: PrimeCareTheme.typography.label.copyWith(
                                color: isOverdue ? PrimeCareTheme.colors.error : PrimeCareTheme.colors.outline
                              )),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isHighAlert ? PrimeCareTheme.colors.error.withOpacity(0.05) : PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: isHighAlert ? Border.all(color: PrimeCareTheme.colors.error.withOpacity(0.2)) : null,
                            ),
                            child: Row(
                              children: [
                                Icon(LucideIcons.info, size: 16, color: isHighAlert ? PrimeCareTheme.colors.error : PrimeCareTheme.colors.onSurfaceVariant),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    instructions,
                                    style: PrimeCareTheme.typography.body.copyWith(
                                      color: isHighAlert ? PrimeCareTheme.colors.error : PrimeCareTheme.colors.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                if (!isCompleted) ...[
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: PrimeCareTheme.colors.error,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text('Refuse', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: PrimeCareTheme.colors.onSurface,
                          side: BorderSide(color: PrimeCareTheme.colors.outlineVariant),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        child: const Text('Hold Dose', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              PrimeCareTheme.colors.primary,
                              PrimeCareTheme.colors.primaryContainer,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.check, color: Colors.white),
                          label: const Text('Administer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  )
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
