import 'package:flutter/material.dart';
import '../../core/widgets/primecare_app_bar.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';
import '../../core/widgets/components/primecare_ui.dart';

class PswIncidentWizardScreen extends StatelessWidget {
  const PswIncidentWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Emergency Incident Wizard'),
      body: DesktopPaneWrapper(
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
              
              _buildSelectionBox('Type of Incident', 'Patient Fall / Injury'),
              const SizedBox(height: 16),
              _buildSelectionBox('Severity Level', 'Critical (911 Action Taken)'),
              
              const SizedBox(height: 32),
              const PrimeCareSectionHeader(title: 'EVIDENCE CAPTURE'),
              const SizedBox(height: 12),
              
              PrimeCareButton(
                onPressed: () {},
                text: 'Capture Geospatial Photo',
                isPrimary: false,
                icon: Icons.add_a_photo_rounded,
              ),
              
              const SizedBox(height: 40),
              PrimeCareButton(
                onPressed: () => Navigator.of(context).pop(),
                text: 'TRANSMIT SECURE REPORT',
                isPrimary: true,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionBox(String label, String value) {
    return PrimeCareCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
