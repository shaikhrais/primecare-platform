import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PatientAppointmentsScreen extends ConsumerWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'My Appointments',
      subtitle: 'Manage and review your upcoming care visits',
      icon: LucideIcons.calendar,
      actions: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [PrimeCareTheme.primary, PrimeCareTheme.primaryContainer],
            ),
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: PrimeCareTheme.spacing5, vertical: PrimeCareTheme.spacing3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl)),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.calendarPlus, color: PrimeCareTheme.onPrimary, size: 18),
                const SizedBox(width: PrimeCareTheme.spacing2),
                Text('Book New Visit', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.onPrimary)),
              ],
            ),
          ),
        ),
      ],
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Upcoming
          Expanded(
            flex: 6,
            child: ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Upcoming Visits', style: PrimeCareTheme.titleLarge),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  _buildAppointmentCard(
                    providerName: 'Dr. Sarah Smith',
                    specialty: 'Physiotherapist',
                    date: 'Thu, Oct 12',
                    time: '02:00 PM',
                    type: 'In-Clinic',
                    isUrgent: false,
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  _buildAppointmentCard(
                    providerName: 'Nurse Mark Davies',
                    specialty: 'Wound Care Specialist',
                    date: 'Mon, Oct 16',
                    time: '09:30 AM',
                    type: 'Virtual',
                    isUrgent: false,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: PrimeCareTheme.spacing5),
          // Right side: Past
          Expanded(
            flex: 4,
            child: ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text('Past Visits', style: PrimeCareTheme.titleLarge),
                    const SizedBox(height: PrimeCareTheme.spacing4),
                    _buildPastAppointmentRow('Dr. Sarah Smith', 'Oct 5, 2026', 'Completed'),
                    const SizedBox(height: PrimeCareTheme.spacing3),
                    _buildPastAppointmentRow('Dr. Chen', 'Sep 22, 2026', 'Completed'),
                    const SizedBox(height: PrimeCareTheme.spacing3),
                    _buildPastAppointmentRow('Dietitian Ops', 'Sep 10, 2026', 'Cancelled'),
                    const SizedBox(height: PrimeCareTheme.spacing5),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('View Full History', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
                      ),
                    )
                 ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String providerName,
    required String specialty,
    required String date,
    required String time,
    required String type,
    required bool isUrgent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
        boxShadow: [
          BoxShadow(
            color: PrimeCareTheme.primary.withOpacity(0.04),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: PrimeCareTheme.surfaceContainerHigh,
                          child: const Icon(LucideIcons.user, color: PrimeCareTheme.primary, size: 28),
                        ),
                        const SizedBox(width: PrimeCareTheme.spacing3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(providerName, style: PrimeCareTheme.titleMedium),
                            Text(specialty, style: PrimeCareTheme.labelMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: type == 'Virtual' ? PrimeCareTheme.secondaryContainer : PrimeCareTheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusFull),
                      ),
                      child: Row(
                        children: [
                          Icon(type == 'Virtual' ? LucideIcons.video : LucideIcons.mapPin, size: 14, color: type == 'Virtual' ? PrimeCareTheme.onSecondaryContainer : PrimeCareTheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(type, style: PrimeCareTheme.labelSmall.copyWith(color: type == 'Virtual' ? PrimeCareTheme.onSecondaryContainer : PrimeCareTheme.onSurfaceVariant, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: PrimeCareTheme.spacing4),
                Row(
                  children: [
                    Expanded(
                      child: _buildTimeDetailBox(LucideIcons.calendar, 'Date', date),
                    ),
                    const SizedBox(width: PrimeCareTheme.spacing3),
                    Expanded(
                      child: _buildTimeDetailBox(LucideIcons.clock, 'Time', time),
                    ),
                  ],
                ),
                const SizedBox(height: PrimeCareTheme.spacing5),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimeCareTheme.surfaceContainerHighest,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: PrimeCareTheme.spacing3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg)),
                        ),
                        child: Text('Reschedule', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
                      ),
                    ),
                    const SizedBox(width: PrimeCareTheme.spacing3),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: PrimeCareTheme.error.withOpacity(0.3)),
                          padding: const EdgeInsets.symmetric(vertical: PrimeCareTheme.spacing3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg)),
                        ),
                        child: Text('Cancel', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.error)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDetailBox(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing3),
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerHigh.withOpacity(0.5),
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: PrimeCareTheme.primary),
          const SizedBox(width: PrimeCareTheme.spacing3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
              Text(value, style: PrimeCareTheme.titleSmall),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPastAppointmentRow(String name, String date, String status) {
    return Container(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing3),
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: PrimeCareTheme.surfaceContainerLow,
            child: Icon(LucideIcons.user, size: 18, color: PrimeCareTheme.onSurfaceVariant),
          ),
          const SizedBox(width: PrimeCareTheme.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: PrimeCareTheme.titleSmall),
                Text(date, style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
              ],
            ),
          ),
          Text(
            status,
            style: PrimeCareTheme.labelSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: status == 'Completed' ? PrimeCareTheme.tertiary : PrimeCareTheme.error,
            ),
          )
        ],
      ),
    );
  }
}
