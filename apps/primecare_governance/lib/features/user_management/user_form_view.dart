import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../core/ui/app_components.dart';
import 'user.dart';

class UserFormView extends StatelessWidget {
  final User? user;
  final Function(Map<String, dynamic>) onSave;

  const UserFormView({super.key, this.user, required this.onSave});

  FormGroup get form => fb.group({
        'name': [user?.name ?? '', Validators.required],
        'email': [user?.email ?? '', Validators.required, Validators.email],
        'role': [user?.role ?? 'user', Validators.required],
        'isActive': [user?.isActive ?? true],
      });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => form,
      builder: (context, form, child) {
        return Column(
          children: [
            ReactiveTextField<String>(
              formControlName: 'name',
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            ReactiveTextField<String>(
              formControlName: 'email',
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            ReactiveDropdownField<String>(
              formControlName: 'role',
              decoration: const InputDecoration(labelText: 'User Role'),
              items: const [
                DropdownMenuItem(value: 'admin', child: Text('Administrator')),
                DropdownMenuItem(value: 'manager', child: Text('Manager')),
                DropdownMenuItem(value: 'user', child: Text('Standard User')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Active Status'),
                const Spacer(),
                ReactiveSwitch(formControlName: 'isActive'),
              ],
            ),
            const SizedBox(height: 32),
            AppButton(
              text: user == null ? 'Create User' : 'Update User',
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
}
