import 'package:flutter/material.dart';
import '../../core/widgets/primecare_app_bar.dart';

class PswIncidentWizardScreen extends StatelessWidget {
  const PswIncidentWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const PrimeCareAppBar(title: 'Emergency Incident Wizard'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFE11D48),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Color(0x55E11D48), blurRadius: 24, offset: Offset(0, 8))],
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('EVV Clock Halted Globally', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 4),
                        Text('Fill out the incident report completely. Clinical Coordinators have been paged.', style: TextStyle(color: Color(0xFFFFE4E6), fontSize: 13, height: 1.4)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Text('INCIDENT CLASSIFICATION', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
            const SizedBox(height: 12),
            
            // Fake Dropdown Selects Matrix
            _buildSelectionBox('Type of Incident', 'Patient Fall / Injury'),
            const SizedBox(height: 16),
            _buildSelectionBox('Severity Level', 'Critical (911 Action Taken)'),
            
            const SizedBox(height: 32),
            const Text('EVIDENCE CAPTURE', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
            const SizedBox(height: 12),
            
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_a_photo_rounded, color: Color(0xFF0F172A)),
              label: const Text('Capture Geospatial Photo', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 24),
                side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                backgroundColor: Colors.white,
              ),
            ),
            
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE11D48),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('TRANSMIT SECURE REPORT', style: TextStyle(letterSpacing: 0.5)),
            )
          ],
        ),
      ),
      ),
      ),
    );
  }

  Widget _buildSelectionBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF64748B), size: 32),
        ],
      ),
    );
  }
}
