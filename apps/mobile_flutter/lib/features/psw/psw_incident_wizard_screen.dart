import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PswIncidentWizardScreen extends StatelessWidget {
  const PswIncidentWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: PrimeCareAppBar(title: AppLocalizations.of(context)!.emergencyIncidentWizard),
      body: DesktopPaneWrapper(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PrimeCareCard(
                padding: EdgeInsets.all(24),
                
                child: PrimeCareRow(
                  children: [
                    PrimeCareIcon(Icons.warning_amber_rounded, color: Colors.white, size: 40),
                    SizedBox(width: 16),
                    PrimeCareExpanded(
                      child: PrimeCareColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimeCareText('EVV Clock Halted Globally', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          PrimeCareText('Fill out the incident report completely. Clinical Coordinators have been paged.', style: TextStyle(color: Color(0xFFFFE4E6), fontSize: 13, height: 1.4)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              SizedBox(height: 32),
              PrimeCareText('INCIDENT CLASSIFICATION', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
              SizedBox(height: 12),
              
              _buildSelectionBox('Type of Incident', 'Patient Fall / Injury'),
              SizedBox(height: 16),
              _buildSelectionBox('Severity Level', 'Critical (911 Action Taken)'),
              
              SizedBox(height: 32),
              PrimeCareSectionHeader(title: AppLocalizations.of(context)!.evidenceCapture),
              SizedBox(height: 12),
              
              PrimeCareButton(
                onPressed: () {},
                text: 'Capture Geospatial Photo',
                isPrimary: false,
                icon: Icons.add_a_photo_rounded,
              ),
              
              SizedBox(height: 40),
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(label, style: TextStyle(color: PrimeCareColors.slate400, fontSize: 12, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              PrimeCareText(value, style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          PrimeCareIcon(Icons.arrow_drop_down_rounded, color: PrimeCareColors.slate500, size: 32),
        ],
      ),
    );
  }
}
