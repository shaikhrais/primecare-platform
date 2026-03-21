import 'package:primecare_mobile/l10n/app_localizations.dart';
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
      backgroundColor: Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: PrimeCareText('Recovery', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF0EA5E9),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: PrimeCareCenter(
        child: PrimeCareScrollWrapper(
          padding: EdgeInsets.all(24.0),
          child: PrimeCareCard(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(32.0),
            
            child: PrimeCareColumn(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PrimeCareIcon(Icons.lock_reset, size: 48, color: Color(0xFF0EA5E9)),
                PrimeCareSizedBox(height: 16),
                PrimeCareText(
                  'Password Recovery',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark),
                  textAlign: TextAlign.center,
                ),
                PrimeCareSizedBox(height: 8),
                PrimeCareText(
                  'Enter the email address associated with your PrimeCare account.',
                  style: TextStyle(fontSize: 14, color: PrimeCareColors.slate500),
                  textAlign: TextAlign.center,
                ),
                PrimeCareSizedBox(height: 32),
                if (_message != null) ...[
                  PrimeCareCard(
                    padding: EdgeInsets.all(12),
                    
                    child: PrimeCareText(
                      _message!,
                      style: TextStyle(
                        color: _isSuccess ? Color(0xFF059669) : PrimeCareColors.rose,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  PrimeCareSizedBox(height: 24),
                ],
                if (!_isSuccess) ...[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.emailAddress,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  PrimeCareSizedBox(height: 24),
                  PrimeCareButton(type: PrimeCareButtonType.primary, 
                    onPressed: _isLoading ? null : _handleReset,
                    
                    child: _isLoading
                        ? PrimeCareSizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : PrimeCareText('Send Reset Link', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                if (_isSuccess) ...[
                  PrimeCareButton(type: PrimeCareButtonType.primary, 
                    onPressed: () => context.go('/login'),
                    
                    child: PrimeCareText('Return to Authorization', style: TextStyle(fontWeight: FontWeight.bold)),
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
