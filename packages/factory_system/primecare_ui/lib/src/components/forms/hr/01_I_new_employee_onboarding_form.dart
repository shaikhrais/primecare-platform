import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';

class NewEmployeeOnboardingForm extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const NewEmployeeOnboardingForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<NewEmployeeOnboardingForm> createState() =>
      _NewEmployeeOnboardingFormState();
}

class _NewEmployeeOnboardingFormState extends State<NewEmployeeOnboardingForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();

  void _submit() {
    widget.onSubmit({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'role': _roleController.text,
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: LocaleKeys.dashboards_common_labels_new_employee_onboarding.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_enter_the_details_of_the_new_hire
          .tr(),
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [
        TextFormField(
          controller: _firstNameController,
          decoration: InputDecoration(labelText: 'forms.first_name'.tr()),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _lastNameController,
          decoration: InputDecoration(labelText: 'forms.last_name'.tr()),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email Address'),
          validator: (val) {
            if (val == null || val.isEmpty) return 'Required';
            if (!val.contains('@')) return 'Invalid email';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _roleController,
          decoration: InputDecoration(labelText: 'Assigned Role'),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
      ],
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.

// Styled with global Theme and CustomColors.
