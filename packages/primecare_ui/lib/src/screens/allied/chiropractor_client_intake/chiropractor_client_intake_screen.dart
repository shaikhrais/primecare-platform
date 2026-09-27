import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_client_intake_screen_controller.dart';
import 'sections/chiropractor_client_intake_header_section.dart';
import 'sections/chiropractor_client_intake_content_summary_section.dart';
import 'sections/chiropractor_client_intake_primary_content_section.dart';
import 'sections/chiropractor_client_intake_action_bar_section.dart';


class ChiropractorClientIntakeScreen extends ConsumerWidget {
  const ChiropractorClientIntakeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_client_intakeControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorClientIntake'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_client_intakeControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_client_intake_loading'), child: Semantics(label: 'chiropractor_client_intake_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_client_intake_screen'),
                    child: Column(
                      children: [
                        ChiropractorClientIntakeHeaderSection(data: state.data),
                        ChiropractorClientIntakeContentSummarySection(data: state.data),
                        ChiropractorClientIntakePrimaryContentSection(data: state.data),
                        ChiropractorClientIntakeActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
