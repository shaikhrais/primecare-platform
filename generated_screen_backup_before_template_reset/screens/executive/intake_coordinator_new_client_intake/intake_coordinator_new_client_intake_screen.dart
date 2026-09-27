import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_new_client_intake_header_section.dart';
import 'sections/intake_coordinator_new_client_intake_form_body_section.dart';
import 'sections/intake_coordinator_new_client_intake_validation_messages_section.dart';
import 'sections/intake_coordinator_new_client_intake_action_bar_section.dart';

class IntakeCoordinatorNewClientIntakeScreen extends StatelessWidget {
  const IntakeCoordinatorNewClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_new_client_intake',
      title: 'IntakeCoordinatorNewClientIntakeScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorNewClientIntakeHeaderSection(),
          const IntakeCoordinatorNewClientIntakeFormBodySection(),
          const IntakeCoordinatorNewClientIntakeValidationMessagesSection(),
          const IntakeCoordinatorNewClientIntakeActionBarSection(),
        ],
      ),
    );
  }
}
