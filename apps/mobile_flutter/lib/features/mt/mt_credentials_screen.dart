import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';

class MtCredentialsScreen extends StatelessWidget {
  const MtCredentialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Regulatory Credentials', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: PrimeCareColors.radarDark),
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Icon(Icons.verified_user_rounded, size: 64, color: PrimeCareColors.emerald),
              const SizedBox(height: 16),
              const Text('ACTIVE LICENSE STATUS', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
              const SizedBox(height: 48),
              _buildCredentialField('Registration Body', 'CMTO (Ontario)'),
              _buildCredentialField('License / Registration #', '12098-XA'),
              _buildCredentialField('Expiration Date', 'December 31, 2026'),
              const SizedBox(height: 24),
              const Text('If your license expires, the Jane App Scheduler will automatically block Coordinators from assigning you new clinical treatments.', textAlign: TextAlign.center, style: TextStyle(color: PrimeCareColors.slate500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialField(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: PrimeCareColors.slate200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.slate500)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: PrimeCareColors.radarDark)),
        ],
      ),
    );
  }
}
