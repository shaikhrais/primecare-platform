import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_clients_header_section.dart';
import 'sections/franchise_owner_clients_content_summary_section.dart';
import 'sections/franchise_owner_clients_primary_content_section.dart';
import 'sections/franchise_owner_clients_action_bar_section.dart';

class FranchiseOwnerClientsScreen extends StatelessWidget {
  const FranchiseOwnerClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_clients',
      title: 'FranchiseOwnerClientsScreen',
      child: Column(
        children: const [
          const FranchiseOwnerClientsHeaderSection(),
          const FranchiseOwnerClientsContentSummarySection(),
          const FranchiseOwnerClientsPrimaryContentSection(),
          const FranchiseOwnerClientsActionBarSection(),
        ],
      ),
    );
  }
}
