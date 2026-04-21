// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primecare_core/primecare_core.dart';

/// A floating diagnostic overlay that lets developers/engineers pull the
/// execution trace of the current session to diagnose dynamic failures.
class ExecutionGateOverlay extends ConsumerStatefulWidget {
  final Widget child;

  const ExecutionGateOverlay({super.key, required this.child});

  @override
  ConsumerState<ExecutionGateOverlay> createState() =>
      _ExecutionGateOverlayState();
}

class _ExecutionGateOverlayState extends ConsumerState<ExecutionGateOverlay> {
  bool _isVisible = false;
  bool _isSubmitting = false;
  bool _hasFailed = false;

  void _copyAuditReport(BuildContext context) {
    final report = ref.read(executionGateProvider).generateAuditReport();
    Clipboard.setData(ClipboardData(text: report));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Session Audit Report copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _manualSubmitReport(BuildContext context) async {
    setState(() => _isSubmitting = true);
    try {
      await ref.read(executionGateProvider).manualSubmit();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report submitted successfully')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _clearGates() {
    ref.read(executionGateProvider).clearGates();
    if (mounted) {
      setState(() {
        _hasFailed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final gates = ref.watch(executionGateProvider).allGates;
    final currentlyFailed = gates.any(
      (g) => g.status == ExecutionGateStatus.fail,
    );

    // Auto-open on failure if not already open
    if (currentlyFailed && !_isVisible && !_hasFailed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _isVisible = true;
            _hasFailed = true;
          });
        }
      });
    }

    return Stack(
      children: [
        widget.child,

        // A dev-only floating pill to pull up the report
        Positioned(
          bottom: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                if (_isVisible)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: PrimeCareColors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(
                      maxHeight: 300,
                      maxWidth: 400,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Execution Gates',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                if (_isSubmitting)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.cloud_upload,
                                    size: 16,
                                  ),
                                  onPressed: _isSubmitting
                                      ? null
                                      : () => _manualSubmitReport(context),
                                  tooltip: 'Submit Report Manually',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy, size: 16),
                                  onPressed: () => _copyAuditReport(context),
                                  tooltip: 'Copy to Clipboard',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.clear_all, size: 16),
                                  onPressed: _clearGates,
                                  tooltip: 'Clear Audit Traces',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Consumer(
                              builder: (context, ref, child) {
                                // In a real scenario you might want the provider to notify listeners when it updates,
                                // but we can just forcefully read it when the panel is open.
                                final report = ref
                                    .read(executionGateProvider)
                                    .generateAuditReport();
                                return Text(
                                  report,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontFamily: 'monospace',
                                        fontSize: 10,
                                      ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // The toggle button
                FloatingActionButton.small(
                  backgroundColor: currentlyFailed
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.primary,
                  foregroundColor: currentlyFailed
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.onPrimary,
                  child: Icon(
                    currentlyFailed ? Icons.priority_high : Icons.bug_report,
                  ),
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
