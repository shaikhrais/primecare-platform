// Governance - Category: view | Purpose: UI Screen component rendering the Head Of Marketing Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class HeadOfMarketingDashboardScreen extends StatefulWidget {
  const HeadOfMarketingDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HeadOfMarketingDashboardScreen> createState() => _HeadOfMarketingDashboardScreenState();
}

class _HeadOfMarketingDashboardScreenState extends State<HeadOfMarketingDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Marketing Analytics'), backgroundColor: Colors.pink.shade700),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Campaign Performance & ROI', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  Icon(Icons.campaign, size: 80, color: Colors.pink),
                  SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q3 Patient Acquisition Campaign', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pink)),
                        SizedBox(height: 8),
                        Text('Lead Conversion Rate: 12.4% (+2.1% MoM)'),
                        Text('Cost Per Acquisition: \$45.20'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Social Sentiment Tracker', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.thumb_up, color: Colors.green),
                title: Text('Brand Sentiment is Positive'),
                subtitle: Text('Recent PR push generated 400+ positive mentions.'),
              ),
            )
          ],
        ),
        ),
      ),
      ),
    );
  }
}
