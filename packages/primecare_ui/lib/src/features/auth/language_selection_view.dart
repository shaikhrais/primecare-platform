// Governance - Category: view | Purpose: Governed Screen for primary language selection on fresh startup.
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

/// [Screen] - Premium, governed language selection screen.
/// Shown on fresh startup to configure the preferred default language,
/// then transitions the user smoothly to the login view.
class LanguageSelectionView extends GovernedScreen {
  @override
  String get screenDescription =>
      'The language selection screen requires a dropdown for language options, a continue button, and functionality to confirm the user\'s selection while ensuring responsiveness across devices.';

  @override
  List<String> get requiredComponents => const [
        'LanguageSelectionDropdown',
        'ContinueButton',
      ];

  @override
  List<String> get requiredFunctions => const [
        'confirmLanguageSelection',
      ];

  const LanguageSelectionView({super.key});

  @override
  String get featureId => 'auth.language_selection';

  @override
  String get requiredRole => 'Public';

  @override
  bool get isTranslationVerified => true;

  @override
  List<String> get translationKeys => [
        'select_language_welcome',
        'select_language_title',
        'select_language_subtitle',
        'select_language_continue',
        'language_en_title',
        'language_en_subtitle',
        'language_fr_title',
        'language_fr_subtitle',
        'language_es_title',
        'language_es_subtitle',
        'system_language_detected',
      ];

  @override
  bool get isMobileVerified => true;
  @override
  bool get isTabletVerified => true;
  @override
  bool get isDesktopVerified => true;

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    // Watch languageProvider to trigger instant repaint on selected language
    final activeLang = ref.watch(languageProvider);
    final theme = context.theme;

    return AuthParentLayout(
      showLanguageSwitcher: false,
      child: Center(
        child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
            child: Cy(
              id: 'language-page',
              child: Container(
                padding: EdgeInsets.all(theme.spacing.xxl),
              decoration: BoxDecoration(
                color: theme.colors.surface.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: theme.colors.border.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Branding Header
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.language_rounded,
                          size: 48,
                          color: theme.colors.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'select_language_welcome'.tr(),
                        style: theme.typography.labelBold.copyWith(
                          letterSpacing: 3,
                          color: theme.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'select_language_title'.tr(),
                        style: theme.typography.h2.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'select_language_subtitle'.tr(),
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      _buildSystemLanguageBanner(context),
                    ],
                  ),
                  const SizedBox(height: 36),

                   // 2. Language Option Grid
                  Cy(
                    id: 'language-english',
                    child: _LanguageOptionCard(
                      title: 'language_en_title'.tr(),
                      subtitle: 'language_en_subtitle'.tr(),
                      flag: '🇺🇸',
                      isSelected: activeLang == 'en',
                      onTap: () => _updateLanguage(context, ref, 'en'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Cy(
                    id: 'language-card-fr',
                    child: _LanguageOptionCard(
                      title: 'language_fr_title'.tr(),
                      subtitle: 'language_fr_subtitle'.tr(),
                      flag: '🇫🇷',
                      isSelected: activeLang == 'fr',
                      onTap: () => _updateLanguage(context, ref, 'fr'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Cy(
                    id: 'language-card-es',
                    child: _LanguageOptionCard(
                      title: 'language_es_title'.tr(),
                      subtitle: 'language_es_subtitle'.tr(),
                      flag: '🇪🇸',
                      isSelected: activeLang == 'es',
                      onTap: () => _updateLanguage(context, ref, 'es'),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // 3. Continue Button
                  Cy(
                    id: 'language-continue-button',
                    child: ElevatedButton(
                      key: const Key('language_selection_continue_button'),
                      onPressed: () {
                        // Choice is already persisted in setLanguage, navigate to login
                        context.go('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(
                          Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'select_language_continue'.tr().toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildSystemLanguageBanner(BuildContext context) {
    final theme = context.theme;
    final systemLang = PlatformDispatcher.instance.locale.languageCode.toLowerCase();
    
    String langName = 'English';
    if (systemLang == 'fr') langName = 'Français';
    if (systemLang == 'es') langName = 'Español';
    
    final isSupported = ['en', 'fr', 'es'].contains(systemLang);
    if (!isSupported) return const SizedBox.shrink();
    
    final detectedText = 'system_language_detected'.tr(args: [langName]);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: theme.colors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 14,
            color: theme.colors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            detectedText,
            style: theme.typography.labelBold.copyWith(
              color: theme.colors.primary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateLanguage(BuildContext context, WidgetRef ref, String lang) async {
    // 1. First trigger setLocale on BuildContext and await it to update easy_localization internal state
    if (context.mounted) {
      await context.setLocale(Locale(lang));
    }
    // 2. Then update Riverpod provider state to trigger clean UI repaint
    await ref.read(languageProvider.notifier).setLanguage(lang);
    
    // 3. Automatically transition to login view
    if (context.mounted) {
      context.go('/login');
    }
  }
}

class _LanguageOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOptionCard({
    required this.title,
    required this.subtitle,
    required this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colors.primary.withValues(alpha: 0.05)
                  : theme.colors.surfaceContainerHighest.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? theme.colors.primary : theme.colors.border.withValues(alpha: 0.3),
                width: isSelected ? 2.0 : 1.0,
              ),
            ),
            child: Row(
              children: [
                Text(
                  flag,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? theme.colors.primary : theme.colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: theme.typography.bodySmall.copyWith(
                          color: theme.colors.onSurfaceVariant.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: theme.colors.primary,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
