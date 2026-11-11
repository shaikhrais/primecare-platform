import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:flutter_core/theme/prime_semantic_palette.dart';
// Governance - Category: view | Purpose: Core implementation file for the Governance Patch Manager platform logic.
import 'package:primecare_ui/primecare_ui.dart' show PrimeSnackBar;
import 'package:primecare_ui/primecare_ui.dart' show PrimeIcon;
import 'package:primecare_ui/primecare_ui.dart' show PrimeElevatedButton;
import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
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
              PrimeIcon(Icons.build_circle, color: PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).onBase),
              const SizedBox(width: 12),
              PrimeText(
                'governance.patchManager.title'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              PrimeElevatedButton.icon(
                icon: const PrimeIcon(Icons.copy),
                label: PrimeText('governance.patchManager.copyScript'.tr()),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: script));
                  ScaffoldMessenger.of(context).showSnackBar(
                    PrimeSnackBar(
                      content: PrimeText(
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
              color: Theme.of(context).colorScheme.inverseSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: PrimeText(
                script,
                style: TextStyle(
                  color: readableThemeForeground(Theme.of(context).colorScheme.inverseSurface, PrimeSemanticPalette.of(context, PrimeSemanticTone.success).accent),
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: PrimeText(
            'governance.patchManager.manualReviewNote'.tr(),
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
