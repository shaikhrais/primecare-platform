import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_treatment_history_header_section.dart';
import 'sections/client_treatment_history_filter_bar_section.dart';
import 'sections/client_treatment_history_data_table_section.dart';
import 'sections/client_treatment_history_pagination_section.dart';
import 'sections/client_treatment_history_action_bar_section.dart';

class ClientTreatmentHistoryScreen extends StatelessWidget {
  const ClientTreatmentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_treatment_history',
      title: 'Client Treatment History',
      child: Column(
        children: const [
          const ClientTreatmentHistoryHeaderSection(),
          const ClientTreatmentHistoryFilterBarSection(),
          const ClientTreatmentHistoryDataTableSection(),
          const ClientTreatmentHistoryPaginationSection(),
          const ClientTreatmentHistoryActionBarSection(),
        ],
      ),
    );
  }
}
