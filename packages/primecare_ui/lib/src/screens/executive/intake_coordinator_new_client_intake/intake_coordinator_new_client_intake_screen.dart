import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_coordinator_new_client_intake_screen_controller.dart';
import 'sections/intake_coordinator_new_client_intake_header_section.dart';
import 'sections/intake_coordinator_new_client_intake_form_body_section.dart';
import 'sections/intake_coordinator_new_client_intake_validation_messages_section.dart';
import 'sections/intake_coordinator_new_client_intake_action_bar_section.dart';


class IntakeCoordinatorNewClientIntakeScreen extends ConsumerWidget {
  const IntakeCoordinatorNewClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_coordinator_new_client_intakeControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeCoordinatorNewClientIntake'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_coordinator_new_client_intakeControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_coordinator_new_client_intake_loading'), child: Semantics(label: 'intake_coordinator_new_client_intake_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_coordinator_new_client_intake_screen'),
                    child: Column(
                      children: [
                        IntakeCoordinatorNewClientIntakeHeaderSection(data: state.data),
                        IntakeCoordinatorNewClientIntakeFormBodySection(data: state.data),
                        IntakeCoordinatorNewClientIntakeValidationMessagesSection(data: state.data),
                        IntakeCoordinatorNewClientIntakeActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
