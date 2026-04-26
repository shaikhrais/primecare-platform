// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';

class CreateShiftForm extends ConsumerStatefulWidget {
  const CreateShiftForm({super.key});

  @override
  ConsumerState<CreateShiftForm> createState() => _CreateShiftFormState();
}

class _CreateShiftFormState extends ConsumerState<CreateShiftForm> {
  final _formKey = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedProvider;

  @override
  void dispose() {
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = '${picked.toLocal()}'.split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      // Logic for submitting shift would go here
      await Future<void>.delayed(Duration(milliseconds: 1000));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocaleKeys.dashboards_common_labels_shift_created_successfully
                  .tr(),
            ),
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      title: LocaleKeys.dashboards_common_labels_create_shift.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_schedule_a_new_care_session_for_a_client
          .tr(),
      isLoading: false,
      formKey: _formKey,
      onSubmit: _submit,
      onCancel: () => Navigator.of(context).pop(),
      children: [
        ResponsiveGridRow(
          children: [
            ResponsiveGridCol(
              span: 12,
              child: _buildTextField(
                controller: _dateController,
                label: 'Shift Date',
                readOnly: true,
                onTap: _selectDate,
                suffixIcon: const Icon(LucideIcons.calendar),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: 6,
              child: _buildTextField(
                controller: _startTimeController,
                label: 'Start Time',
                readOnly: true,
                onTap: () => _selectTime(_startTimeController),
                suffixIcon: const Icon(LucideIcons.clock),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: 6,
              child: _buildTextField(
                controller: _endTimeController,
                label: 'End Time',
                readOnly: true,
                onTap: () => _selectTime(_endTimeController),
                suffixIcon: const Icon(LucideIcons.clock),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Assign Provider',
                    prefixIcon: Icon(LucideIcons.user),
                  ),
                  initialValue: _selectedProvider,
                  items: [
                    DropdownMenuItem(
                      value: '1',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_john_smith__rn.tr(),
                      ),
                    ),
                    DropdownMenuItem(
                      value: '2',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_jane_doe__psw.tr(),
                      ),
                    ),
                    DropdownMenuItem(
                      value: '3',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_alex_johnson__rpn
                            .tr(),
                      ),
                    ),
                  ],
                  onChanged: (v) => setState(() => _selectedProvider = v),
                  validator: (v) => v == null ? 'Required' : null,
                ),
              ),
            ),
            ResponsiveGridCol(
              span: 12,
              child: _buildTextField(
                controller: _notesController,
                label: 'Special Instructions / Notes',
                maxLines: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, suffixIcon: suffixIcon),
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
      ),
    );
  }
}
