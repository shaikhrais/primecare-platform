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
import 'package:primecare_recovery_ui/routes/auth_error_view.dart';
import 'clinic_login_bridge.dart';

class AuthErrorView extends AuthErrorViewBase {
  const AuthErrorView({super.key,super.returnUrl});
  @override
  void retrySignIn(BuildContext context) {
    final safeReturnUrl = validateClinicReturnUrl(returnUrl) ?? '/dashboard';
    context.go('/login?returnUrl=${Uri.encodeQueryComponent(safeReturnUrl)}');
  }
}
