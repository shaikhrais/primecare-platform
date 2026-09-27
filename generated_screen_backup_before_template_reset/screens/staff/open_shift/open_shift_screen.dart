import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/open_shift_header_section.dart';
import 'sections/open_shift_content_summary_section.dart';
import 'sections/open_shift_primary_content_section.dart';
import 'sections/open_shift_action_bar_section.dart';

class OpenShiftScreen extends StatelessWidget {
  const OpenShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'open_shift',
      title: 'OpenShiftScreen',
      child: Column(
        children: const [
          const OpenShiftHeaderSection(),
          const OpenShiftContentSummarySection(),
          const OpenShiftPrimaryContentSection(),
          const OpenShiftActionBarSection(),
        ],
      ),
    );
  }
}
