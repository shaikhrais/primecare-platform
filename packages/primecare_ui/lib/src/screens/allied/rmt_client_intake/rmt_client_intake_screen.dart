import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_client_intake_screen_controller.dart';
import 'sections/rmt_client_intake_header_section.dart';
import 'sections/rmt_client_intake_content_summary_section.dart';
import 'sections/rmt_client_intake_primary_content_section.dart';
import 'sections/rmt_client_intake_action_bar_section.dart';


class RmtClientIntakeScreen extends ConsumerWidget {
  const RmtClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_client_intakeControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtClientIntake'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_client_intakeControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_client_intake_loading'), child: Semantics(label: 'rmt_client_intake_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_client_intake_screen'),
                    child: Column(
                      children: [
                        RmtClientIntakeHeaderSection(data: state.data),
                        RmtClientIntakeContentSummarySection(data: state.data),
                        RmtClientIntakePrimaryContentSection(data: state.data),
                        RmtClientIntakeActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
