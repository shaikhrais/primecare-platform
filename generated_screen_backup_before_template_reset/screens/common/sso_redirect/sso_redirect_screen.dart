import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/sso_redirect_header_section.dart';
import 'sections/sso_redirect_content_summary_section.dart';
import 'sections/sso_redirect_primary_content_section.dart';
import 'sections/sso_redirect_action_bar_section.dart';

class SsoRedirectScreen extends StatelessWidget {
  const SsoRedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'sso_redirect',
      title: 'Sso Redirect',
      child: Column(
        children: const [
          const SsoRedirectHeaderSection(),
          const SsoRedirectContentSummarySection(),
          const SsoRedirectPrimaryContentSection(),
          const SsoRedirectActionBarSection(),
        ],
      ),
    );
  }
}
