import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hsw_adl_logger_screen_controller.dart';
import 'sections/hsw_adl_logger_header_section.dart';
import 'sections/hsw_adl_logger_filter_bar_section.dart';
import 'sections/hsw_adl_logger_data_table_section.dart';
import 'sections/hsw_adl_logger_pagination_section.dart';
import 'sections/hsw_adl_logger_action_bar_section.dart';


class HswAdlLoggerScreen extends ConsumerWidget {
  const HswAdlLoggerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hsw_adl_loggerControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HswAdlLogger'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hsw_adl_loggerControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hsw_adl_logger_loading'), child: Semantics(label: 'hsw_adl_logger_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hsw_adl_logger_screen'),
                    child: Column(
                      children: [
                        HswAdlLoggerHeaderSection(data: state.data),
                        HswAdlLoggerFilterBarSection(data: state.data),
                        HswAdlLoggerDataTableSection(data: state.data),
                        HswAdlLoggerPaginationSection(data: state.data),
                        HswAdlLoggerActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
