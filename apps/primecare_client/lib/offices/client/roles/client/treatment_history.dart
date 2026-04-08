import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TreatmentHistoryScreen extends StatelessWidget {
  const TreatmentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Treatment History',
      subtitle: 'Review past clinical sessions, assessments, and care events',
      icon: LucideIcons.history,
      actions: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(LucideIcons.download, size: 18),
          label: const Text('Export History'),
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
                              color: PrimeCareTheme.tertiary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.fileText,
                              color: PrimeCareTheme.tertiary,
                            ),
                          ),
                          const SizedBox(width: PrimeCareTheme.spacing4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Physiotherapy Assessment',
                                style: PrimeCareTheme.titleMedium,
                              ),
                              Text(
                                'Dr. Alan P.',
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
                            'Completed',
                            style: PrimeCareTheme.labelMedium.copyWith(
                              color: PrimeCareTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Sep 12, 2026',
                            style: PrimeCareTheme.bodyMedium.copyWith(
                              color: PrimeCareTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  Container(
                    padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(
                        PrimeCareTheme.radiusMd,
                      ),
                    ),
                    child: Text(
                      'Patient reports reduced pain in lower back after morning routine. Recommended continuation of current exercise plan with addition of core strengthening. Follow up in 4 weeks.',
                      style: PrimeCareTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.fileText, size: 16),
                      label: const Text('View Full Report'),
                    ),
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
