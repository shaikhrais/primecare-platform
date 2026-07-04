import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/deployment_center_header_section.dart';
import 'sections/deployment_center_content_summary_section.dart';
import 'sections/deployment_center_primary_content_section.dart';
import 'sections/deployment_center_action_bar_section.dart';

class DeploymentCenterScreen extends StatelessWidget {
  const DeploymentCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'deployment_center',
      title: 'DeploymentCenterScreen',
      child: Column(
        children: const [
          const DeploymentCenterHeaderSection(),
          const DeploymentCenterContentSummarySection(),
          const DeploymentCenterPrimaryContentSection(),
          const DeploymentCenterActionBarSection(),
        ],
      ),
    );
  }
}
