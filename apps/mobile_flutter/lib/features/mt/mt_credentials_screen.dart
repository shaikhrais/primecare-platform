import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class MtCredentialsScreen extends StatelessWidget {
  const MtCredentialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('Regulatory Credentials', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: PrimeCareColors.radarDark),
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
            padding: const EdgeInsets.all(24),
            children: [
              const PrimeCareIcon(Icons.verified_user_rounded, size: 64, color: PrimeCareColors.emerald),
              const PrimeCareSizedBox(height: 16),
              const PrimeCareText('ACTIVE LICENSE STATUS', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
              const PrimeCareSizedBox(height: 48),
              _buildCredentialField('Registration Body', 'CMTO (Ontario)'),
              _buildCredentialField('License / Registration #', '12098-XA'),
              _buildCredentialField('Expiration Date', 'December 31, 2026'),
              const PrimeCareSizedBox(height: 24),
              const PrimeCareText('If your license expires, the Jane App Scheduler will automatically block Coordinators from assigning you new clinical treatments.', textAlign: TextAlign.center, style: TextStyle(color: PrimeCareColors.slate500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialField(String label, String value) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareText(label, style: const TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.slate500)),
          const PrimeCareSizedBox(height: 4),
          PrimeCareText(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: PrimeCareColors.radarDark)),
        ],
      ),
    );
  }
}
