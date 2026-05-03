import 'package:primecare_ui/primecare_ui.dart';

class LanguageEntryForm extends StatelessWidget {
  const LanguageEntryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ClinicalGlassPanel(
      title: 'Internationalization Registry',
      icon: Icons.translate_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enable new languages and map translation bundles.'),
          const SizedBox(height: 24),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ISO Language Code (e.g. fr)',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Native Name',
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
            child: const Text('Add Language Support'),
          ),
        ],
      ),
    );
  }
}
