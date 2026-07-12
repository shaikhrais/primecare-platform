import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coordinator_waitlist_screen_controller.dart';
import 'sections/coordinator_waitlist_header_section.dart';
import 'sections/coordinator_waitlist_filter_bar_section.dart';
import 'sections/coordinator_waitlist_data_table_section.dart';
import 'sections/coordinator_waitlist_pagination_section.dart';
import 'sections/coordinator_waitlist_action_bar_section.dart';


class CoordinatorWaitlistScreen extends ConsumerWidget {
  const CoordinatorWaitlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coordinator_waitlistControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CoordinatorWaitlist'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coordinator_waitlistControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coordinator_waitlist_loading'), child: Semantics(label: 'coordinator_waitlist_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coordinator_waitlist_screen'),
                    child: Column(
                      children: [
                        CoordinatorWaitlistHeaderSection(data: state.data),
                        CoordinatorWaitlistFilterBarSection(data: state.data),
                        CoordinatorWaitlistDataTableSection(data: state.data),
                        CoordinatorWaitlistPaginationSection(data: state.data),
                        CoordinatorWaitlistActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
