// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

import 'package:primecare_ui/src/components/forms/clinical/01_I_vitals_capture_form.dart';
import 'package:primecare_ui/src/components/forms/clinical/01_I_patient_intake_form.dart';

class ClinicalDashboard extends ConsumerWidget {
  const ClinicalDashboard({super.key});

      @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(clinicDashboardAdapterProvider);
    
    return PageTemplate(
      title: 'Clinical Dashboard',
      subtitle: 'Clinical outcomes and patient care overview',
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimeCareButton(
              onPressed: () => _showIntake(context),
              text: 'New Intake',
              icon: Icons.person_add_rounded,
            ),
            const SizedBox(width: 8),
            PrimeCareButton(
              onPressed: () => _showVitalsCapture(context),
              text: 'Capture Vitals',
              icon: Icons.favorite_rounded,
              isPrimary: true,
            ),
          ],
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => PrimeCareResponsiveKpiGrid(
            children: data.kpis.map((kpi) => PrimeCareKpiCard(
              title: kpi.title,
              value: kpi.value,
              subtitle: kpi.subtitle ?? '',
              icon: _getIconForMetric(kpi.title),
              onPinToggle: () {},
            )).toList(),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  void _showIntake(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 900),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: PatientIntakeForm(
              onSuccess: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }

  void _showVitalsCapture(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: VitalsCaptureForm(
              onSuccess: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient')) return Icons.people_outline;
    if (t.contains('claim') || t.contains('revenue') || t.contains('price')) return Icons.payments_outlined;
    if (t.contains('staff') || t.contains('capacity')) return Icons.badge_outlined;
    if (t.contains('alert') || t.contains('incident')) return Icons.notification_important_outlined;
    if (t.contains('task') || t.contains('todo')) return Icons.assignment_outlined;
    if (t.contains('message') || t.contains('chat')) return Icons.forum_outlined;
    if (t.contains('file') || t.contains('doc') || t.contains('vault')) return Icons.inventory_2_outlined;
    return Icons.analytics_outlined;
  }
}
