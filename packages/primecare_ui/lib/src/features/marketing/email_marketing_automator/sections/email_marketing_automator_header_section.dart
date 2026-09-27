import 'package:flutter/material.dart';

class EmailMarketingAutomatorHeaderSection extends StatelessWidget {
  const EmailMarketingAutomatorHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('email_marketing_automator_header-section'),
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
