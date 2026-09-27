// Governance - Category: service | Purpose: Core implementation file for the Language Selector platform logic.
import 'package:primecare_governance/core/i18n/language_provider.dart';
import 'package:primecare_ui/primecare_ui.dart' hide languageProvider;

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final currentLang = ref.watch(languageProvider);

    return PopupMenuButton<String>(
      onSelected: (lang) {
        ref.read(languageProvider.notifier).setLanguage(lang);
      },
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colors.outlineVariant),
          borderRadius: BorderRadius.circular(theme.radiusXs),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language, size: 16, color: theme.colors.primary),
            const SizedBox(width: 4),
            Text(
              currentLang.toUpperCase(),
              style: theme.typography.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colors.primary,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        _buildItem('en', 'English'),
        _buildItem('fr', 'Français'),
        _buildItem('es', 'Español'),
        _buildItem('hi', 'हिन्दी (Hindi)'),
        _buildItem('gu', 'ગુજરાતી (Gujarati)'),
        _buildItem('ar', 'العربية (Arabic)'),
        _buildItem('ur', 'اردو (Urdu)'),
      ],
    );
  }

  PopupMenuItem<String> _buildItem(String code, String name) {
    return PopupMenuItem(value: code, child: Text(name));
  }
}
