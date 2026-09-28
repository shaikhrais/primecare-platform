import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_claims_header_section.dart';
import 'sections/admin_claims_content_summary_section.dart';
import 'sections/admin_claims_primary_content_section.dart';
import 'sections/admin_claims_action_bar_section.dart';

class AdminClaimsScreen extends StatelessWidget {
  const AdminClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_claims',
      title: 'Admin Claims',
      child: Column(
        children: const [
          const AdminClaimsHeaderSection(),
          const AdminClaimsContentSummarySection(),
          const AdminClaimsPrimaryContentSection(),
          const AdminClaimsActionBarSection(),
        ],
      ),
    );
  }
}
