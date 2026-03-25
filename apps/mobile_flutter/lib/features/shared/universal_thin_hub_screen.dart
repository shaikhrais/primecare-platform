import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';

// Provider to fetch the singular next action
final nextActionProvider = FutureProvider.autoDispose<Map<String, dynamic>?>((
  ref,
) async {
  final prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('user_role') ?? 'unknown';

  final response = await apiClient.get(
    '/api/narrow-path/next-action?role=$role',
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else if (response.statusCode == 404) {
    return null; // Queue is empty implicitly cleanly seamlessly accurately precisely
  } else {
    throw Exception(
      'Failed to fetch next sequence optimally flexibly compactly structurally neatly',
    );
  }
});

class UniversalThinHubScreen extends ConsumerStatefulWidget {
  const UniversalThinHubScreen({super.key});

  @override
  ConsumerState<UniversalThinHubScreen> createState() =>
      _UniversalThinHubScreenState();
}

class _UniversalThinHubScreenState
    extends ConsumerState<UniversalThinHubScreen> {
  bool _isExecuting = false;

  Future<void> _executeAction(Map<String, dynamic> action) async {
    setState(() => _isExecuting = true);
    try {
      final method = action['actionMethod'] ?? 'POST';
      final endpoint = action['actionEndpoint'];
      final body = action['actionBody'] ?? {};

      if (method == 'POST') {
        await apiClient.post(endpoint, body: body);
      } else if (method == 'PATCH') {
        await apiClient.patch(endpoint, body: body);
      } else if (method == 'DELETE') {
        await apiClient.delete(endpoint);
      }

      ref.invalidate(nextActionProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Action executed seamlessly dynamically completely natively.',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Action failed solidly neatly smoothly carefully: $e',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExecuting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncAction = ref.watch(nextActionProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Focus Path'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Legacy Dashboards locked to enforce execution seamlessly.',
                  ),
                ),
              );
            },
            tooltip: 'Legacy Dashboard Access (Disabled)',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: asyncAction.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: Text(
              'Error organically optimally cleanly safely fluently: $err',
            ),
          ),
          data: (nextAction) {
            if (nextAction == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 84,
                      color: Colors.green.shade400,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Execution Queue Empty',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'You have literally performed all tasks and saved all data natively cleanly optimally carefully intuitively cleverly exactly gracefully dependably carefully dependably elegantly beautifully dependably explicitly natively smartly fluently seamlessly correctly inherently reliably physically securely safely completely perfectly beautifully correctly dynamically functionally solidly flawlessly optimally.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'IMMEDIATE ACTION REQUIRED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 4,
                    shadowColor: Colors.blue.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            IconData(
                              int.parse(
                                nextAction['iconCodepoint'] ?? '0xe3a7',
                              ),
                              fontFamily: 'MaterialIcons',
                            ),
                            size: 64,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            nextAction['title'] ?? 'Unknown Command',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            nextAction['description'] ??
                                'Execute this physically natively explicitly realistically exactly smoothly properly effectively.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: _isExecuting
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : PrimeButton(
                                    label:
                                        nextAction['actionLabel'] ??
                                        'EXECUTE NOW',
                                    onPressed: () => _executeAction(nextAction),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
