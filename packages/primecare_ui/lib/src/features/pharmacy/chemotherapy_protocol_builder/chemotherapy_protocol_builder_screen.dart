import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chemotherapy_protocol_builder_header_section.dart';
import 'sections/chemotherapy_protocol_builder_content_summary_section.dart';
import 'sections/chemotherapy_protocol_builder_primary_content_section.dart';
import 'sections/chemotherapy_protocol_builder_action_bar_section.dart';

class ChemotherapyProtocolBuilderScreen extends StatelessWidget {
  const ChemotherapyProtocolBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chemotherapy_protocol_builder',
      title: 'Chemotherapy Protocol Builder',
      child: Column(
        children: const [
          const ChemotherapyProtocolBuilderHeaderSection(),
          const ChemotherapyProtocolBuilderContentSummarySection(),
          const ChemotherapyProtocolBuilderPrimaryContentSection(),
          const ChemotherapyProtocolBuilderActionBarSection(),
        ],
      ),
    );
  }
}
