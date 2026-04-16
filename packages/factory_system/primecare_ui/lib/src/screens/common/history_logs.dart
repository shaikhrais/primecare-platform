import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/telemetry_service.dart';

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
      telemetry.passGate(ExecutionGateCategory.auth, 'System Console accessed successfully.');
      setState(() => _isAuthenticated = true);
    } else {
      telemetry.failGate(ExecutionGateCategory.auth, 'Failed console access attempt.', metadata: {'attempt_value': value});
      _passwordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Access Denied. Invalid Credentials.', style: TextStyle(fontFamily: 'monospace')),
          backgroundColor: Colors.red,
        ),
      );
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isAuthenticated ? _buildLogViewer() : _buildLoginConsole(),
    );
  }

  Widget _buildLoginConsole() {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PrimeCare System Console v4.0.0',
              style: TextStyle(color: Colors.green, fontFamily: 'monospace', fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Unauthorized access is strictly prohibited. All attempts are logged via ExecutionGateService.',
              style: TextStyle(color: Colors.yellow, fontFamily: 'monospace', fontSize: 14),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Text(
                  'root@primecare:~# login ',
                  style: TextStyle(color: Colors.green, fontFamily: 'monospace', fontSize: 16),
                ),
                Expanded(
                  child: TextField(
                    controller: _passwordController,
                    focusNode: _focusNode,
                    autofocus: true,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    cursorColor: Colors.green,
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
          color: Colors.grey[900],
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'LIVE SYSTEM LOGS // EXECUTION GATES',
                style: TextStyle(color: Colors.green, fontFamily: 'monospace', fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.green),
                tooltip: 'Logout Console',
                onPressed: () {
                  ref.read(executionGateProvider).passGate(ExecutionGateCategory.auth, 'System Console session terminated.');
                  setState(() {
                    _isAuthenticated = false;
                    _passwordController.clear();
                  });
                },
              )
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
              final timeStr = gate.timestamp.toIso8601String().split('T').last.substring(0, 12);
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '[$timeStr]',
                      style: const TextStyle(color: Colors.blueGrey, fontFamily: 'monospace', fontSize: 14),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isPass ? '[ OK ]' : '[FAIL]',
                      style: TextStyle(
                        color: isPass ? Colors.green : Colors.red,
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
                              color: isPass ? const Color(0xFFE0E0E0) : Colors.redAccent,
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
                                  color: Colors.red,
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
                                  color: Colors.yellow,
                                  fontFamily: 'monospace',
                                  fontSize: 13,
                                ),
                              ),
                            )
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
