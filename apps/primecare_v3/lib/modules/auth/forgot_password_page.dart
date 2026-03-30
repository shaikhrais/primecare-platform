import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/providers/theme_provider.dart';

class ForgotPasswordPageWidget extends ConsumerStatefulWidget {
  const ForgotPasswordPageWidget({super.key});

  @override
  ConsumerState<ForgotPasswordPageWidget> createState() => _ForgotPasswordPageWidgetState();
}

class _ForgotPasswordPageWidgetState extends ConsumerState<ForgotPasswordPageWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  void _handleReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeProvider).colors;

    return AuthSplitLayout(
      title: 'Password Recovery',
      subtitle: 'Enter your email address to receive a secure password reset link.',
      imageUrl: 'https://images.unsplash.com/photo-1551076805-e1869033e561?q=80&w=2560&auto=format&fit=crop', // Consistent with login
      child: _emailSent
          ? _buildSuccessMessage(colors)
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Corporate Email Address',
                      prefixIcon: Icon(Icons.email_outlined, color: colors.accent),
                      filled: true,
                      fillColor: colors.surface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      labelStyle: TextStyle(color: colors.textMuted),
                    ),
                    style: TextStyle(color: colors.textMain),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Please enter your email';
                      if (!val.contains('@')) return 'Enter a valid corporate email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleReset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.accent,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading 
                      ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text('Send Reset Link', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(height: 32),
                  TextButton.icon(
                    onPressed: () => context.go('/login'),
                    icon: Icon(Icons.arrow_back, color: colors.textMuted, size: 20),
                    label: Text('Return to Login Gateway', style: TextStyle(color: colors.textMuted)),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildSuccessMessage(var colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.mark_email_read_rounded, size: 64, color: Colors.greenAccent),
        ),
        const SizedBox(height: 32),
        Text(
          'Check your inbox',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: colors.textMain),
        ),
        const SizedBox(height: 16),
        Text(
          'We sent a secure password reset link to ${_emailController.text}. It will expire in exactly 15 minutes.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: colors.textMuted, height: 1.5),
        ),
        const SizedBox(height: 48),
        OutlinedButton(
          onPressed: () => context.go('/login'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white24),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('Return to Login', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ],
    );
  }
}
