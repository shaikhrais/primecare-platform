// Governance - Category: view | Purpose: Coordinator layout for Sso Redirect
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SsoRedirectScreen extends ConsumerWidget {
  const SsoRedirectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Sso Redirect Coordinator'),
      ),
    );
  }
}
