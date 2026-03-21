import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api_client.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMsg;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    try {
      await apiClient.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (mounted) {
        // Read role from SharedPreferences to execute proper diversion
        final prefs = await SharedPreferences.getInstance();
        final role = prefs.getString('user_role') ?? 'psw';
        switch (role) {
          case 'mt':
            context.go('/mt/dashboard');
            break;
          case 'gm':
          case 'general_manager':
            context.go('/gm/dashboard');
            break;
          case 'rn':
            context.go('/rn/dashboard');
            break;
          case 'coordinator':
            context.go('/coordinator/dashboard');
            break;
          case 'scrum_master':
          case 'developer':
            context.go('/scrum-master/dashboard');
            break;
          case 'manager':
          case 'admin':
            context.go('/manager/dashboard');
            break;
          case 'client':
            context.go('/client/dashboard');
            break;
          default:
            context.go('/psw/dashboard');
        }
      }
    } catch (e) {
      setState(() { _errorMsg = e.toString(); });
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: Color(0xFFF8FAFC),
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
                PrimeCareText(
                  'Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark),
                  textAlign: TextAlign.center,
                ),
                PrimeCareSizedBox(height: 8),
                PrimeCareText(
                  'Access the PrimeCare Mobile Platform',
                  style: TextStyle(fontSize: 14, color: PrimeCareColors.slate500),
                  textAlign: TextAlign.center,
                ),
                PrimeCareSizedBox(height: 32),
                if (_errorMsg != null)
                  PrimeCareCard(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 16),
                    
                    child: PrimeCareText(_errorMsg!, style: TextStyle(color: PrimeCareColors.rose, fontSize: 13)),
                  ),
                TextField(
                  controller: _emailController,
                  style: TextStyle(color: PrimeCareColors.radarDark),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.emailAddress,
                    labelStyle: TextStyle(color: PrimeCareColors.slate500),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                PrimeCareSizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  style: TextStyle(color: PrimeCareColors.radarDark),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    labelStyle: TextStyle(color: PrimeCareColors.slate500),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  obscureText: true,
                ),
                PrimeCareSizedBox(height: 24),
                PrimeCareButton(type: PrimeCareButtonType.primary, 
                  onPressed: _isLoading ? null : _handleLogin,
                  
                  child: _isLoading 
                      ? PrimeCareSizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : PrimeCareText('Authenticate Security Token', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                PrimeCareSizedBox(height: 16),
                PrimeCareButton(type: PrimeCareButtonType.text, 
                  onPressed: () => context.push('/forgot-password'),
                  child: PrimeCareText('Forgot Password?', style: TextStyle(color: Color(0xFF0EA5E9), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
