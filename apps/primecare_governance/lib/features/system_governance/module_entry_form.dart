import 'package:primecare_ui/primecare_ui.dart';

/// [Component] - High-Fidelity Module Entry Form
/// Facilitates the registration of system modules within the platform registry.
class ModuleEntryForm extends StatefulWidget {
  const ModuleEntryForm({super.key});

  @override
  State<ModuleEntryForm> createState() => _ModuleEntryFormState();
}

class _ModuleEntryFormState extends State<ModuleEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _moduleNameController = TextEditingController();
  String _selectedApp = 'Corporate Admin App';
  String _selectedPriority = 'Medium';

  @override
  void dispose() {
    _moduleNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClinicalGlassPanel(
      title: LocaleKeys.governance_module_entry.tr(),
      icon: Icons.view_module_rounded,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register new architectural modules to expand the platform capability map.',
              style: theme.typography.bodySmall.copyWith(color: theme.colors.slateGray),
            ),
            const SizedBox(height: 24),
            
            // Module Name
            Text(LocaleKeys.governance_module_name.tr(), style: theme.typography.labelMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: _moduleNameController,
              decoration: InputDecoration(
                hintText: 'e.g. CLINICAL_TELEMETRY',
                filled: true,
                fillColor: theme.colors.background.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colors.borderLight),
                ),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Module name is required' : null,
            ),
            
            const SizedBox(height: 24),
            
            // Parent App
            const Text('Parent Application', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedApp,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colors.background.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colors.borderLight),
                ),
              ),
              items: [
                'Corporate Admin App',
                'PSW App',
                'Client Family App',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _selectedApp = val!),
            ),
            
            const SizedBox(height: 24),
            
            // Priority
            const Text('Deployment Priority', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildPriorityOption('Low', Colors.green),
                const SizedBox(width: 12),
                _buildPriorityOption('Medium', Colors.orange),
                const SizedBox(width: 12),
                _buildPriorityOption('High', Colors.red),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Actions
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Logic for saving
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(LocaleKeys.governance_save_module.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityOption(String label, Color color) {
    final isSelected = _selectedPriority == label;
    final theme = context.theme;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : theme.colors.borderLight,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.typography.labelSmall.copyWith(
              color: isSelected ? color : theme.colors.slateGray,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
