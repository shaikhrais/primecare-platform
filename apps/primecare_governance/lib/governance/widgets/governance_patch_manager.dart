import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/governance_issue.dart';
import '../services/governance_patch_service.dart';

class GovernancePatchManager extends StatelessWidget {
  final List<GovernanceIssue> issues;

  const GovernancePatchManager({super.key, required this.issues});

  @override
  Widget build(BuildContext context) {
    final script = GovernancePatchService.generateRemediationScript(issues);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Row(
            children: [
              const Icon(Icons.build_circle, color: Colors.blue),
              const SizedBox(width: 12),
              const Text(
                'Remediation Patch Manager',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                label: const Text('Copy Patch Script'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: script));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Remediation script copied to clipboard.'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Text(
                script,
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Note: Applying this patch requires manual review in the registry file. Automated patching is currently in preview.',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
