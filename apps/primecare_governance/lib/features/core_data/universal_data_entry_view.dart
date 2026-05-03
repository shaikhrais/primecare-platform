import 'package:primecare_ui/primecare_ui.dart';
import 'universal_data_entry_controller.dart';

class UniversalDataEntryView extends ConsumerStatefulWidget {
  const UniversalDataEntryView({super.key});

  @override
  ConsumerState<UniversalDataEntryView> createState() => _UniversalDataEntryViewState();
}

class _UniversalDataEntryViewState extends ConsumerState<UniversalDataEntryView> {
  final _formKey = GlobalKey<FormState>();
  final _recordIdController = TextEditingController();
  final _notesController = TextEditingController();
  String _recordType = 'Clinical';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = ref.watch(universalDataEntryProvider);
    final controller = ref.read(universalDataEntryProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Universal Data Entry Portal',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              'High-speed batch processing for clinical and administrative records.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ClinicalGlassPanel(
                    title: 'New Batch Record',
                    icon: Icons.edit_document,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          initialValue: _recordType,
                          decoration: _inputDecoration('Record Category', theme),
                          items: ['Clinical', 'Billing', 'Compliance', 'HR']
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) => setState(() => _recordType = val!),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _recordIdController,
                          decoration: _inputDecoration('Primary Record ID', theme),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _notesController,
                          maxLines: 5,
                          decoration: _inputDecoration('Clinical Notes / Metadata', theme),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isSubmitting ? null : () {
                        if (_formKey.currentState!.validate()) {
                          controller.submitData({
                            'type': _recordType,
                            'id': _recordIdController.text,
                            'notes': _notesController.text,
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: state.isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('SUBMIT BATCH RECORD', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    ),
                  ),
                ],
              ),
            ),
            
            if (state.lastSubmissionId != null) ...[
              const SizedBox(height: 24),
              ClinicalGlassPanel(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Colors.green),
                    const SizedBox(width: 12),
                    Text('Last Submission Successful: ${state.lastSubmissionId}'),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, PrimeThemeData theme) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: theme.colors.background.withValues(alpha: 0.5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colors.primary, width: 2),
      ),
    );
  }
}
