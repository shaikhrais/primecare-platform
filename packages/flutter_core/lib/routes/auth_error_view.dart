/* 
PRIME:SCREEN=auth_error
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

class AuthErrorView extends GovernedScreen {
  final String? returnUrl;

  const AuthErrorView({super.key, this.returnUrl});

  @override
  String get featureId => 'auth.error';

  @override
  String get requiredRole => 'Public';

  @override
  List<String> get translationKeys => const [];

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              Text(
                'Authentication could not be completed.',
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Please restart sign-in.',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  final safeReturnUrl = validateClinicReturnUrl(returnUrl) ?? '/dashboard';
                  context.go('/login?returnUrl=${Uri.encodeQueryComponent(safeReturnUrl)}');
                },
                child: const Text('Retry Sign-In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
