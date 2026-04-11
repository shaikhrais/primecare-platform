import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseReportsScreen extends ConsumerWidget {
  const FranchiseReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Franchise Reports',
        subtitle: 'Comprehensive financial reporting engine.',
        provider: franchiseReportsDataProvider('all'),
      );
}
