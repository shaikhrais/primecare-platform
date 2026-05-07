import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/foundation.dart';
import '../../core/config/env_config.dart';
import 'dart:ui';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both credentials.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final success = await ref
          .read(authProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text.trim());

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (!success) {
        setState(() {
          _errorMessage =
              'Authentication failed. Please verify your credentials.';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'A connection error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Stack(
        children: [
          // 1. Premium Background Gradient
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

          // 2. Dynamic Visual Elements
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

          // 3. Main Content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: theme.spacing.xl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo & Branding
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
                    const SizedBox(height: 48),

                    // Glassmorphic Authentication Card
                    ClipRRect(
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

                              // Email Field
                              _buildInputField(
                                context,
                                label: 'IDENTIFIER',
                                placeholder: 'admin@primecare.com',
                                icon: Icons.person_outline_rounded,
                                controller: _emailController,
                              ),
                              const SizedBox(height: 20),

                              // Password Field
                              _buildInputField(
                                context,
                                label: 'SECURITY TOKEN',
                                placeholder: '••••••••',
                                icon: Icons.key_outlined,
                                controller: _passwordController,
                                obscureText: true,
                              ),

                              if (_errorMessage != null) ...[
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colors.error.withValues(
                                      alpha: 0.08,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: theme.colors.error.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
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
                                          _errorMessage!,
                                          style: theme.typography.labelMedium
                                              .copyWith(
                                                color: theme.colors.error,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              const SizedBox(height: 32),

                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: _handleLogin,
                                          style:
                                              ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    theme.colors.primary,
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                elevation: 0,
                                              ).copyWith(
                                                overlayColor:
                                                    WidgetStateProperty.all(
                                                      Colors.white.withValues(
                                                        alpha: 0.1,
                                                      ),
                                                    ),
                                              ),
                                          child: const Center(
                                            child: Text(
                                              'INITIATE SESSION',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (kDebugMode ||
                                            EnvConfig.environment ==
                                                Environment.demo ||
                                            EnvConfig.environment ==
                                                Environment.dev) ...[
                                          const SizedBox(height: 16),
                                          OutlinedButton(
                                            onPressed: () {
                                              _emailController.text =
                                                  'admin@demo.primecare.com';
                                              _passwordController.text = 'demo';
                                              _handleLogin();
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor:
                                                  theme.colors.primary,
                                              side: BorderSide(
                                                color: theme.colors.primary
                                                    .withValues(alpha: 0.5),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 18,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'ACCESS DEMO MODE',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),
                    Text(
                      '© 2026 PRIMECARE PLATFORM · SECURITY LAYER 4',
                      style: theme.typography.labelMedium.copyWith(
                        color: theme.colors.onSurfaceVariant.withValues(
                          alpha: 0.6,
                        ),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required String placeholder,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
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
        TextField(
          controller: controller,
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
