import 'package:flutter/material.dart';
import 'package:primecare_mobile/features/master/shared/universal_inbox_screen.dart';

class AdminInboxScreen extends StatelessWidget {
  const AdminInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const UniversalInboxScreen(rolePrefix: 'admin');
  }
}
