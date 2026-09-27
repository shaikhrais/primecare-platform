import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_billing_screen_controller.dart';
import 'sections/patient_billing_header_section.dart';
import 'sections/patient_billing_content_summary_section.dart';
import 'sections/patient_billing_primary_content_section.dart';
import 'sections/patient_billing_action_bar_section.dart';


class PatientBillingScreen extends ConsumerWidget {
  const PatientBillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_billingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientBilling'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_billingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_billing_loading'), child: Semantics(label: 'patient_billing_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_billing_screen'),
                    child: Column(
                      children: [
                        PatientBillingHeaderSection(data: state.data),
                        PatientBillingContentSummarySection(data: state.data),
                        PatientBillingPrimaryContentSection(data: state.data),
                        PatientBillingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
