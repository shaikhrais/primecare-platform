import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/providers/theme_provider.dart';

class LoginPageWidget extends ConsumerStatefulWidget {
  const LoginPageWidget({super.key});

  @override
  ConsumerState<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends ConsumerState<LoginPageWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool isAuthenticating = false;

  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isAuthenticating = true);
      
      final inputEmail = _emailController.text.trim();
      final inputPassword = _passwordController.text;
      
      try {
        await ref.read(authProvider.notifier).login(inputEmail, inputPassword);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll('Exception: ', '')),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => isAuthenticating = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeProvider).colors;

    return AuthSplitLayout(
      title: 'PrimeCare V3',
      subtitle: 'Secure Enterprise Authentication Gateway.',
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'User ID (Email Address)',
                prefixIcon: Icon(Icons.person_pin, color: colors.accent),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                labelStyle: TextStyle(color: colors.textMuted),
              ),
              style: TextStyle(color: colors.textMain),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val == null || val.isEmpty) return 'Please enter your User ID or Email';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Secure Password',
                prefixIcon: Icon(Icons.fingerprint, color: colors.accent),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: colors.textMuted),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                labelStyle: TextStyle(color: colors.textMuted),
              ),
              style: TextStyle(color: colors.textMain),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => handleLogin(),
              validator: (val) => val == null || val.isEmpty ? 'Please enter your password' : null,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/forgot_password'),
                child: const Text('Forgot Password?', style: TextStyle(color: Colors.blueGrey)),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: isAuthenticating ? null : handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: isAuthenticating
                  ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text('Authenticate & Route', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an enterprise account? ", style: TextStyle(color: colors.textMuted)),
                TextButton(
                  onPressed: () => context.go('/signup'),
                  child: Text('Sign Up', style: TextStyle(color: colors.accent, fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
