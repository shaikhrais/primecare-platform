import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/shared_stubs_header_section.dart';
import 'sections/shared_stubs_content_summary_section.dart';
import 'sections/shared_stubs_primary_content_section.dart';
import 'sections/shared_stubs_action_bar_section.dart';

class SharedStubsScreen extends StatelessWidget {
  const SharedStubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'shared_stubs',
      title: 'SharedScreenStubs',
      child: Column(
        children: const [
          const SharedStubsHeaderSection(),
          const SharedStubsContentSummarySection(),
          const SharedStubsPrimaryContentSection(),
          const SharedStubsActionBarSection(),
        ],
      ),
    );
  }
}
