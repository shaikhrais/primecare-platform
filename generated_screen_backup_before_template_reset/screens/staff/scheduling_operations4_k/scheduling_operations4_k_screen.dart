import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduling_operations4_k_header_section.dart';
import 'sections/scheduling_operations4_k_content_summary_section.dart';
import 'sections/scheduling_operations4_k_primary_content_section.dart';
import 'sections/scheduling_operations4_k_action_bar_section.dart';

class SchedulingOperations4KScreen extends StatelessWidget {
  const SchedulingOperations4KScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduling_operations4_k',
      title: 'SchedulingOperations4KScreen',
      child: Column(
        children: const [
          const SchedulingOperations4KHeaderSection(),
          const SchedulingOperations4KContentSummarySection(),
          const SchedulingOperations4KPrimaryContentSection(),
          const SchedulingOperations4KActionBarSection(),
        ],
      ),
    );
  }
}
