import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_branch_operations_header_section.dart';
import 'sections/coo_branch_operations_content_summary_section.dart';
import 'sections/coo_branch_operations_primary_content_section.dart';
import 'sections/coo_branch_operations_action_bar_section.dart';

class CooBranchOperationsScreen extends StatelessWidget {
  const CooBranchOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_branch_operations',
      title: 'Coo Branch Operations',
      child: Column(
        children: const [
          const CooBranchOperationsHeaderSection(),
          const CooBranchOperationsContentSummarySection(),
          const CooBranchOperationsPrimaryContentSection(),
          const CooBranchOperationsActionBarSection(),
        ],
      ),
    );
  }
}
