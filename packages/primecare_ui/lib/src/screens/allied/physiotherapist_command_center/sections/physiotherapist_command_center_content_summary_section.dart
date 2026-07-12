import 'package:flutter/material.dart';

class PhysiotherapistCommandCenterContentSummarySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const PhysiotherapistCommandCenterContentSummarySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'physiotherapist_command_center_content_summary_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Content Summary Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
