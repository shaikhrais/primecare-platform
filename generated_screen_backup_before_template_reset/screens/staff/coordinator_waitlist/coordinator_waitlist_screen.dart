import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coordinator_waitlist_header_section.dart';
import 'sections/coordinator_waitlist_filter_bar_section.dart';
import 'sections/coordinator_waitlist_data_table_section.dart';
import 'sections/coordinator_waitlist_pagination_section.dart';
import 'sections/coordinator_waitlist_action_bar_section.dart';

class CoordinatorWaitlistScreen extends StatelessWidget {
  const CoordinatorWaitlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coordinator_waitlist',
      title: 'CoordinatorWaitlistScreen',
      child: Column(
        children: const [
          const CoordinatorWaitlistHeaderSection(),
          const CoordinatorWaitlistFilterBarSection(),
          const CoordinatorWaitlistDataTableSection(),
          const CoordinatorWaitlistPaginationSection(),
          const CoordinatorWaitlistActionBarSection(),
        ],
      ),
    );
  }
}
