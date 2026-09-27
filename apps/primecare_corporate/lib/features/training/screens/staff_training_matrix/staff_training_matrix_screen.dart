import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/staff_training_matrix_header_section.dart';
import 'sections/staff_training_matrix_content_summary_section.dart';
import 'sections/staff_training_matrix_primary_content_section.dart';
import 'sections/staff_training_matrix_action_bar_section.dart';

class StaffTrainingMatrixScreen extends StatelessWidget {
  const StaffTrainingMatrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'staff_training_matrix',
      title: 'Staff Training Matrix',
      child: Column(
        children: const [
          const StaffTrainingMatrixHeaderSection(),
          const StaffTrainingMatrixContentSummarySection(),
          const StaffTrainingMatrixPrimaryContentSection(),
          const StaffTrainingMatrixActionBarSection(),
        ],
      ),
    );
  }
}
