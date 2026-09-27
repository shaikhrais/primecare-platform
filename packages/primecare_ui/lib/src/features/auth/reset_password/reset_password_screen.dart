import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../sections/reset_password_header_section.dart';
import '../sections/reset_password_content_summary_section.dart';
import '../sections/reset_password_primary_content_section.dart';
import '../sections/reset_password_action_bar_section.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'reset_password',
      title: 'Reset Password',
      child: Column(
        children: const [
          const ResetPasswordHeaderSection(),
          const ResetPasswordContentSummarySection(),
          const ResetPasswordPrimaryContentSection(),
          const ResetPasswordActionBarSection(),
        ],
      ),
    );
  }
}
