import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseClaimsScreen extends ConsumerWidget {
  const FranchiseClaimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Franchise Claims',
        subtitle: 'Real-time overview fetched natively via API.',
        provider: franchiseClaimsDataProvider('all'),
      );
}
