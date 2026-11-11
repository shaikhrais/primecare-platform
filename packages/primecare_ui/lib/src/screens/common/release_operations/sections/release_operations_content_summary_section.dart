import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';

class ReleaseOperationsContentSummarySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const ReleaseOperationsContentSummarySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'release_operations_content_summary_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Content Summary Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            PrimeStatusText('Clinical Care Operations Status.', tone: PrimeStatusTone.muted),
          ],
        ),
      ),
    );
  }
}
