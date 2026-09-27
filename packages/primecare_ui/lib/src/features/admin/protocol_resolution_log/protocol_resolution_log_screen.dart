import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/protocol_resolution_log_header_section.dart';
import 'sections/protocol_resolution_log_filter_bar_section.dart';
import 'sections/protocol_resolution_log_data_table_section.dart';
import 'sections/protocol_resolution_log_pagination_section.dart';
import 'sections/protocol_resolution_log_action_bar_section.dart';

class ProtocolResolutionLogScreen extends StatelessWidget {
  const ProtocolResolutionLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'protocol_resolution_log',
      title: 'Protocol Resolution Log',
      child: Column(
        children: const [
          const ProtocolResolutionLogHeaderSection(),
          const ProtocolResolutionLogFilterBarSection(),
          const ProtocolResolutionLogDataTableSection(),
          const ProtocolResolutionLogPaginationSection(),
          const ProtocolResolutionLogActionBarSection(),
        ],
      ),
    );
  }
}
