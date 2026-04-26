import 'package:easy_localization/easy_localization.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/forms/01_I_stepper_base_form.dart';

class MockPatientIntakeStepper extends StatefulWidget {
  const MockPatientIntakeStepper({super.key});

  @override
  State<MockPatientIntakeStepper> createState() =>
      _MockPatientIntakeStepperState();
}

class _MockPatientIntakeStepperState extends State<MockPatientIntakeStepper> {
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _submitAll() async {
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Patient Intake Completed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Intake')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: StepperBaseForm(
          title: 'Comprehensive Intake',
          subtitle: 'Please complete all steps to register the patient.',
          isLoading: _isLoading,
          onSubmit: _submitAll,
          onCancel: () {
            Navigator.of(context).pop();
          },
          steps: [
            FormStep(
              title: 'Basic Info',
              subtitle: 'Name and Dob',
              validate: () => _step1Key.currentState?.validate() ?? false,
              content: Form(
                key: _step1Key,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'forms.first_name'.tr(),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'First name required' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'forms.last_name'.tr()),
                      validator: (v) =>
                          v!.isEmpty ? 'Last name required' : null,
                    ),
                  ],
                ),
              ),
            ),
            FormStep(
              title: 'Clinical Details',
              subtitle: 'Reason for visit',
              validate: () => _step2Key.currentState?.validate() ?? false,
              content: Form(
                key: _step2Key,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'clinical.chief_complaint'.tr(),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Complaint required' : null,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
