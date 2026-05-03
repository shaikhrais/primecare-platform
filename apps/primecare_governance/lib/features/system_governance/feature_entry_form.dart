import 'package:primecare_ui/primecare_ui.dart';

/// [Component] - Feature Flag Configurator
class FeatureEntryForm extends StatefulWidget {
  const FeatureEntryForm({super.key});

  @override
  State<FeatureEntryForm> createState() => _FeatureEntryFormState();
}

class _FeatureEntryFormState extends State<FeatureEntryForm> {
  bool _isEnabled = false;
  String _environment = 'Production';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClinicalGlassPanel(
      title: 'Feature Flag Configurator',
      icon: Icons.toggle_on_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Manage dynamic feature toggles and rollout strategies.'),
          const SizedBox(height: 24),
          
          SwitchListTile(
            title: const Text('Enable Globally', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Toggles this feature across all tenant instances.'),
            value: _isEnabled,
            onChanged: (val) => setState(() => _isEnabled = val),
            activeThumbColor: theme.colors.primary,
          ),
          
          const SizedBox(height: 24),
          
          const Text('Target Environment', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _environment,
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: ['Development', 'Staging', 'Production']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _environment = val!),
          ),
          
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Update Feature Flag', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
