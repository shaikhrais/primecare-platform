import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../layouts/responsive_grid_layout.dart';

import '../base_form.dart';
import '../state/password_reset_form_notifier.dart';

class PasswordResetForm extends ConsumerStatefulWidget {
  final String userId;

  const PasswordResetForm({super.key, required this.userId});

  @override
  ConsumerState<PasswordResetForm> createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends ConsumerState<PasswordResetForm> {
  final _formKey = GlobalKey<FormState>();

  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final payload = PasswordResetFormPayload(
        data: {
          'userId': widget.userId,
          'newPassword': _newPasswordController.text,
        },
      );

      await ref.read(passwordResetFormProvider.notifier).submit(payload);

      if (mounted && !ref.read(passwordResetFormProvider).hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password successfully reset')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(passwordResetFormProvider);

    return BaseForm(
      title: 'Reset Password',
      subtitle: 'Force a password reset for this user.',
      isLoading: state.isLoading,
      formKey: _formKey,
      onSubmit: _submit,
      onCancel: () {
        _formKey.currentState?.reset();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      },
      children: [
        ResponsiveGridRow(
          children: [
            ResponsiveGridCol(
              span: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: TextFormField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
              ),
            ),
            ResponsiveGridCol(
              span: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (v != _newPasswordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
