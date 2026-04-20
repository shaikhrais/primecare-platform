// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_adapters/primecare_adapters.dart';
import '../../components/forms/clinical/vitals_capture_form.dart';
import '../../components/forms/clinical/patient_intake_form.dart';

class ClinicalDashboard extends ConsumerWidget {
  const ClinicalDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<Result<ClinicDashboardViewModel>>(
      title: 'Clinical Dashboard',
      subtitle: 'Clinical outcomes and patient care overview',
      provider: clinicDashboardAdapterProvider,
      actionButton: Row(
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
    );
  }

  void _showIntake(BuildContext context) {
    showDialog(
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
    showDialog(
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
}
