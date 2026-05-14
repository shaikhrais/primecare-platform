import 'package:primecare_ui/primecare_ui.dart';

class AppEntryForm extends StatefulWidget {
  const AppEntryForm({super.key});

  @override
  State<AppEntryForm> createState() => _AppEntryFormState();
}

class _AppEntryFormState extends State<AppEntryForm> {
  final _nameController = TextEditingController();
  String _status = 'Draft';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ClinicalGlassPanel(
      title: 'Application Registry',
      icon: Icons.apps_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register and manage high-level application instances across the platform.',
            style: theme.typography.bodySmall.copyWith(color: theme.colors.slateGray),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Application Name',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _status,
            decoration: InputDecoration(
              labelText: 'Lifecycle Status',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: ['Draft', 'Active', 'Deprecated']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _status = val!),
          ),
          const SizedBox(height: 24),
          Text(
            'Deployment Readiness',
            style: theme.typography.h3.copyWith(color: theme.colors.primary),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildDeploymentChip(theme, 'App Store (iOS)', Icons.apple),
              _buildDeploymentChip(theme, 'Play Store (Android)', Icons.android),
              _buildDeploymentChip(theme, 'Web App (PWA)', Icons.language),
              _buildDeploymentChip(theme, 'Windows (MSIX)', Icons.window),
              _buildDeploymentChip(theme, 'Linux (AppStream)', Icons.computer),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Register Application', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDeploymentChip(dynamic theme, String label, IconData icon) {
    return FilterChip(
      label: Text(label),
      avatar: Icon(icon, size: 18),
      selected: false,
      onSelected: (val) {},
      backgroundColor: theme.colors.background,
      selectedColor: theme.colors.primary.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colors.outline.withValues(alpha: 0.3)),
      ),
    );
  }
}
