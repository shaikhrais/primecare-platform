// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

import 'package:primecare_ui/src/components/layouts/01_I_responsive_grid_layout.dart';
import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';
import '01_I_new_staff_provisioning_form_adapter.dart';

class NewStaffProvisioningForm extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;
  final dynamic initialData;

  const NewStaffProvisioningForm({super.key, this.onSuccess, this.initialData});

  @override
  ConsumerState<NewStaffProvisioningForm> createState() =>
      _NewStaffProvisioningFormState();
}

class _NewStaffProvisioningFormState
    extends ConsumerState<NewStaffProvisioningForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialData is Map) {
        final data = widget.initialData as Map<String, dynamic>;
        ref.read(staffProvisioningFormAdapterProvider.notifier).updateData(
              firstName: data['firstName']?.toString(),
              lastName: data['lastName']?.toString(),
              email: data['email']?.toString(),
              role: data['role']?.toString(),
              department: data['department']?.toString(),
              additionalNotes: data['additionalNotes']?.toString(),
            );
      }
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref.read(staffProvisioningFormAdapterProvider.notifier).submit();
      if (success && mounted) {
        widget.onSuccess?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(staffProvisioningFormAdapterProvider);
    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    // Dynamic span allocation based on current grid threshold
    final int halfSpan = (layout.totalColumns / 2).ceil();
    final int thirdSpan = (layout.totalColumns / 3).ceil();
    final int twoThirdsSpan = layout.totalColumns - thirdSpan;
    final int fullSpan = layout.totalColumns;

    final data = asyncState.value;

    return BaseForm(
      formKey: _formKey,
      title: 'Provision New Staff',
      subtitle: 'Onboard a new staff member and assign their role.',
      onSubmit: _submit,
      submitText: 'Provision Staff',
      isLoading: asyncState.isLoading,
      isEnabled: data != null && data.email.isNotEmpty && data.role.isNotEmpty,
      children: [
        if (asyncState.hasError)
          Padding(
            padding: EdgeInsets.only(bottom: 16.0 * layout.scaleFactor),
            child: Text(
              asyncState.error.toString(),
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),

        ResponsiveGridRow(
          spacing: 16 * layout.scaleFactor,
          runSpacing: 16 * layout.scaleFactor,
          children: [
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : halfSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12 * layout.scaleFactor),
                  ),
                ),
                key: ValueKey('firstName_${data?.firstName}'),
                initialValue: data?.firstName,
                onChanged: (val) => ref
                    .read(staffProvisioningFormAdapterProvider.notifier)
                    .updateData(firstName: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : halfSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12 * layout.scaleFactor),
                  ),
                ),
                key: ValueKey('lastName_${data?.lastName}'),
                initialValue: data?.lastName,
                onChanged: (val) => ref
                    .read(staffProvisioningFormAdapterProvider.notifier)
                    .updateData(lastName: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: fullSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Corporate Email',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12 * layout.scaleFactor),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                key: ValueKey('email_${data?.email}'),
                keyboardType: TextInputType.emailAddress,
                initialValue: data?.email,
                onChanged: (val) => ref
                    .read(staffProvisioningFormAdapterProvider.notifier)
                    .updateData(email: val),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (!value.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
            ),
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : thirdSpan,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Role',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12 * layout.scaleFactor),
                  ),
                ),
                initialValue: data?.role.isNotEmpty == true ? data?.role : null,
                items: data?.availableRoles.map((Map<String, dynamic> role) {
                  return DropdownMenuItem(
                    value: role['id'] as String,
                    child: Text(role['name'] as String),
                  );
                }).toList(),
                onChanged: (val) => ref
                    .read(staffProvisioningFormAdapterProvider.notifier)
                    .updateData(role: val),
                validator: (val) => val == null ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : twoThirdsSpan,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Department',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12 * layout.scaleFactor),
                  ),
                ),
                initialValue: data?.department.isNotEmpty == true ? data?.department : null,
                items: data?.availableDepartments.map((Map<String, dynamic> dept) {
                  return DropdownMenuItem(
                    value: dept['id'] as String,
                    child: Text(dept['label'] as String),
                  );
                }).toList(),
                onChanged: (val) => ref
                    .read(staffProvisioningFormAdapterProvider.notifier)
                    .updateData(department: val),
                validator: (val) => val == null ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: fullSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Additional Notes / Clearances',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12 * layout.scaleFactor),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                key: ValueKey('notes_${data?.additionalNotes}'),
                initialValue: data?.additionalNotes,
                onChanged: (val) => ref
                    .read(staffProvisioningFormAdapterProvider.notifier)
                    .updateData(additionalNotes: val),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
