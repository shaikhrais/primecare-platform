import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'app_components.dart';

enum FieldType { text, email, dropdown, boolean, date }

class FormFieldConfig {
  final String name;
  final String label;
  final FieldType type;
  final List<String>? options;
  final dynamic initialValue;
  final List<ValidatorFunction>? validators;

  FormFieldConfig({
    required this.name,
    required this.label,
    required this.type,
    this.options,
    this.initialValue,
    this.validators,
  });
}

class DynamicFormBuilder extends StatelessWidget {
  final List<FormFieldConfig> configs;
  final Function(Map<String, dynamic>) onSave;
  final String submitButtonText;

  const DynamicFormBuilder({
    super.key,
    required this.configs,
    required this.onSave,
    this.submitButtonText = 'Submit',
  });

  FormGroup _buildForm() {
    final controls = <String, Object>{};
    for (var config in configs) {
      controls[config.name] = FormControl<dynamic>(
        value: config.initialValue,
        validators: config.validators?.cast<Validator<dynamic>>() ?? <Validator<dynamic>>[],
      );
    }
    return fb.group(controls);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: _buildForm,
      builder: (context, form, child) {
        return Column(
          children: [
            ...configs.map((config) => _buildField(config)),
            const SizedBox(height: 24),
            AppButton(
              text: submitButtonText,
              onPressed: () {
                if (form.valid) {
                  onSave(form.value);
                } else {
                  form.markAllAsTouched();
                }
              },
              fullWidth: true,
            ),
          ],
        );
      },
    );
  }

  Widget _buildField(FormFieldConfig config) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: switch (config.type) {
        FieldType.text => ReactiveTextField<String>(
            formControlName: config.name,
            decoration: InputDecoration(labelText: config.label),
          ),
        FieldType.email => ReactiveTextField<String>(
            formControlName: config.name,
            decoration: InputDecoration(labelText: config.label, prefixIcon: const Icon(Icons.email)),
          ),
        FieldType.dropdown => ReactiveDropdownField<String>(
            formControlName: config.name,
            decoration: InputDecoration(labelText: config.label),
            items: config.options!
                .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                .toList(),
          ),
        FieldType.boolean => Row(
            children: [
              Text(config.label),
              const Spacer(),
              ReactiveSwitch(formControlName: config.name),
            ],
          ),
        FieldType.date => ReactiveTextField<DateTime>(
            formControlName: config.name,
            readOnly: true,
            decoration: InputDecoration(
              labelText: config.label,
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            onTap: (control) async {
              // Implementation for date picker
            },
          ),
      },
    );
  }
}
