import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'prime_care_screen_controller.dart';
import 'sections/prime_care_header_section.dart';
import 'sections/prime_care_content_summary_section.dart';
import 'sections/prime_care_primary_content_section.dart';
import 'sections/prime_care_action_bar_section.dart';


class PrimeCareScreen extends ConsumerWidget {
  const PrimeCareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(prime_careControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Prime Care'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(prime_careControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('prime_care_loading'), child: Semantics(label: 'prime_care_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('prime_care_screen'),
                    child: Column(
                      children: [
                        PrimeCareHeaderSection(data: state.data),
                        PrimeCareContentSummarySection(data: state.data),
                        PrimeCarePrimaryContentSection(data: state.data),
                        PrimeCareActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
