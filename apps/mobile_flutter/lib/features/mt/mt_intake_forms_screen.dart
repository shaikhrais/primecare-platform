import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class MtIntakeFormsScreen extends StatelessWidget {
  const MtIntakeFormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('Patient Digital Consents', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: PrimeCareColors.radarDark),
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildDigitalForm('General Liability Waiver', 'Signed on Oct 14, 2025', true),
              _buildDigitalForm('Consent to Treat (Massage)', 'Signed on Oct 14, 2025', true),
              _buildDigitalForm('Acupuncture Add-on Consent', 'Pending Signature', false),
              
              const PrimeCareSizedBox(height: 40),
              PrimeCareCard(
                padding: const EdgeInsets.all(24),
                
                child: PrimeCareColumn(
                  children: [
                    const PrimeCareIcon(Icons.draw_rounded, size: 48, color: PrimeCareColors.slate300),
                    const PrimeCareSizedBox(height: 16),
                    const PrimeCareText('No pending signatures required for standard treatment protocol today.', textAlign: TextAlign.center, style: TextStyle(color: PrimeCareColors.slate500)),
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
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PrimeCareColors.radarDark)),
              const PrimeCareSizedBox(height: 4),
              PrimeCareText(status, style: TextStyle(color: signed ? PrimeCareColors.emerald : const Color(0xFFEF4444))),
            ],
          ),
          PrimeCareIcon(signed ? Icons.check_circle : Icons.warning_rounded, color: signed ? PrimeCareColors.emerald : const Color(0xFFEF4444)),
        ],
      ),
    );
  }
}
