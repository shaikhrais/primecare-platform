import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_new_intakes_header_section.dart';
import 'sections/intake_coordinator_new_intakes_form_body_section.dart';
import 'sections/intake_coordinator_new_intakes_validation_messages_section.dart';
import 'sections/intake_coordinator_new_intakes_action_bar_section.dart';

class IntakeCoordinatorNewIntakesScreen extends StatelessWidget {
  const IntakeCoordinatorNewIntakesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_new_intakes',
      title: 'Intake Coordinator New Intakes',
      child: Column(
        children: const [
          const IntakeCoordinatorNewIntakesHeaderSection(),
          const IntakeCoordinatorNewIntakesFormBodySection(),
          const IntakeCoordinatorNewIntakesValidationMessagesSection(),
          const IntakeCoordinatorNewIntakesActionBarSection(),
        ],
      ),
    );
  }
}
