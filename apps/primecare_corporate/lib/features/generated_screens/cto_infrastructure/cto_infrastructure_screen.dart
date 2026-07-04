import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_infrastructure_header_section.dart';
import 'sections/cto_infrastructure_content_summary_section.dart';
import 'sections/cto_infrastructure_primary_content_section.dart';
import 'sections/cto_infrastructure_action_bar_section.dart';

class CtoInfrastructureScreen extends StatelessWidget {
  const CtoInfrastructureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_infrastructure',
      title: 'Cto Infrastructure',
      child: Column(
        children: const [
          const CtoInfrastructureHeaderSection(),
          const CtoInfrastructureContentSummarySection(),
          const CtoInfrastructurePrimaryContentSection(),
          const CtoInfrastructureActionBarSection(),
        ],
      ),
    );
  }
}
