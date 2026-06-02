// Governance - Category: view | Purpose: An enterprise-grade, governed login screen. Follows 'No-Logic UI' policy by delegating all authentication logic to [L...
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import 'dart:ui';

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
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Half Billboard (Left Side)
          if (isDesktop)
            const Expanded(flex: 1, child: _LoginBillboard()),

          // 2. Login Form (Right Side)
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                const _BackgroundVisuals(),
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
                            maxWidth: 440,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isDesktop) const _LoginBranding(),
                              if (!isDesktop) const SizedBox(height: 48),
                              _LoginCard(state: state),
                              const SizedBox(height: 48),
                              const _LoginFooter(),
                              const SizedBox(height: 24),
                              const _RoleSimulationCenter(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 16,
                  right: 16,
                  child: _LoginLanguageSwitcher(),
                ),
              ],
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

class _LoginCard extends ConsumerStatefulWidget {
  final LoginState state;
  const _LoginCard({required this.state});

  @override
  ConsumerState<_LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends ConsumerState<_LoginCard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'login_authorized_access'.tr(),
                  style: theme.typography.h3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'login_enter_credentials'.tr(),
                  style: theme.typography.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Cy(
                  id: 'login-email',
                  child: _InputField(
                    label: 'login_identifier_label'.tr(),
                    placeholder: 'admin@primecare.com',
                    icon: Icons.person_outline_rounded,
                    initialValue: widget.state.email,
                    onChanged: controller.onEmailChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Identifier is required';
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Invalid email format';
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Cy(
                  id: 'login-password',
                  child: _InputField(
                    label: 'login_security_token_label'.tr(),
                    placeholder: '••••••••',
                    icon: Icons.key_outlined,
                    obscureText: true,
                    initialValue: widget.state.password,
                    onChanged: controller.onPasswordChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Security token is required';
                      if (value.length < 8) return 'Token must be at least 8 characters';
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(key: const Key('login_view_textbutton_button_1'), 
                    onPressed: () => _showForgotPasswordDialog(context, controller),
                    child: Text(
                      'login_forgot_password'.tr(),
                      style: theme.typography.labelMedium.copyWith(
                        color: theme.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (widget.state.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  _ErrorDisplay(message: widget.state.errorMessage!),
                ],
                if (widget.state.successMessage != null) ...[
                  const SizedBox(height: 12),
                  _SuccessDisplay(message: widget.state.successMessage!),
                ],
                const SizedBox(height: 32),
                if (widget.state.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  _ActionButtons(
                    controller: controller,
                    onLogin: () {
                      if (_formKey.currentState!.validate()) {
                        controller.login();
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context, LoginController controller) {
    final theme = context.theme;
    String email = widget.state.email;
    
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Password Recovery',
          style: theme.typography.h3,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your email address to receive a secure password reset link.',
              style: theme.typography.bodyMedium,
            ),
            const SizedBox(height: 24),
            _InputField(
              label: 'login_identifier_label'.tr(),
              placeholder: 'admin@primecare.com',
              icon: Icons.email_outlined,
              initialValue: email,
              onChanged: (v) => email = v,
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        actions: [
          TextButton(key: const Key('login_view_textbutton_button_2'), 
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CANCEL',
              style: theme.typography.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colors.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton(key: const Key('login_view_elevatedbutton_button_1'), 
            onPressed: () async {
               Navigator.of(context).pop();
               await controller.forgotPassword(email);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('SEND RECOVERY LINK', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final Key? fieldKey;
  final String label;
  final String placeholder;
  final IconData icon;
  final bool obscureText;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;

  const _InputField({
    this.fieldKey,
    required this.label,
    required this.placeholder,
    required this.icon,
    this.obscureText = false,
    required this.initialValue,
    required this.onChanged,
    this.validator,
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
          key: fieldKey,
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
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

class _SuccessDisplay extends StatelessWidget {
  final String message;
  const _SuccessDisplay({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 16,
            color: Colors.green,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.typography.labelMedium.copyWith(
                color: Colors.green,
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
  final VoidCallback onLogin;
  
  const _ActionButtons({
    required this.controller,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        Cy(
          id: 'login-submit',
          child: ElevatedButton(key: const Key('login_view_elevatedbutton_button_2'), 
            onPressed: onLogin,
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
            child: Center(
              child: Text(
                'login_button'.tr(),
                style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
              ),
            ),
          ),
        ),
        if (!kReleaseMode) ...[
          const SizedBox(height: 16),
          OutlinedButton(key: const Key('login_view_outlinedbutton_button_1'), 
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
            child: Center(
              child: Text(
                'login_access_demo'.tr(),
                style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1),
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

class _LoginBillboard extends StatelessWidget {
  const _LoginBillboard();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          // 1. Premium Security Image
          Positioned.fill(
            child: Image.network(
              'security_billboard.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [theme.colors.primary, theme.colors.secondary],
                  ),
                ),
              ),
            ),
          ),

          // 2. Glassmorphism & Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ),

          // 3. Animated Mesh Gradient (Subtle)
          const Positioned.fill(child: _AnimatedBillboardMesh()),

          // 4. Content
          Padding(
            padding: EdgeInsets.all(theme.spacing.xxxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    _BillboardBadge(),
                    SizedBox(width: 12),
                    _SecurityVerifiedBadge(),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'PRIMECARE',
                  style: theme.typography.h1.copyWith(
                    color: Colors.white,
                    fontSize: 84,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                    height: 1,
                  ),
                ),
                Text(
                  'PLATFORM',
                  style: theme.typography.h2.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 32,
                    letterSpacing: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 64),
                const _RollingSlogans(),
                const SizedBox(height: 64),
                const _BillboardFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BillboardBadge extends StatelessWidget {
  const _BillboardBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_user_rounded,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            'SOC2 COMPLIANT · ISO 27001',
            style: context.theme.typography.labelMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityVerifiedBadge extends StatelessWidget {
  const _SecurityVerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shield, color: Colors.greenAccent, size: 14),
          const SizedBox(width: 8),
          Text(
            'GOVERNED & SECURE',
            style: context.theme.typography.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _RollingSlogans extends StatefulWidget {
  const _RollingSlogans();

  @override
  State<_RollingSlogans> createState() => _RollingSlogansState();
}

class _RollingSlogansState extends State<_RollingSlogans>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _currentIndex = 0;

  final List<String> _slogans = [
    'HARDENED GOVERNANCE INFRASTRUCTURE',
    'ZERO-ERROR AUDIT ENFORCEMENT',
    'PRECISION CARE. ABSOLUTE SECURITY.',
    'ARCHITECTURAL INTEGRITY VERIFIED',
    'ZERO-TRUST SESSION MANAGEMENT',
    'REAL-TIME COMPLIANCE MONITORING',
    'ENTERPRISE SECURITY LAYER 4',
    'DECENTRALIZED IDENTITY PROTECTION',
    'CONTINUOUS PARITY VALIDATION',
    'GOVERNANCE REGISTRY HARDENED',
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              if (mounted) {
                setState(() {
                  _currentIndex = (_currentIndex + 1) % _slogans.length;
                });
                _controller.forward(from: 0);
              }
            }
          });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STABILITY & TRUST',
          style: context.theme.typography.labelMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 64,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Text(
              _slogans[_currentIndex],
              key: ValueKey(_currentIndex),
              style: context.theme.typography.h3.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 28,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BillboardFooter extends StatelessWidget {
  const _BillboardFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SECURE DEPLOYMENT NODE: NA-EAST-1',
          style: context.theme.typography.labelSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'ALL SYSTEMS OPERATIONAL',
              style: context.theme.typography.labelSmall.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnimatedBillboardMesh extends StatelessWidget {
  const _AnimatedBillboardMesh();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: _BlurredBlob(
            color: Colors.white.withValues(alpha: 0.1),
            size: 600,
          ),
        ),
        Positioned(
          bottom: -200,
          left: -100,
          child: _BlurredBlob(
            color: Colors.black.withValues(alpha: 0.2),
            size: 800,
          ),
        ),
      ],
    );
  }
}

class _RoleSimulationCenter extends ConsumerWidget {
  const _RoleSimulationCenter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final controller = ref.read(loginControllerProvider.notifier);

    // Only show in non-production environments
    if (kReleaseMode) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'login_role_simulation_center'.tr(),
                style: theme.typography.labelSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: theme.colors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: TestCredentialsRegistry.allCredentials.map((cred) {
            return _SimulationChip(
              label: cred.role.name.toUpperCase().replaceAll('_', ' '),
              onTap: () =>
                  controller.loginWithTestCredential(cred.email, cred.password),
              isHighPrivilege:
                  cred.role == PlatformRole.ceo ||
                  cred.role == PlatformRole.admin,
              isGhost: false,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SimulationChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isHighPrivilege;
  final bool isGhost;

  const _SimulationChip({
    required this.label,
    required this.onTap,
    this.isHighPrivilege = false,
    this.isGhost = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isGhost
              ? Colors.transparent
              : (isHighPrivilege
                    ? theme.colors.primary.withValues(alpha: 0.1)
                    : theme.colors.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      )),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isGhost
                ? theme.colors.border
                : (isHighPrivilege
                      ? theme.colors.primary.withValues(alpha: 0.3)
                      : Colors.transparent),
          ),
        ),
        child: Text(
          label,
          style: theme.typography.labelSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: isHighPrivilege ? theme.colors.primary : null,
          ),
        ),
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
        filter: ImageFilter.blur(sigmaX: size / 4, sigmaY: size / 4),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

class _LoginLanguageSwitcher extends ConsumerWidget {
  const _LoginLanguageSwitcher();

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
          await ref.read(languageProvider.notifier).setLanguage(lang);
          if (context.mounted) {
            await context.setLocale(Locale(lang));
          }
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
