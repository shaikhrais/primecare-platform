// Governance - Category: view | Purpose: Coordinator layout for Client Care Team
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientCareTeamScreen extends ConsumerWidget {
  const ClientCareTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Client Care Team Coordinator'),
      ),
    );
  }
}
