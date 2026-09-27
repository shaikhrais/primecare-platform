import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_director_staff_training_matrix_header_section.dart';
import 'sections/training_director_staff_training_matrix_content_summary_section.dart';
import 'sections/training_director_staff_training_matrix_primary_content_section.dart';
import 'sections/training_director_staff_training_matrix_action_bar_section.dart';

class TrainingDirectorStaffTrainingMatrixScreen extends StatelessWidget {
  const TrainingDirectorStaffTrainingMatrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_director_staff_training_matrix',
      title: 'Training Director Staff Training Matrix',
      child: Column(
        children: const [
          const TrainingDirectorStaffTrainingMatrixHeaderSection(),
          const TrainingDirectorStaffTrainingMatrixContentSummarySection(),
          const TrainingDirectorStaffTrainingMatrixPrimaryContentSection(),
          const TrainingDirectorStaffTrainingMatrixActionBarSection(),
        ],
      ),
    );
  }
}
