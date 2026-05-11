import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LoginLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void setState(bool value) => state = value;
}

class LoginErrorNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void setError(String? value) => state = value;
}

final loginLoadingProvider = NotifierProvider<LoginLoadingNotifier, bool>(LoginLoadingNotifier.new);
final loginErrorProvider = NotifierProvider<LoginErrorNotifier, String?>(LoginErrorNotifier.new);

class LoginPage extends GovernedScreen {
  const LoginPage({super.key});

  @override
  String get featureId => 'corporate.auth.login';

  @override
  String get requiredRole => PlatformRole.guest.name;

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    return const _LoginForm();
  }
}

class _LoginForm extends ConsumerStatefulWidget {
  const _LoginForm();

  @override
  ConsumerState<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: 'ceo@primecare.com');
    passwordController = TextEditingController(text: 'admin123');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(loginLoadingProvider);
    final String? error = ref.watch(loginErrorProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              children: [
                // Security Billboard
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1E293B),
                          const Color(0xFF0F172A),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Animated Background Pattern
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.05,
                            child: CustomPaint(
                              painter: _SecurityGridPainter(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(64.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.blue.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.security_rounded,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 48),
                              const Text(
                                'Institutional Integrity.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -1,
                                ),
                              ),
                              const Text(
                                'Zero-Trust Governance.',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -1,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'PrimeCare Platform v4.0 is hardened with Aura Intelligence, ensuring total architectural parity across the entire health mesh.',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 18,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 64),
                              _BillboardStat(
                                icon: Icons.verified_user_rounded,
                                label: 'IDENTITY ASSURANCE',
                                value: 'BIOMETRIC + MFA',
                              ),
                              const SizedBox(height: 32),
                              _BillboardStat(
                                icon: Icons.data_usage_rounded,
                                label: 'DATA SOVEREIGNTY',
                                value: 'E2E ENCRYPTED',
                              ),
                              const SizedBox(height: 32),
                              _BillboardStat(
                                icon: Icons.hub_rounded,
                                label: 'NETWORK STATUS',
                                value: 'OPERATIONAL',
                                valueColor: Colors.greenAccent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Login Form
                Expanded(
                  flex: 2,
                  child: Container(
                    color: const Color(0xFF0F172A),
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(40),
                        child: _buildFormContent(isLoading, error),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // Mobile View
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: _buildFormContent(isLoading, error),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormContent(bool isLoading, String? error) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shield_rounded, size: 48, color: Colors.blue),
          ),
          const SizedBox(height: 24),
          const Text(
            'PRIMECARE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
          const Text(
            'CORPORATE PORTAL',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'CORPORATE ID (EMAIL)',
              labelStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: const Icon(Icons.email_outlined, color: Colors.blue),
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'SECURITY KEY',
              labelStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (error != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, size: 16, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                    ref.read(loginLoadingProvider.notifier).setState(true);
                    ref.read(loginErrorProvider.notifier).setError(null);

                    try {
                      final success = await ref
                          .read(authProvider.notifier)
                          .login(
                            emailController.text,
                            passwordController.text,
                          );

                      if (!success) {
                        ref
                            .read(loginErrorProvider.notifier)
                            .setError('Invalid credentials for Corporate Access.');
                      }
                    } catch (e) {
                      ref
                          .read(loginErrorProvider.notifier)
                          .setError('Connection failure. Internal mesh offline.');
                    } finally {
                      ref.read(loginLoadingProvider.notifier).setState(false);
                    }
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                  : const Text(
                    'INITIATE CORPORATE SESSION',
                    style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'SECURE END-TO-END ENCRYPTED GATEWAY',
            style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1),
          ),
        ],
      ),
    );
  }
}

class _BillboardStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color valueColor;

  const _BillboardStat({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SecurityGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1;

    const step = 40.0;
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
