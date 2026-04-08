import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_core/services/auth_service.dart';
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
    await Future.delayed(const Duration(milliseconds: 600));

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
      heroTitle: 'Join the Clinical Atelier',
      heroSubtitle:
          'Provision your new workspace and connect your practice to the PrimeCare network seamlessly.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'auth.create_account'.tr(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'auth.subtitle'.tr(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
              fontFamily: 'Inter',
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
                    Icons.person_outline,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _lastNameController,
                  decoration: AuthInputDecoration.get(
                    'auth.last_name'.tr(),
                    Icons.person_outline,
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
              Icons.email_outlined,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            initialValue: _selectedRole,
            decoration: AuthInputDecoration.get(
              'auth.role'.tr(),
              Icons.work_outline,
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
              Icons.lock_outline,
            ),
            obscureText: true,
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF006948), Color(0xFF00855D)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              key: const Key('data-status-id=shared-global-signup-action-2'),
              onPressed: _isLoading ? null : _signup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                      'auth.register'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
                style: const TextStyle(color: Colors.blueGrey),
              ),
              TextButton(
                key: const Key('data-status-id=shared-global-signup-action-3'),
                onPressed: () => context.go('/login'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF006948),
                ),
                child: Text(
                  'auth.login'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
