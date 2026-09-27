import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'client_intake_screen_controller.dart';
import 'sections/client_intake_header_section.dart';
import 'sections/client_intake_content_summary_section.dart';
import 'sections/client_intake_primary_content_section.dart';
import 'sections/client_intake_action_bar_section.dart';


class ClientIntakeScreen extends ConsumerWidget {
  const ClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(client_intakeControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClientIntake'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(client_intakeControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('client_intake_loading'), child: Semantics(label: 'client_intake_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('client_intake_screen'),
                    child: Column(
                      children: [
                        ClientIntakeHeaderSection(data: state.data),
                        ClientIntakeContentSummarySection(data: state.data),
                        ClientIntakePrimaryContentSection(data: state.data),
                        ClientIntakeActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
