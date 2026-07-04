import 'package:flutter/material.dart';

class TenantConfigurationContentSummarySection extends StatelessWidget {
  const TenantConfigurationContentSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('tenant_configuration_content_summary-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Content Summary Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
