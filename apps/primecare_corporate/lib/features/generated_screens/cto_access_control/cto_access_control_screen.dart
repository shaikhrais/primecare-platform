import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_access_control_header_section.dart';
import 'sections/cto_access_control_content_summary_section.dart';
import 'sections/cto_access_control_primary_content_section.dart';
import 'sections/cto_access_control_action_bar_section.dart';

class CtoAccessControlScreen extends StatelessWidget {
  const CtoAccessControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_access_control',
      title: 'Cto Access Control',
      child: Column(
        children: const [
          const CtoAccessControlHeaderSection(),
          const CtoAccessControlContentSummarySection(),
          const CtoAccessControlPrimaryContentSection(),
          const CtoAccessControlActionBarSection(),
        ],
      ),
    );
  }
}
