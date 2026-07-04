import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_accounts_receivable_header_section.dart';
import 'sections/cfo_accounts_receivable_identity_summary_section.dart';
import 'sections/cfo_accounts_receivable_details_form_section.dart';
import 'sections/cfo_accounts_receivable_preferences_or_documents_section.dart';
import 'sections/cfo_accounts_receivable_action_bar_section.dart';

class CfoAccountsReceivableScreen extends StatelessWidget {
  const CfoAccountsReceivableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_accounts_receivable',
      title: 'Cfo Accounts Receivable',
      child: Column(
        children: const [
          const CfoAccountsReceivableHeaderSection(),
          const CfoAccountsReceivableIdentitySummarySection(),
          const CfoAccountsReceivableDetailsFormSection(),
          const CfoAccountsReceivablePreferencesOrDocumentsSection(),
          const CfoAccountsReceivableActionBarSection(),
        ],
      ),
    );
  }
}
