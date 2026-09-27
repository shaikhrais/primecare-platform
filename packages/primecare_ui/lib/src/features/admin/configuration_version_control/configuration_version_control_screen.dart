import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/configuration_version_control_header_section.dart';
import 'sections/configuration_version_control_content_summary_section.dart';
import 'sections/configuration_version_control_primary_content_section.dart';
import 'sections/configuration_version_control_action_bar_section.dart';

class ConfigurationVersionControlScreen extends StatelessWidget {
  const ConfigurationVersionControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'configuration_version_control',
      title: 'Configuration Version Control',
      child: Column(
        children: const [
          const ConfigurationVersionControlHeaderSection(),
          const ConfigurationVersionControlContentSummarySection(),
          const ConfigurationVersionControlPrimaryContentSection(),
          const ConfigurationVersionControlActionBarSection(),
        ],
      ),
    );
  }
}
