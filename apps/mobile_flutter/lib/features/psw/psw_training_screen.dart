import 'package:flutter/material.dart';
import '../../core/api_client.dart';

class PswTrainingScreen extends StatefulWidget {
  const PswTrainingScreen({super.key});

  @override
  State<PswTrainingScreen> createState() => _PswTrainingScreenState();
}

class _PswTrainingScreenState extends State<PswTrainingScreen> {
  Map<String, dynamic>? _progress;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final data = await apiClient.get('/v1/user/training/my-progress');
      if (mounted) setState(() { _progress = data; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compliance & Training', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0EA5E9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF0EA5E9)))
          : _progress == null
              ? const Center(child: Text('Service unavailable.', style: TextStyle(color: Color(0xFFE11D48))))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)]),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${_progress!['completionRate']}%',
                              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const Text('Corporate Compliance Rate', style: TextStyle(color: Color(0xFFE0F2FE), fontSize: 16)),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _StatCounter(label: 'Assigned', value: '${_progress!['totalAssigned']}'),
                                _StatCounter(label: 'Completed', value: '${_progress!['completed']}'),
                                _StatCounter(label: 'Pending', value: '${_progress!['inProgress']}'),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text('Assigned Modules', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      const SizedBox(height: 16),
                      ...(_progress!['assignments'] as List).map((a) => Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Icon(
                            a['status'] == 'completed' ? Icons.check_circle : Icons.play_circle_fill,
                            color: a['status'] == 'completed' ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                            size: 32,
                          ),
                          title: Text(a['moduleTitle'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Status: ${a['status'].toString().toUpperCase()}', style: const TextStyle(color: Color(0xFF64748B))),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFCBD5E1)),
                        ),
                      )).toList(),
                    ],
                  ),
                ),
    );
  }
}

class _StatCounter extends StatelessWidget {
  final String label;
  final String value;
  const _StatCounter({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(color: Color(0xFFE0F2FE), fontSize: 12)),
      ],
    );
  }
}
