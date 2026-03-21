import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';

class MtIntakeFormsScreen extends StatelessWidget {
  const MtIntakeFormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Patient Digital Consents', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: PrimeCareColors.radarDark),
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildDigitalForm('General Liability Waiver', 'Signed on Oct 14, 2025', true),
              _buildDigitalForm('Consent to Treat (Massage)', 'Signed on Oct 14, 2025', true),
              _buildDigitalForm('Acupuncture Add-on Consent', 'Pending Signature', false),
              
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: PrimeCareColors.slate200)),
                child: Column(
                  children: [
                    const Icon(Icons.draw_rounded, size: 48, color: PrimeCareColors.slate300),
                    const SizedBox(height: 16),
                    const Text('No pending signatures required for standard treatment protocol today.', textAlign: TextAlign.center, style: TextStyle(color: PrimeCareColors.slate500)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDigitalForm(String title, String status, bool signed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: PrimeCareColors.slate200)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PrimeCareColors.radarDark)),
              const SizedBox(height: 4),
              Text(status, style: TextStyle(color: signed ? PrimeCareColors.emerald : const Color(0xFFEF4444))),
            ],
          ),
          Icon(signed ? Icons.check_circle : Icons.warning_rounded, color: signed ? PrimeCareColors.emerald : const Color(0xFFEF4444)),
        ],
      ),
    );
  }
}
