import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_director_staff_quality_screen_controller.dart';
import 'sections/clinical_director_staff_quality_header_section.dart';
import 'sections/clinical_director_staff_quality_content_summary_section.dart';
import 'sections/clinical_director_staff_quality_primary_content_section.dart';
import 'sections/clinical_director_staff_quality_action_bar_section.dart';


class ClinicalDirectorStaffQualityScreen extends ConsumerWidget {
  const ClinicalDirectorStaffQualityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_director_staff_qualityControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalDirectorStaffQuality'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_director_staff_qualityControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_director_staff_quality_loading'), child: Semantics(label: 'clinical_director_staff_quality_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_director_staff_quality_screen'),
                    child: Column(
                      children: [
                        ClinicalDirectorStaffQualityHeaderSection(data: state.data),
                        ClinicalDirectorStaffQualityContentSummarySection(data: state.data),
                        ClinicalDirectorStaffQualityPrimaryContentSection(data: state.data),
                        ClinicalDirectorStaffQualityActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
