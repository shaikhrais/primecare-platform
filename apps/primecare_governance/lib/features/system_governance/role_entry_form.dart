import 'package:primecare_ui/primecare_ui.dart';

/// [Component] - High-Fidelity Role Entry Form
/// Handles architectural role registration with premium validation and styling.
class RoleEntryForm extends StatefulWidget {
  const RoleEntryForm({super.key});

  @override
  State<RoleEntryForm> createState() => _RoleEntryFormState();
}

class _RoleEntryFormState extends State<RoleEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _roleNameController = TextEditingController();
  final _roleDescriptionController = TextEditingController();
  String _selectedAccessLevel = 'standard';

  @override
  void dispose() {
    _roleNameController.dispose();
    _roleDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClinicalGlassPanel(
      title: LocaleKeys.governance_role_entry.tr(),
      icon: Icons.admin_panel_settings_rounded,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Define the architectural permissions and access scope for this role.',
              style: theme.typography.bodySmall.copyWith(color: theme.colors.slateGray),
            ),
            const SizedBox(height: 24),
            
            // Role Name
            Text(LocaleKeys.governance_role_name.tr(), style: theme.typography.labelMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: _roleNameController,
              decoration: InputDecoration(
                hintText: 'e.g. SYSTEM_AUDITOR',
                filled: true,
                fillColor: theme.colors.background.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colors.borderLight),
                ),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Role name is required' : null,
            ),
            
            const SizedBox(height: 24),
            
            // Role Description
            const Text('Role Description', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _roleDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe the primary responsibilities...',
                filled: true,
                fillColor: theme.colors.background.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colors.borderLight),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Access Level
            const Text('Access Intensity', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildIntensityOption('read_only', 'Read Only', Icons.visibility_rounded),
                const SizedBox(width: 12),
                _buildIntensityOption('standard', 'Standard', Icons.edit_rounded),
                const SizedBox(width: 12),
                _buildIntensityOption('full_access', 'Full Access', Icons.gavel_rounded),
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
                child: Text(LocaleKeys.governance_save_role.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntensityOption(String value, String label, IconData icon) {
    final isSelected = _selectedAccessLevel == value;
    final theme = context.theme;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedAccessLevel = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? theme.colors.primary.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? theme.colors.primary : theme.colors.borderLight,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? theme.colors.primary : theme.colors.slateGray),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.typography.labelSmall.copyWith(
                  color: isSelected ? theme.colors.primary : theme.colors.slateGray,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
