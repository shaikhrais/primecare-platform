import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// A concrete example of a "Zero-Code" screen.
/// 
/// Developers do not write layout code here. Instead, they provide:
/// 1. A Title (and optional subtitle).
/// 2. A Provider (which provides a ViewModel containing Blueprints).
/// 
/// The [PageTemplate.orchestrate] helper handles Loading, Error, 
/// and Responsive Grid states (1-10 columns) automatically.
class DemoDashboardScreen extends ConsumerWidget {
  const DemoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Developer Demo Dashboard',
        subtitle: 'A living example of Zero-Code orchestration.',
        provider: demoDashboardProvider,
      );
}
