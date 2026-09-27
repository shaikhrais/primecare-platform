import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_director_performance_screen_controller.dart';
import 'sections/clinical_director_performance_header_section.dart';
import 'sections/clinical_director_performance_form_body_section.dart';
import 'sections/clinical_director_performance_validation_messages_section.dart';
import 'sections/clinical_director_performance_action_bar_section.dart';


class ClinicalDirectorPerformanceScreen extends ConsumerWidget {
  const ClinicalDirectorPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_director_performanceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalDirectorPerformance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_director_performanceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_director_performance_loading'), child: Semantics(label: 'clinical_director_performance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_director_performance_screen'),
                    child: Column(
                      children: [
                        ClinicalDirectorPerformanceHeaderSection(data: state.data),
                        ClinicalDirectorPerformanceFormBodySection(data: state.data),
                        ClinicalDirectorPerformanceValidationMessagesSection(data: state.data),
                        ClinicalDirectorPerformanceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
