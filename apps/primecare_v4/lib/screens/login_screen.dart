import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import 'auth_layout.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    final success = await ref.read(authProvider.notifier).login(
      _emailController.text,
      _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);
    
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please check credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      heroTitle: 'Secure Access to Your Clinical Workspace',
      heroSubtitle: 'Sign in to access patient records, clinical notes, and enterprise analytics.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Sign In',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Outfit', color: Color(0xFF191C1E)),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please enter your credentials to continue.',
            style: TextStyle(fontSize: 16, color: Colors.blueGrey, fontFamily: 'Inter'),
          ),
          const SizedBox(height: 48),
          TextField(
            controller: _emailController,
            decoration: AuthInputDecoration.get('Email Address', Icons.email_outlined),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _passwordController,
            decoration: AuthInputDecoration.get('Password', Icons.lock_outline),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(key: const Key('data-status-id=shared-global-login-action-1'), 
              onPressed: () => context.push('/forgot-password'),
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF006948)),
              child: const Text('Forgot Password?', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF006948), Color(0xFF00855D)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(key: const Key('data-status-id=shared-global-login-action-3'), 
              onPressed: _isLoading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading 
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?', style: TextStyle(color: Colors.blueGrey)),
              TextButton(key: const Key('data-status-id=shared-global-login-action-4'), 
                onPressed: () => context.push('/signup'),
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF006948)),
                child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
