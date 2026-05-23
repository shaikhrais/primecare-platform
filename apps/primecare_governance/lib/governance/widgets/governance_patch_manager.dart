// Governance - Category: view | Purpose: Core implementation file for the Governance Patch Manager platform logic.
import 'package:flutter/services.dart';
import 'package:flutter_core/flutter_core.dart';
import '../services/governance_patch_service.dart';

class GovernancePatchManager extends StatelessWidget {
  final List<PlatformAuditIssue> issues;

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
              Text(
                'governance.patchManager.title'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                label: Text('governance.patchManager.copyScript'.tr()),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: script));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'governance.patchManager.copiedSuccess'.tr(),
                      ),
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
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'governance.patchManager.manualReviewNote'.tr(),
            style: const TextStyle(
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
