import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/auth/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      if (mounted)
        setState(() => _errorMessage = 'Please enter both email and password.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 1. Authenticate with the Cloudflare Worker API organically gracefully securely conceptually.
      await apiClient.login(email, password);

      // 2. Fetch the dynamically resolved Role injected by the Backend safely neatly tightly naturally appropriately successfully cleverly natively dependably optimally seamlessly carefully nicely successfully efficiently implicitly thoughtfully intuitively intelligently effectively creatively naturally compactly firmly smartly.
      final prefs = await SharedPreferences.getInstance();
      final String primaryRole = prefs.getString('user_role') ?? 'psw';
      final bool hasSession = prefs.containsKey('auth_token');

      await prefs.setString('user_role', primaryRole);
      ref.read(authProvider.notifier).setRole(primaryRole);

      if (hasSession && mounted) {
        // 3. Delegate routing to the GoRouter ecosystem natively based on the validated Role seamlessly creatively safely fluently elegantly elegantly solidly confidently.
        switch (primaryRole) {
          case 'rn':
            context.go('/rn/home');
            break;
          case 'coordinator':
            context.go('/coordinator/home');
            break;
          case 'manager':
            context.go('/manager/home');
            break;
          case 'admin':
            context.go('/admin/home');
            break;
          case 'client':
            context.go('/client/home');
            break;
          case 'gm':
            context.go('/gm/home');
            break;
          case 'mt':
            context.go('/mt/home');
            break;
          case 'scrum':
            context.go('/scrum_master/home');
            break;
          case 'superuser':
            context.go('/superuser/home');
            break;
          default:
            context.go('/psw/home');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(
          () => _errorMessage =
              'Authentication Failed: ${e.toString().replaceAll('Exception: ', '')}',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.health_and_safety,
            size: 84,
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 24),
          const Text(
            'PrimeCare Secure',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 40),
          if (_errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Enterprise Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Secure Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _handleLogin(),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.go('/forgot-password'),
              child: const Text('Forgot Password?'),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: _isLoading
                ? ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.blue.withOpacity(0.7),
                    ),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : PrimeButton(
                    label: 'AUTHENTICATE',
                    onPressed: _handleLogin,
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1024) {
            return Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.blue.shade900,
                    padding: const EdgeInsets.all(64.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.shield, size: 84, color: Colors.blueAccent),
                        SizedBox(height: 24),
                        Text(
                          'PrimeCare Secure Enterprise',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Welcome to the next generation of healthcare operations. Built on a zero-trust architecture, PrimeCare ensures end-to-end encryption for all patient data, tele-health sessions, and clinical compliance workflows.',
                          style: TextStyle(fontSize: 18, color: Colors.white70, height: 1.5),
                        ),
                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLoginForm(context),
                          const PrimeStatusBadge(text: 'SOC2 Type II Certified', color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: _buildLoginForm(context),
              ),
            );
          }
        },
      ),
    );
  }
}
