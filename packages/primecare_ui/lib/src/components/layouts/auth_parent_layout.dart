// Governance - Category: view | Purpose: Unified parent layout wrapper for all auth-related pages (Language Selection, Login, Success Profile, Consent). Standardizes premium backgrounds and top-right language selection popup.
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';

/// [Layout] - The unified shell for all PrimeCare Auth/Identity screens.
/// Enforces consistent mesh gradient blobs, premium top-right language switcher,
/// and responsive center card framing.
class AuthParentLayout extends ConsumerWidget {
  final Widget child;
  final bool showLanguageSwitcher;

  const AuthParentLayout({
    super.key,
    required this.child,
    this.showLanguageSwitcher = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final langCode = ref.watch(languageProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Stack(
        children: [
          // 1. Shared Premium Background Visuals
          const _AuthBackgroundVisuals(),

          // 2. Main Content Slot (framed beautifully)
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.xl,
                    vertical: theme.spacing.xl,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1200, // Can expand for desktop split-views
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 3. Top-Right Global Auth Language Switcher
          if (showLanguageSwitcher)
            const Positioned(
              top: 16,
              right: 16,
              child: _AuthLanguageSwitcher(),
            ),
        ],
      ),
    );
  }
}

class _AuthBackgroundVisuals extends StatelessWidget {
  const _AuthBackgroundVisuals();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.4, 1.0],
                colors: [
                  theme.colors.primary.withValues(alpha: 0.08),
                  theme.colors.background,
                  theme.colors.secondary.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -150,
          right: -100,
          child: _AuthBlurredBlob(
            color: theme.colors.primary.withValues(alpha: 0.12),
            size: 500,
          ),
        ),
        Positioned(
          bottom: -100,
          left: -50,
          child: _AuthBlurredBlob(
            color: theme.colors.secondary.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
      ],
    );
  }
}

class _AuthBlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _AuthBlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: size / 4, sigmaY: size / 4),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

class _AuthLanguageSwitcher extends ConsumerWidget {
  const _AuthLanguageSwitcher();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final currentLanguage = ref.watch(languageProvider);

    return Cy(
      id: 'login-language-switcher',
      child: PopupMenuButton<String>(
        key: const Key('login-language-switcher'),
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.colors.border),
        ),
        tooltip: 'Change Language',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colors.surface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: theme.colors.border.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language_rounded,
                color: theme.colors.primary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                currentLanguage.toUpperCase(),
                style: theme.typography.labelBold.copyWith(
                  color: theme.colors.onSurface,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        onSelected: (lang) async {
          // 1. First trigger setLocale and await it to update easy_localization internal state
          if (context.mounted) {
            await context.setLocale(Locale(lang));
          }
          // 2. Then update Riverpod provider state to trigger clean UI rebuild
          await ref.read(languageProvider.notifier).setLanguage(lang);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'en',
            child: Cy(
              id: 'login-language-option-en',
              container: false,
              child: Text('English (EN)', style: theme.typography.bodyMedium),
            ),
          ),
          PopupMenuItem<String>(
            value: 'fr',
            child: Cy(
              id: 'login-language-option-fr',
              container: false,
              child: Text('Français (FR)', style: theme.typography.bodyMedium),
            ),
          ),
          PopupMenuItem<String>(
            value: 'es',
            child: Cy(
              id: 'login-language-option-es',
              container: false,
              child: Text('Español (ES)', style: theme.typography.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}
