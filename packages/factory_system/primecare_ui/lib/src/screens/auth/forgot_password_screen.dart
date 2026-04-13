import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'auth_layout.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

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
      heroTitle: 'auth.account_recovery'.tr(),
      heroSubtitle: 'auth.recovery_subtitle'.tr(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'auth.reset_password'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _isSent
                ? 'auth.recovery_link_sent'.tr()
                : 'auth.enter_institutional_email'.tr(),
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          if (!_isSent) ...[
            TextField(
              controller: _emailController,
              decoration: AuthInputDecoration.get(
                'auth.email'.tr(),
                LucideIcons.mail,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                key: const Key('data-status-id=shared-global-forgot-action-1'),
                onPressed: _isLoading ? null : _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'auth.send_recovery_link'.tr(),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],

          if (_isSent) ...[
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                key: const Key('data-status-id=shared-global-forgot-action-2'),
                onPressed: () => setState(() {
                  _isSent = false;
                  _emailController.clear();
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF38BDF8,
                  ).withValues(alpha: 0.1),
                  foregroundColor: const Color(0xFF38BDF8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'auth.send_again'.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 48),
          TextButton.icon(
            onPressed: () => context.go('/login'),
            icon: const Icon(LucideIcons.arrowLeft, size: 20),
            label: Text(
              'auth.back_to_login'.tr(),
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF38BDF8),
            ),
          ),
        ],
      ),
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.
