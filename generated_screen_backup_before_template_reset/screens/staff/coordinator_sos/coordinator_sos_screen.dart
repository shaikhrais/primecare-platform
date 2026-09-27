import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coordinator_sos_header_section.dart';
import 'sections/coordinator_sos_content_summary_section.dart';
import 'sections/coordinator_sos_primary_content_section.dart';
import 'sections/coordinator_sos_action_bar_section.dart';

class CoordinatorSosScreen extends StatelessWidget {
  const CoordinatorSosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coordinator_sos',
      title: 'CoordinatorSosScreen',
      child: Column(
        children: const [
          const CoordinatorSosHeaderSection(),
          const CoordinatorSosContentSummarySection(),
          const CoordinatorSosPrimaryContentSection(),
          const CoordinatorSosActionBarSection(),
        ],
      ),
    );
  }
}
