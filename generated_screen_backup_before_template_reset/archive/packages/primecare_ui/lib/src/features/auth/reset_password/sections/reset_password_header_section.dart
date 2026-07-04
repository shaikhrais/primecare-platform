import 'package:flutter/material.dart';

class ResetPasswordHeaderSection extends StatelessWidget {
  const ResetPasswordHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('reset_password_header-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Header Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
