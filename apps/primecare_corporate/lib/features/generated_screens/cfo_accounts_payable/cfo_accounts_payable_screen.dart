import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_accounts_payable_header_section.dart';
import 'sections/cfo_accounts_payable_identity_summary_section.dart';
import 'sections/cfo_accounts_payable_details_form_section.dart';
import 'sections/cfo_accounts_payable_preferences_or_documents_section.dart';
import 'sections/cfo_accounts_payable_action_bar_section.dart';

class CfoAccountsPayableScreen extends StatelessWidget {
  const CfoAccountsPayableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_accounts_payable',
      title: 'Cfo Accounts Payable',
      child: Column(
        children: const [
          const CfoAccountsPayableHeaderSection(),
          const CfoAccountsPayableIdentitySummarySection(),
          const CfoAccountsPayableDetailsFormSection(),
          const CfoAccountsPayablePreferencesOrDocumentsSection(),
          const CfoAccountsPayableActionBarSection(),
        ],
      ),
    );
  }
}
