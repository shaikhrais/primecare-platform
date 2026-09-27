import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/device_integration_hub_header_section.dart';
import 'sections/device_integration_hub_content_summary_section.dart';
import 'sections/device_integration_hub_primary_content_section.dart';
import 'sections/device_integration_hub_action_bar_section.dart';

class DeviceIntegrationHubScreen extends StatelessWidget {
  const DeviceIntegrationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'device_integration_hub',
      title: 'Device Integration Hub',
      child: Column(
        children: const [
          const DeviceIntegrationHubHeaderSection(),
          const DeviceIntegrationHubContentSummarySection(),
          const DeviceIntegrationHubPrimaryContentSection(),
          const DeviceIntegrationHubActionBarSection(),
        ],
      ),
    );
  }
}
