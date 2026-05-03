import 'package:primecare_ui/primecare_ui.dart';

class VerificationCenterView extends ConsumerStatefulWidget {
  const VerificationCenterView({super.key});

  @override
  ConsumerState<VerificationCenterView> createState() => _VerificationCenterViewState();
}

class _VerificationCenterViewState extends ConsumerState<VerificationCenterView> {
  List<AuditResultItem>? _results;
  bool _isVerifying = false;
  bool _isRemediating = false;

  void _runVerification() async {
    setState(() {
      _isVerifying = true;
      _results = null;
    });

    await Future.delayed(const Duration(seconds: 1)); // UX: Simulate work

    setState(() {
      _results = AutomatedAuditEngine.runAudits();
      _isVerifying = false;
    });
  }

  void _runRemediation() async {
    setState(() => _isRemediating = true);
    
    // Trigger the platform-wide remediation engine
    await AutomatedAuditEngine.performAutomatedRemediation();
    
    await Future.delayed(const Duration(milliseconds: 800));
    
    setState(() => _isRemediating = false);
    _runVerification(); // Refresh results
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final authState = ref.watch(authProvider);
    final isDemo = authState.token == 'demo-token';

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Verification'),
        actions: [
          if (_results != null && _results!.any((r) => !r.isPass))
            TextButton.icon(
              onPressed: _isRemediating ? null : _runRemediation,
              icon: _isRemediating 
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.auto_fix_high),
              label: const Text('AUTO-FIX ALL'),
            ),
          IconButton(
            onPressed: _isVerifying ? null : _runVerification,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          if (isDemo)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.amber.withValues(alpha: 0.15),
              child: Row(
                children: [
                  const Icon(Icons.science, color: Colors.amber, size: 16),
                  const SizedBox(width: 12),
                  Text(
                    'DEMO MODE ACTIVE: Verifying local governance stubs.',
                    style: theme.typography.labelMedium.copyWith(color: Colors.amber[900], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _isVerifying
                ? const Center(child: CircularProgressIndicator())
                : _results == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.verified_user_outlined, size: 80, color: theme.colors.primary.withValues(alpha: 0.2)),
                            const SizedBox(height: 24),
                            Text('Verification Pending', style: theme.typography.h2),
                            const SizedBox(height: 8),
                            Text('Initiate system check to verify platform integrity.', style: theme.typography.bodyMedium),
                            const SizedBox(height: 32),
                            ElevatedButton.icon(
                              onPressed: _runVerification,
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('START VERIFICATION'),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          _HealthScoreHeader(results: _results!),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _results!.length,
                              itemBuilder: (context, index) {
                                final item = _results![index];
                                return _AuditResultCard(item: item);
                              },
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}

class _HealthScoreHeader extends StatelessWidget {
  final List<AuditResultItem> results;

  const _HealthScoreHeader({required this.results});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final passCount = results.where((r) => r.isPass).length;
    final score = (passCount / results.length * 100).round();
    final color = score > 90 ? Colors.green : (score > 70 ? Colors.orange : Colors.red);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border(bottom: BorderSide(color: theme.colors.outlineVariant)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 8,
                  backgroundColor: color.withValues(alpha: 0.1),
                  color: color,
                ),
              ),
              Text(
                '$score%',
                style: theme.typography.h2.copyWith(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Platform Health Score', style: theme.typography.h3),
                const SizedBox(height: 4),
                Text(
                  score == 100 
                    ? 'Perfect architectural parity achieved.'
                    : 'Architectural drifts detected. Remediation suggested.',
                  style: theme.typography.bodyMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _StatBadge(label: 'Passed', count: passCount, color: Colors.green),
                    const SizedBox(width: 8),
                    _StatBadge(label: 'Issues', count: results.length - passCount, color: Colors.red),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatBadge({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$count $label',
        style: theme.typography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _AuditResultCard extends StatelessWidget {
  final AuditResultItem item;

  const _AuditResultCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = item.isPass ? Colors.green : (item.isWarning ? Colors.orange : Colors.red);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Icon(
          item.isPass ? Icons.check_circle : (item.isWarning ? Icons.warning : Icons.error),
          color: color,
        ),
        title: Text(item.check, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(item.result, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(label: 'Meaning', value: item.meaning),
                const SizedBox(height: 8),
                _DetailRow(label: 'Required Action', value: item.fix, isAction: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isAction;

  const _DetailRow({required this.label, required this.value, this.isAction = false});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: theme.typography.labelSmall.copyWith(color: theme.colors.primary, letterSpacing: 1)),
        const SizedBox(height: 4),
        Text(value, style: theme.typography.bodyMedium.copyWith(
          color: isAction ? theme.colors.error : null,
          fontWeight: isAction ? FontWeight.bold : null,
        )),
      ],
    );
  }
}
