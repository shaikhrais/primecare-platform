import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/research_protocol_manager_header_section.dart';
import 'sections/research_protocol_manager_filter_bar_section.dart';
import 'sections/research_protocol_manager_data_table_section.dart';
import 'sections/research_protocol_manager_pagination_section.dart';
import 'sections/research_protocol_manager_action_bar_section.dart';

class ResearchProtocolManagerScreen extends StatelessWidget {
  const ResearchProtocolManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'research_protocol_manager',
      title: 'Research Protocol Manager',
      child: Column(
        children: const [
          const ResearchProtocolManagerHeaderSection(),
          const ResearchProtocolManagerFilterBarSection(),
          const ResearchProtocolManagerDataTableSection(),
          const ResearchProtocolManagerPaginationSection(),
          const ResearchProtocolManagerActionBarSection(),
        ],
      ),
    );
  }
}
