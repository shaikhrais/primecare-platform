import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_command_center_screen_controller.dart';
import 'sections/psw_command_center_header_section.dart';
import 'sections/psw_command_center_filter_bar_section.dart';
import 'sections/psw_command_center_data_table_section.dart';
import 'sections/psw_command_center_pagination_section.dart';
import 'sections/psw_command_center_action_bar_section.dart';


class PswCommandCenterScreen extends ConsumerWidget {
  const PswCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_command_centerControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Psw Command Center'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_command_centerControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_command_center_loading'), child: Semantics(label: 'psw_command_center_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_command_center_screen'),
                    child: Column(
                      children: [
                        PswCommandCenterHeaderSection(data: state.data),
                        PswCommandCenterFilterBarSection(data: state.data),
                        PswCommandCenterDataTableSection(data: state.data),
                        PswCommandCenterPaginationSection(data: state.data),
                        PswCommandCenterActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
