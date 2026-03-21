import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';
import '../../core/api_client.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _message;
  bool _isSuccess = false;

  Future<void> _handleReset() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _message = 'Please enter a valid email address.');
      return;
    }

    setState(() {
      _isLoading = true;
      _message = null;
    });

    try {
      final response = await apiClient.post('/v1/auth/forgot-password', {
        'email': email,
      });
      
      if (mounted) {
        setState(() {
          _isSuccess = true;
          _message = response['message'] ?? 'Password reset instructions sent.';
        });
      }
    } catch (e) {
      if (mounted) setState(() { _message = e.toString(); _isSuccess = false; });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('Recovery', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0EA5E9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PrimeCareCenter(
        child: PrimeCareScrollWrapper(
          padding: const EdgeInsets.all(24.0),
          child: PrimeCareCard(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(32.0),
            
            child: PrimeCareColumn(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const PrimeCareIcon(Icons.lock_reset, size: 48, color: Color(0xFF0EA5E9)),
                const PrimeCareSizedBox(height: 16),
                const PrimeCareText(
                  'Password Recovery',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark),
                  textAlign: TextAlign.center,
                ),
                const PrimeCareSizedBox(height: 8),
                const PrimeCareText(
                  'Enter the email address associated with your PrimeCare account.',
                  style: TextStyle(fontSize: 14, color: PrimeCareColors.slate500),
                  textAlign: TextAlign.center,
                ),
                const PrimeCareSizedBox(height: 32),
                if (_message != null) ...[
                  PrimeCareCard(
                    padding: const EdgeInsets.all(12),
                    
                    child: PrimeCareText(
                      _message!,
                      style: TextStyle(
                        color: _isSuccess ? const Color(0xFF059669) : PrimeCareColors.rose,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const PrimeCareSizedBox(height: 24),
                ],
                if (!_isSuccess) ...[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const PrimeCareSizedBox(height: 24),
                  PrimeCareButton(type: PrimeCareButtonType.primary, 
                    onPressed: _isLoading ? null : _handleReset,
                    
                    child: _isLoading
                        ? const PrimeCareSizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const PrimeCareText('Send Reset Link', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                if (_isSuccess) ...[
                  PrimeCareButton(type: PrimeCareButtonType.primary, 
                    onPressed: () => context.go('/login'),
                    
                    child: const PrimeCareText('Return to Authorization', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
