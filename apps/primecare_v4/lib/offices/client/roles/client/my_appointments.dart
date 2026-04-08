import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'My Appointments',
      subtitle: 'Manage and review your upcoming clinical sessions',
      icon: LucideIcons.calendarDays,
      actions: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(LucideIcons.plus, size: 18),
          label: const Text('Book New'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PrimeCareTheme.primary,
            foregroundColor: PrimeCareTheme.onPrimary,
            elevation: 0,
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: PrimeCareTheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.stethoscope,
                              color: PrimeCareTheme.primary,
                            ),
                          ),
                          const SizedBox(width: PrimeCareTheme.spacing4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. Sarah Jenkins',
                                style: PrimeCareTheme.titleMedium,
                              ),
                              Text(
                                'General Checkup',
                                style: PrimeCareTheme.bodyMedium.copyWith(
                                  color: PrimeCareTheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Oct 24, 2026',
                            style: PrimeCareTheme.titleMedium.copyWith(
                              color: PrimeCareTheme.primary,
                            ),
                          ),
                          Text(
                            '10:30 AM',
                            style: PrimeCareTheme.bodyMedium.copyWith(
                              color: PrimeCareTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Reschedule',
                          style: TextStyle(
                            color: PrimeCareTheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing3),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimeCareTheme.primary.withOpacity(
                            0.1,
                          ),
                          foregroundColor: PrimeCareTheme.primary,
                          elevation: 0,
                        ),
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
