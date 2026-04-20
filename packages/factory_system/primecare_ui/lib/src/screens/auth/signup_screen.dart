import 'package:primecare_ui/src/theme/colors.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'auth_layout.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String _selectedRole = 'CLINIC_OWNER';
  bool _isLoading = false;

  final List<String> _roles = ['CLINIC_OWNER', 'PHYSICIAN', 'RN', 'PATIENT'];

  Future<void> _signup() async {
    setState(() => _isLoading = true);

    // Simulate slight delay for aesthetic UI feeling
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Call the true register method securely
    final success = await ref
        .read(authProvider.notifier)
        .register(
          _emailController.text,
          _passwordController.text,
          _firstNameController.text,
          _lastNameController.text,
          _selectedRole,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please check network.'),
        ),
      );
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      heroTitle: 'auth.join_clinical_atelier'.tr(),
      heroSubtitle: 'auth.provision_workspace'.tr(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'auth.create_account'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'auth.subtitle'.tr(),
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _firstNameController,
                  decoration: AuthInputDecoration.get(
                    'auth.first_name'.tr(),
                    LucideIcons.user,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _lastNameController,
                  decoration: AuthInputDecoration.get(
                    'auth.last_name'.tr(),
                    LucideIcons.user,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _emailController,
            decoration: AuthInputDecoration.get(
              'auth.email'.tr(),
              LucideIcons.mail,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            initialValue: _selectedRole,
            decoration: AuthInputDecoration.get(
              'auth.role'.tr(),
              LucideIcons.briefcase,
            ),
            items: _roles.map((role) {
              return DropdownMenuItem(
                value: role,
                child: Text(role.replaceAll('_', ' ')),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedRole = val);
            },
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _passwordController,
            decoration: AuthInputDecoration.get(
              'auth.password'.tr(),
              LucideIcons.lock,
            ),
            obscureText: true,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              key: const Key('data-status-id=shared-global-signup-action-2'),
              onPressed: _isLoading ? null : _signup,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: PrimeCareColors.white,
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
                        color: PrimeCareColors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'auth.register'.tr(),
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'auth.already_have_account'.tr(),
                style: GoogleFonts.inter(color: const Color(0xFF64748B)),
              ),
              TextButton(
                key: const Key('data-status-id=shared-global-signup-action-3'),
                onPressed: () => context.go('/login'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF38BDF8),
                ),
                child: Text(
                  'auth.login'.tr(),
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
