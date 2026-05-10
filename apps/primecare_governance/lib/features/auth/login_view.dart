import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/foundation.dart';
import '../../core/config/env_config.dart';
import 'dart:ui';
import 'login_controller.dart';

/// An enterprise-grade, governed login screen.
/// Follows 'No-Logic UI' policy by delegating all authentication logic to [LoginController].
class LoginView extends GovernedScreen {
  const LoginView({super.key});

  @override
  String get featureId => 'auth.login';

  @override
  String get requiredRole => 'Public';

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(loginControllerProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Stack(
        children: [
          const _BackgroundVisuals(),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: theme.spacing.xl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _LoginBranding(),
                    const SizedBox(height: 48),
                    _LoginCard(state: state),
                    const SizedBox(height: 48),
                    const _LoginFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundVisuals extends StatelessWidget {
  const _BackgroundVisuals();

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
          child: _BlurredBlob(
            color: theme.colors.primary.withValues(alpha: 0.12),
            size: 500,
          ),
        ),
        Positioned(
          bottom: -100,
          left: -50,
          child: _BlurredBlob(
            color: theme.colors.secondary.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
      ],
    );
  }
}

class _LoginBranding extends StatelessWidget {
  const _LoginBranding();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        Hero(
          tag: 'app_logo',
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.security_update_good_rounded,
              size: 48,
              color: theme.colors.primary,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'PRIMECARE',
          style: theme.typography.h1.copyWith(
            letterSpacing: 6,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        Text(
          'GOVERNANCE GATEWAY',
          style: theme.typography.labelMedium.copyWith(
            letterSpacing: 3,
            color: theme.colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _LoginCard extends ConsumerWidget {
  final LoginState state;
  const _LoginCard({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final controller = ref.read(loginControllerProvider.notifier);

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Authorized Access',
                style: theme.typography.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your secure credentials to continue',
                style: theme.typography.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _InputField(
                label: 'IDENTIFIER',
                placeholder: 'admin@primecare.com',
                icon: Icons.person_outline_rounded,
                initialValue: state.email,
                onChanged: controller.onEmailChanged,
              ),
              const SizedBox(height: 20),
              _InputField(
                label: 'SECURITY TOKEN',
                placeholder: '••••••••',
                icon: Icons.key_outlined,
                obscureText: true,
                initialValue: state.password,
                onChanged: controller.onPasswordChanged,
              ),
              if (state.errorMessage != null) ...[
                const SizedBox(height: 20),
                _ErrorDisplay(message: state.errorMessage!),
              ],
              const SizedBox(height: 32),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                _ActionButtons(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final IconData icon;
  final bool obscureText;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _InputField({
    required this.label,
    required this.placeholder,
    required this.icon,
    this.obscureText = false,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: theme.typography.labelMedium.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: theme.colors.onSurfaceVariant,
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          obscureText: obscureText,
          style: theme.typography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: Icon(
              icon,
              size: 20,
              color: theme.colors.primary.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: theme.colors.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colors.primary, width: 2),
            ),
            hintStyle: theme.typography.labelMedium.copyWith(
              color: theme.colors.onSurfaceVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorDisplay extends StatelessWidget {
  final String message;
  const _ErrorDisplay({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 16,
            color: theme.colors.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.typography.labelMedium.copyWith(
                color: theme.colors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final LoginController controller;
  const _ActionButtons({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.login,
          style:
              ElevatedButton.styleFrom(
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
          child: const Center(
            child: Text(
              'INITIATE SESSION',
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
            ),
          ),
        ),
        if (kDebugMode ||
            EnvConfig.environment == Environment.demo ||
            EnvConfig.environment == Environment.dev) ...[
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: controller.loginWithDemo,
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colors.primary,
              side: BorderSide(
                color: theme.colors.primary.withValues(alpha: 0.5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Center(
              child: Text(
                'ACCESS DEMO MODE',
                style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _LoginFooter extends StatelessWidget {
  const _LoginFooter();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Text(
      '© 2026 PRIMECARE PLATFORM · SECURITY LAYER 4',
      style: theme.typography.labelMedium.copyWith(
        color: theme.colors.onSurfaceVariant.withValues(alpha: 0.6),
        letterSpacing: 1,
      ),
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}
