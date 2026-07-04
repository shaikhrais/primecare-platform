import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_intake_forms_header_section.dart';
import 'sections/intake_coordinator_intake_forms_form_body_section.dart';
import 'sections/intake_coordinator_intake_forms_validation_messages_section.dart';
import 'sections/intake_coordinator_intake_forms_action_bar_section.dart';

class IntakeCoordinatorIntakeFormsScreen extends StatelessWidget {
  const IntakeCoordinatorIntakeFormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_intake_forms',
      title: 'Intake Coordinator Intake Forms',
      child: Column(
        children: const [
          const IntakeCoordinatorIntakeFormsHeaderSection(),
          const IntakeCoordinatorIntakeFormsFormBodySection(),
          const IntakeCoordinatorIntakeFormsValidationMessagesSection(),
          const IntakeCoordinatorIntakeFormsActionBarSection(),
        ],
      ),
    );
  }
}
