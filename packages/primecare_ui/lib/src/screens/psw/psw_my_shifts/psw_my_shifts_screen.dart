import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_my_shifts_screen_controller.dart';
import 'sections/psw_my_shifts_header_section.dart';
import 'sections/psw_my_shifts_content_summary_section.dart';
import 'sections/psw_my_shifts_primary_content_section.dart';
import 'sections/psw_my_shifts_action_bar_section.dart';


class PswMyShiftsScreen extends ConsumerWidget {
  const PswMyShiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_my_shiftsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Psw My Shifts'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_my_shiftsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_my_shifts_loading'), child: Semantics(label: 'psw_my_shifts_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_my_shifts_screen'),
                    child: Column(
                      children: [
                        PswMyShiftsHeaderSection(data: state.data),
                        PswMyShiftsContentSummarySection(data: state.data),
                        PswMyShiftsPrimaryContentSection(data: state.data),
                        PswMyShiftsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
