import 'package:flutter/material.dart';
import 'package:primecare_mobile/features/master/shared/universal_inbox_screen.dart';

class CoordinatorInboxScreen extends StatelessWidget {
  const CoordinatorInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const UniversalInboxScreen(rolePrefix: 'coordinator');
  }
}
