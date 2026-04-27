import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../core/ui/dynamic_form_builder.dart';
import '../../../core/ui/app_drawer.dart';
import '../../../core/utils/logger.dart';

class FeatureIntakeView extends ConsumerWidget {
  const FeatureIntakeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Feature Intake')),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Feature Request Governance',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'All platform changes must be approved through the intake process to ensure architectural compliance.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            DynamicFormBuilder(
              configs: [
                FormFieldConfig(
                  name: 'featureName',
                  label: 'Feature Name',
                  type: FieldType.text,
                  validators: [Validators.required.call],
                ),
                FormFieldConfig(
                  name: 'appId',
                  label: 'Target Application',
                  type: FieldType.dropdown,
                  options: ['APP-CORP-001', 'APP-PSW-001', 'APP-PATIENT-001'],
                  validators: [Validators.required.call],
                ),
                FormFieldConfig(
                  name: 'module',
                  label: 'Module / Domain',
                  type: FieldType.dropdown,
                  options: ['Core', 'Financials', 'Operations', 'Governance'],
                  validators: [Validators.required.call],
                ),
                FormFieldConfig(
                  name: 'priority',
                  label: 'Business Priority',
                  type: FieldType.dropdown,
                  options: ['Critical', 'High', 'Medium', 'Low'],
                  initialValue: 'Medium',
                ),
                FormFieldConfig(
                  name: 'description',
                  label: 'Requirement Description',
                  type: FieldType.text,
                  validators: [Validators.required.call],
                ),
              ],
              onSave: (data) {
                AppLogger.i('Submitting Feature Intake: $data');
                // Trigger controller logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feature Intake Submitted for Review')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
