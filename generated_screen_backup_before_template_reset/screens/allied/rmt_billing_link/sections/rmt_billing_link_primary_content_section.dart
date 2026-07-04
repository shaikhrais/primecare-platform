import 'package:flutter/material.dart';

class RmtBillingLinkPrimaryContentSection extends StatelessWidget {
  const RmtBillingLinkPrimaryContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('rmt_billing_link_primary_content-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Primary Content Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
