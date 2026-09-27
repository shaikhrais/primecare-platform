import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_vitals_log_screen_controller.dart';
import 'sections/psw_vitals_log_header_section.dart';
import 'sections/psw_vitals_log_filter_bar_section.dart';
import 'sections/psw_vitals_log_data_table_section.dart';
import 'sections/psw_vitals_log_pagination_section.dart';
import 'sections/psw_vitals_log_action_bar_section.dart';


class VitalsEntryScreen extends ConsumerWidget {
  const VitalsEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_vitals_logControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Vitals Entry'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_vitals_logControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_vitals_log_loading'), child: Semantics(label: 'psw_vitals_log_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_vitals_log_screen'),
                    child: Column(
                      children: [
                        PswVitalsLogHeaderSection(data: state.data),
                        PswVitalsLogFilterBarSection(data: state.data),
                        PswVitalsLogDataTableSection(data: state.data),
                        PswVitalsLogPaginationSection(data: state.data),
                        PswVitalsLogActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef PswVitalsLogScreen = VitalsEntryScreen;
