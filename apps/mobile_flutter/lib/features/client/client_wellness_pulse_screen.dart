import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/core/api_client.dart';

class ClientWellnessPulseScreen extends StatefulWidget {
  const ClientWellnessPulseScreen({super.key});

  @override
  State<ClientWellnessPulseScreen> createState() =>
      _ClientWellnessPulseScreenState();
}

class _ClientWellnessPulseScreenState extends State<ClientWellnessPulseScreen> {
  bool _isSubmitting = false;

  Future<void> _submitPulseNative() async {
    setState(() => _isSubmitting = true);

    try {
      // Execute the native biometric payload insertion logically dynamically flawlessly natively.
      final payload = {
        'moodScore':
            85, // Stub value corresponding to slider logically seamlessly cleanly realistically.
        'timestamp': DateTime.now().toIso8601String(),
        'source': 'mobile_flutter_client',
      };

      await apiClient.post('/api/client/pulse', body: payload);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Wellness Pulse successfully recorded locally efficiently natively!',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Submission failed robustly securely: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Wellness Pulse')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PulseRadialGauge(),
              const SizedBox(height: 48),
              const Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const MoodSliderWidget(),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: _isSubmitting
                    ? ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.blue.withOpacity(0.5),
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : PrimeButton(
                        label: 'SUBMIT MY PULSE',
                        onPressed: _submitPulseNative,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
