import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:primecare_psw/src/core/api/api_client.dart';
import 'package:primecare_psw/src/core/theme/app_theme.dart';

class SOSScreen extends ConsumerStatefulWidget {
  const SOSScreen({super.key});

  @override
  ConsumerState<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends ConsumerState<SOSScreen> {
  bool _isSending = false;
  bool _sent = false;
  String _selectedType = 'fall';

  final _incidentTypes = [
    {
      'key': 'fall',
      'label': 'Fall / Injury',
      'icon': Icons.personal_injury,
      'color': AppTheme.error
    },
    {
      'key': 'medical',
      'label': 'Medical Emergency',
      'icon': Icons.emergency,
      'color': const Color(0xFFDC2626)
    },
    {
      'key': 'behavioral',
      'label': 'Behavioral Crisis',
      'icon': Icons.psychology_alt,
      'color': AppTheme.warning
    },
    {
      'key': 'safety',
      'label': 'Safety Concern',
      'icon': Icons.shield_outlined,
      'color': AppTheme.info
    },
    {
      'key': 'equipment',
      'label': 'Equipment Failure',
      'icon': Icons.build_circle_outlined,
      'color': const Color(0xFF7C3AED)
    },
    {
      'key': 'other',
      'label': 'Other',
      'icon': Icons.report_problem_outlined,
      'color': const Color(0xFF6B7280)
    },
  ];

  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleSOS() async {
    if (_descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please describe what happened'),
            backgroundColor: AppTheme.warning),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });
    HapticFeedback.heavyImpact();

    try {
      Position? pos;
      try {
        pos = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high),
        );
      } catch (_) {}

      final api = ref.read(apiClientProvider);
      await api.reportIncident(
        type: _selectedType,
        description: _descriptionController.text.trim(),
        severity: _selectedType == 'medical' ? 'critical' : 'high',
        latitude: pos?.latitude,
        longitude: pos?.longitude,
      );

      setState(() {
        _sent = true;
      });
      HapticFeedback.heavyImpact();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Failed to send report. Please call 911 if emergency.'),
            backgroundColor: AppTheme.error),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) return _buildConfirmation(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Incident'),
        backgroundColor: AppTheme.error.withValues(alpha: 0.05),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Emergency banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.error.withValues(alpha: 0.1),
                      AppTheme.error.withValues(alpha: 0.02)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: AppTheme.error.withValues(alpha: 0.2)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.emergency, color: AppTheme.error, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('If this is a life-threatening emergency',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14)),
                          Text('Call 911 immediately',
                              style: TextStyle(
                                  color: AppTheme.error,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Incident type selector
              Text('What happened?',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _incidentTypes.map((t) {
                  final isSelected = _selectedType == t['key'];
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(t['icon'] as IconData,
                            size: 16,
                            color: isSelected
                                ? Colors.white
                                : t['color'] as Color),
                        const SizedBox(width: 6),
                        Text(t['label'] as String),
                      ],
                    ),
                    selected: isSelected,
                    selectedColor: (t['color'] as Color),
                    onSelected: (_) =>
                        setState(() => _selectedType = t['key'] as String),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : null,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Description
              Text('Description',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText:
                      'Describe what happened, who is involved, and any injuries...',
                ),
              ),
              const SizedBox(height: 32),

              // Submit button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isSending ? null : _handleSOS,
                  icon: _isSending
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.send),
                  label: const Text('SUBMIT REPORT',
                      style: TextStyle(letterSpacing: 1)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmation(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.success.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle,
                      color: AppTheme.success, size: 48),
                ),
                const SizedBox(height: 24),
                Text('Report Submitted',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Text(
                  'Your incident report has been sent to the management team. They will follow up shortly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF6B7280), height: 1.5),
                ),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () => setState(() {
                    _sent = false;
                    _descriptionController.clear();
                  }),
                  icon: const Icon(Icons.add),
                  label: const Text('Report Another Incident'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
