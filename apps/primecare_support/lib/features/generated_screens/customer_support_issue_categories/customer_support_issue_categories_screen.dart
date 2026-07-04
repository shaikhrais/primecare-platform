import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_issue_categories_header_section.dart';
import 'sections/customer_support_issue_categories_content_summary_section.dart';
import 'sections/customer_support_issue_categories_primary_content_section.dart';
import 'sections/customer_support_issue_categories_action_bar_section.dart';

class CustomerSupportIssueCategoriesScreen extends StatelessWidget {
  const CustomerSupportIssueCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_issue_categories',
      title: 'Customer Support Issue Categories',
      child: Column(
        children: const [
          const CustomerSupportIssueCategoriesHeaderSection(),
          const CustomerSupportIssueCategoriesContentSummarySection(),
          const CustomerSupportIssueCategoriesPrimaryContentSection(),
          const CustomerSupportIssueCategoriesActionBarSection(),
        ],
      ),
    );
  }
}
