import 'package:flutter/material.dart';
import '../../master/shared/widgets/page_template.dart';
import '../../master/shared/widgets/kpi_card.dart';
import 'package:primecare_mobile/core/api_client.dart';

// Hits PATCH /v1/coordinator/visits/:id natively

class CoordinatorVisitAdjustmentScreen extends StatefulWidget {
  const CoordinatorVisitAdjustmentScreen({super.key});

  @override
  State<CoordinatorVisitAdjustmentScreen> createState() => _CoordinatorVisitAdjustmentScreenState();
}

class _CoordinatorVisitAdjustmentScreenState extends State<CoordinatorVisitAdjustmentScreen> {
  final _timeCtrl = TextEditingController(text: '15:00');
  final _durationCtrl = TextEditingController(text: '120');
  bool _isLoading = false;

  Future<void> _commitAdjustment() async {
    setState(() => _isLoading = true);
    try {
      final res = await apiClient.patch('/v1/coordinator/visits/VST-9981', {
        'durationMinutes': int.tryParse(_durationCtrl.text) ?? 120,
      });

      if (!mounted) return;

      if (res['id'] != null || res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visit VST-9981 mutated. Ecosystem broadcasted.'), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Adjustment failed: ${res['error']}'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _timeCtrl.dispose();
    _durationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Schedule Adjustments',
      subtitle: 'Mutate live visit windows securely and trigger waitlist drops',
      icon: Icons.edit_calendar,
      headerGradientColors: const [Colors.amber, Colors.orangeAccent],
      kpiCards: const [
        UnifiedKpiCard(
          title: 'Reschedules (24h)',
          value: '8 Shifts',
          icon: Icons.history,
          color: Colors.orange,
        ),
        UnifiedKpiCard(
          title: 'Waitlist Fill Rate',
          value: '94%',
          icon: Icons.group_add,
          color: Colors.green,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Adjust Visit: VST-9981', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Client: Robert C. • Current: 14:00 - 16:30', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _timeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'New Start Time',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _durationCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Duration (mins)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _commitAdjustment,
                    icon: _isLoading 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.published_with_changes),
                    label: Text(_isLoading ? 'Committing...' : 'Commit Adjustment'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.amber.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
