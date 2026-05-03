import 'package:primecare_ui/primecare_ui.dart';

class StatusEntryForm extends StatelessWidget {
  const StatusEntryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ClinicalGlassPanel(
      title: 'Status Code Registry',
      icon: Icons.assignment_turned_in_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Define global status codes and their associated visual tokens.'),
          const SizedBox(height: 24),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Status Code (e.g. 200)',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Display Label',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Save Status Code'),
          ),
        ],
      ),
    );
  }
}
