import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'attendance_screen_controller.dart';
import 'sections/attendance_header_section.dart';
import 'sections/attendance_content_summary_section.dart';
import 'sections/attendance_primary_content_section.dart';
import 'sections/attendance_action_bar_section.dart';


class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Attendance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(attendanceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('attendance_loading'), child: Semantics(label: 'attendance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('attendance_screen'),
                    child: Column(
                      children: [
                        AttendanceHeaderSection(data: state.data),
                        AttendanceContentSummarySection(data: state.data),
                        AttendancePrimaryContentSection(data: state.data),
                        AttendanceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
