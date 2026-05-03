import 'package:primecare_ui/primecare_ui.dart';

class LifecycleGovernanceForm extends StatefulWidget {
  const LifecycleGovernanceForm({super.key});

  @override
  State<LifecycleGovernanceForm> createState() => _LifecycleGovernanceFormState();
}

class _LifecycleGovernanceFormState extends State<LifecycleGovernanceForm> {
  String _selectedStage = 'Research';
  final List<String> _stages = [
    'Backlog',
    'Research',
    'Design',
    'Generation',
    'Testing',
    'UAT',
    'Production'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClinicalGlassPanel(
      title: 'Lifecycle Governance',
      icon: Icons.published_with_changes_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Track and update the development lifecycle of platform features.'),
          const SizedBox(height: 24),
          
          DropdownButtonFormField<String>(
            initialValue: _selectedStage,
            decoration: InputDecoration(
              labelText: 'Current Stage',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: _stages
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _selectedStage = val!),
          ),
          
          const SizedBox(height: 24),
          
          const Text('Stage Progress', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: (_stages.indexOf(_selectedStage) + 1) / _stages.length,
            backgroundColor: theme.colors.slateGray.withValues(alpha: 0.2),
            color: theme.colors.primary,
            minHeight: 8,
          ),
          
          const SizedBox(height: 32),
          
          ElevatedButton(
            onPressed: () {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lifecycle updated to $_selectedStage')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Update Lifecycle Status'),
          ),
        ],
      ),
    );
  }
}
