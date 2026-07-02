// Governance - Category: view | Purpose: Coordinator layout for Hr Staff Files
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrStaffFilesScreen extends ConsumerWidget {
  const HrStaffFilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Hr Staff Files Coordinator'),
      ),
    );
  }
}
