import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_materials_header_section.dart';
import 'sections/training_coordinator_materials_content_summary_section.dart';
import 'sections/training_coordinator_materials_primary_content_section.dart';
import 'sections/training_coordinator_materials_action_bar_section.dart';

class TrainingCoordinatorMaterialsScreen extends StatelessWidget {
  const TrainingCoordinatorMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_materials',
      title: 'Training Coordinator Materials',
      child: Column(
        children: const [
          const TrainingCoordinatorMaterialsHeaderSection(),
          const TrainingCoordinatorMaterialsContentSummarySection(),
          const TrainingCoordinatorMaterialsPrimaryContentSection(),
          const TrainingCoordinatorMaterialsActionBarSection(),
        ],
      ),
    );
  }
}
