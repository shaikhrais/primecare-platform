import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'auth_layout.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSent = false;

  Future<void> _resetPassword() async {
    setState(() => _isLoading = true);
    
    // Simulate network delay for UI feel
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _isSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      heroTitle: 'Account Recovery',
      heroSubtitle: 'Follow the institutional safety protocols to regain access to your clinical dashboard.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Reset Password',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Outfit', color: Color(0xFF191C1E)),
          ),
          const SizedBox(height: 16),
          Text(
            _isSent 
                ? 'A recovery link has been sent to \${_emailController.text}. Please check your institutional email.'
                : 'Enter your institutional email address and we will send you a secure link to reset your password.',
            style: const TextStyle(fontSize: 16, color: Colors.blueGrey, fontFamily: 'Inter', height: 1.5),
          ),
          const SizedBox(height: 32),
          if (!_isSent) ...[
            TextField(
              controller: _emailController,
              decoration: AuthInputDecoration.get('Email Address', Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF006948), Color(0xFF00855D)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading 
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Send Recovery Link', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
          
          if (_isSent) ...[
             Container(
              decoration: BoxDecoration(
                color: const Color(0xFF006948).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () => setState(() {
                  _isSent = false;
                  _emailController.clear();
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0
                ),
                child: const Text('Send again', style: TextStyle(fontSize: 18, color: Color(0xFF006948), fontWeight: FontWeight.bold)),
              ),
            ),
          ],
          const SizedBox(height: 48),
          TextButton.icon(
            onPressed: () => context.go('/login'),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to Login', style: TextStyle(fontWeight: FontWeight.bold)),
            style: TextButton.styleFrom(foregroundColor: const Color(0xFF006948)),
          ),
        ],
      ),
    );
  }
}
