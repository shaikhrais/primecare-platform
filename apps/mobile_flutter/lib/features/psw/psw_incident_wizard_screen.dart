import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PswIncidentWizardScreen extends StatelessWidget {
  const PswIncidentWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: const PrimeCareAppBar(title: 'Emergency Incident Wizard'),
      body: DesktopPaneWrapper(
        child: PrimeCareScrollWrapper(
          padding: const EdgeInsets.all(24),
          child: PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PrimeCareCard(
                padding: const EdgeInsets.all(24),
                
                child: PrimeCareRow(
                  children: [
                    const PrimeCareIcon(Icons.warning_amber_rounded, color: Colors.white, size: 40),
                    const PrimeCareSizedBox(width: 16),
                    PrimeCareExpanded(
                      child: PrimeCareColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          PrimeCareText('EVV Clock Halted Globally', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          PrimeCareSizedBox(height: 4),
                          PrimeCareText('Fill out the incident report completely. Clinical Coordinators have been paged.', style: TextStyle(color: Color(0xFFFFE4E6), fontSize: 13, height: 1.4)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              const PrimeCareSizedBox(height: 32),
              const PrimeCareText('INCIDENT CLASSIFICATION', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
              const PrimeCareSizedBox(height: 12),
              
              _buildSelectionBox('Type of Incident', 'Patient Fall / Injury'),
              const PrimeCareSizedBox(height: 16),
              _buildSelectionBox('Severity Level', 'Critical (911 Action Taken)'),
              
              const PrimeCareSizedBox(height: 32),
              const PrimeCareSectionHeader(title: 'EVIDENCE CAPTURE'),
              const PrimeCareSizedBox(height: 12),
              
              PrimeCareButton(
                onPressed: () {},
                text: 'Capture Geospatial Photo',
                isPrimary: false,
                icon: Icons.add_a_photo_rounded,
              ),
              
              const PrimeCareSizedBox(height: 40),
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
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(label, style: const TextStyle(color: PrimeCareColors.slate400, fontSize: 12, fontWeight: FontWeight.bold)),
              const PrimeCareSizedBox(height: 4),
              PrimeCareText(value, style: const TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const PrimeCareIcon(Icons.arrow_drop_down_rounded, color: PrimeCareColors.slate500, size: 32),
        ],
      ),
    );
  }
}
