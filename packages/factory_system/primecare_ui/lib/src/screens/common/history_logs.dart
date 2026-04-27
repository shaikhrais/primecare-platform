// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

class HistoryLogsScreen extends ConsumerStatefulWidget {
  const HistoryLogsScreen({super.key});

  @override
  ConsumerState<HistoryLogsScreen> createState() => _HistoryLogsScreenState();
}

class _HistoryLogsScreenState extends ConsumerState<HistoryLogsScreen> {
  bool _isAuthenticated = false;
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit(String value) {
    final telemetry = ref.read(executionGateProvider);

    if (value == 'admin123') {
      telemetry.passGate(
        ExecutionGateCategory.auth,
        'System Console accessed successfully.',
      );
      setState(() => _isAuthenticated = true);
    } else {
      telemetry.failGate(
        ExecutionGateCategory.auth,
        'Failed console access attempt.',
        metadata: {'attempt_value': value},
      );
      _passwordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Access Denied. Invalid Credentials.',
            style: TextStyle(fontFamily: 'monospace'),
          ),
          backgroundColor: PrimeCareColors.rose,
        ),
      );
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeCareColors.black,
      body: _isAuthenticated ? _buildLogViewer() : _buildLoginConsole(),
    );
  }

  Widget _buildLoginConsole() {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        color: PrimeCareColors.black,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PrimeCare System Console v4.0.0',
              style: TextStyle(
                color: PrimeCareColors.emerald,
                fontFamily: 'monospace',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Unauthorized access is strictly prohibited. All attempts are logged via ExecutionGateService.',
              style: TextStyle(
                color: PrimeCareColors.amber,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Text(
                  'root@primecare:~# login ',
                  style: TextStyle(
                    color: PrimeCareColors.emerald,
                    fontFamily: 'monospace',
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _passwordController,
                    focusNode: _focusNode,
                    autofocus: true,
                    obscureText: true,
                    style: const TextStyle(
                      color: PrimeCareColors.white,
                      fontFamily: 'monospace',
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    cursorColor: PrimeCareColors.emerald,
                    onSubmitted: _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogViewer() {
    final telemetry = ref.watch(executionGateProvider);
    final gates = telemetry.allGates.reversed.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: PrimeCareColors.slate400,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'LIVE SYSTEM LOGS // EXECUTION GATES',
                style: TextStyle(
                  color: PrimeCareColors.emerald,
                  fontFamily: 'monospace',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: PrimeCareColors.emerald),
                tooltip: 'Logout Console',
                onPressed: () {
                  ref
                      .read(executionGateProvider)
                      .passGate(
                        ExecutionGateCategory.auth,
                        'System Console session terminated.',
                      );
                  setState(() {
                    _isAuthenticated = false;
                    _passwordController.clear();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: gates.length,
            itemBuilder: (context, index) {
              final gate = gates[index];
              final isPass = gate.status == ExecutionGateStatus.pass;

              // Formatting Timestamp
              final timeStr = gate.timestamp
                  .toIso8601String()
                  .split('T')
                  .last
                  .substring(0, 12);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '[$timeStr]',
                      style: const TextStyle(
                        color: PrimeCareColors.slate400,
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isPass ? '[ OK ]' : '[FAIL]',
                      style: TextStyle(
                        color: isPass
                            ? PrimeCareColors.emerald
                            : PrimeCareColors.rose,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${gate.category.name.toUpperCase()} - ${gate.message}',
                            style: TextStyle(
                              color: isPass
                                  ? const Color(0xFFE0E0E0)
                                  : PrimeCareColors.rose,
                              fontFamily: 'monospace',
                              fontSize: 14,
                            ),
                          ),
                          if (gate.error != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'ERROR: ${gate.error}',
                                style: const TextStyle(
                                  color: PrimeCareColors.rose,
                                  fontFamily: 'monospace',
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          if (gate.metadata != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'META: ${gate.metadata}',
                                style: const TextStyle(
                                  color: PrimeCareColors.amber,
                                  fontFamily: 'monospace',
                                  fontSize: 13,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
