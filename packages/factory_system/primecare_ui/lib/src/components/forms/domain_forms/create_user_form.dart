import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE

import 'package:primecare_ui/src/components/forms/base_form.dart';
import 'package:primecare_ui/src/components/forms/state/create_user_form_notifier.dart';

class CreateUserForm extends ConsumerStatefulWidget {
  const CreateUserForm({super.key});

  @override
  ConsumerState<CreateUserForm> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends ConsumerState<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _officeNameController = TextEditingController();
  String? _selectedRole;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _officeNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final payload = CreateUserFormPayload(
        data: {
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'email': _emailController.text,
          'role': _selectedRole,
          'officeName': _officeNameController.text,
        },
      );

      await ref.read(createUserFormProvider.notifier).submit(payload);

      if (mounted && !ref.read(createUserFormProvider).hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocaleKeys.dashboards_common_labels_successfully_submitted.tr(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createUserFormProvider);

    return BaseForm(
      title: LocaleKeys.dashboards_common_labels_create_user.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_add_a_new_administrative_user_to_the_platform
          .tr(),
      isLoading: state.isLoading,
      formKey: _formKey,
      onSubmit: _submit,
      onCancel: () {
        _formKey.currentState?.reset();
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _officeNameController.clear();
        setState(() {
          _selectedRole = null;
        });
      },
      children: [
        ResponsiveGridRow(
          children: [
            ResponsiveGridCol(
              span: 6,
              child: _buildTextField(
                widgetKey: const Key('create_user_first_name_input'),
                controller: _firstNameController,
                label: 'First Name',
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: 6,
              child: _buildTextField(
                widgetKey: const Key('create_user_last_name_input'),
                controller: _lastNameController,
                label: 'Last Name',
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: 12,
              child: _buildTextField(
                widgetKey: const Key('create_user_email_input'),
                controller: _emailController,
                label: 'Email Address',
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  if (!v.contains('@')) return 'Invalid email format';
                  return null;
                },
              ),
            ),
            ResponsiveGridCol(
              span: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: DropdownButtonFormField<String>(
                  key: Key('create_user_role_select'),
                  decoration: InputDecoration(labelText: 'Platform Role'),
                  initialValue: _selectedRole,
                  items: [
                    DropdownMenuItem(
                      value: 'SYSTEM_ADMIN_TIER_1',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_system_administrator
                            .tr(),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'FINANCE_DIRECTOR_TIER_3',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_finance_director
                            .tr(),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'LOGISTICS_MANAGER_TIER_3',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_logistics_manager
                            .tr(),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'PSW_HUB_MANAGER_TIER_4',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_psw_hub_manager
                            .tr(),
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    setState(() {
                      _selectedRole = v;
                    });
                  },
                  validator: (v) => v == null ? 'Required' : null,
                ),
              ),
            ),
            ResponsiveGridCol(
              span: 6,
              child: _buildTextField(
                widgetKey: const Key('create_user_office_input'),
                controller: _officeNameController,
                label: 'Office / Department',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    Key? widgetKey,
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TextFormField(
        key: widgetKey,
        controller: controller,
        decoration: InputDecoration(labelText: label),
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }
}
