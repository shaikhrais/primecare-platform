import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_command_center_header_section.dart';
import 'sections/psw_command_center_filter_bar_section.dart';
import 'sections/psw_command_center_data_table_section.dart';
import 'sections/psw_command_center_pagination_section.dart';
import 'sections/psw_command_center_action_bar_section.dart';

class PswCommandCenterScreen extends StatelessWidget {
  const PswCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_command_center',
      title: 'Psw Command Center',
      child: Column(
        children: const [
          const PswCommandCenterHeaderSection(),
          const PswCommandCenterFilterBarSection(),
          const PswCommandCenterDataTableSection(),
          const PswCommandCenterPaginationSection(),
          const PswCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
