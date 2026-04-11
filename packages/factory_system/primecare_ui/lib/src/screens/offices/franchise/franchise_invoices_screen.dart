import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseInvoicesScreen extends ConsumerWidget {
  const FranchiseInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Franchise Invoices',
        subtitle: 'Overview of all client invoices.',
        provider: franchiseInvoicesDataProvider('all'),
      );
}
