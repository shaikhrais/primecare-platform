import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE
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
    await Future<void>.delayed(Duration(seconds: 2));
    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LocaleKeys.dashboards_common_labels_patient_intake_completed.tr(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.dashboards_common_labels_patient_intake.tr(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: StepperBaseForm(
          title: LocaleKeys.dashboards_common_labels_comprehensive_intake.tr(),
          subtitle: LocaleKeys
              .dashboards_common_labels_please_complete_all_steps_to_register_the_patient
              .tr(),
          isLoading: _isLoading,
          onSubmit: _submitAll,
          onCancel: () {
            Navigator.of(context).pop();
          },
          steps: [
            FormStep(
              title: LocaleKeys.dashboards_common_labels_basic_info.tr(),
              subtitle: LocaleKeys.dashboards_common_labels_name_and_dob.tr(),
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
                      decoration: InputDecoration(
                        labelText: 'forms.last_name'.tr(),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Last name required' : null,
                    ),
                  ],
                ),
              ),
            ),
            FormStep(
              title: LocaleKeys.dashboards_common_labels_clinical_details.tr(),
              subtitle: LocaleKeys.dashboards_common_labels_reason_for_visit
                  .tr(),
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
