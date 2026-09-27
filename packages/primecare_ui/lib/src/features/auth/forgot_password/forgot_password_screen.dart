import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../sections/forgot_password_header_section.dart';
import '../sections/forgot_password_content_summary_section.dart';
import '../sections/forgot_password_primary_content_section.dart';
import '../sections/forgot_password_action_bar_section.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'forgot_password',
      title: 'Forgot Password',
      child: Column(
        children: const [
          const ForgotPasswordHeaderSection(),
          const ForgotPasswordContentSummarySection(),
          const ForgotPasswordPrimaryContentSection(),
          const ForgotPasswordActionBarSection(),
        ],
      ),
    );
  }
}
