import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class MtIntakeFormsScreen extends StatelessWidget {
  const MtIntakeFormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: PrimeCareNavBar(
        title: PrimeCareText('Patient Digital Consents', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
            padding: EdgeInsets.all(24),
            children: [
              _buildDigitalForm('General Liability Waiver', 'Signed on Oct 14, 2025', true),
              _buildDigitalForm('Consent to Treat (Massage)', 'Signed on Oct 14, 2025', true),
              _buildDigitalForm('Acupuncture Add-on Consent', 'Pending Signature', false),
              
              SizedBox(height: 40),
              PrimeCareCard(
                padding: EdgeInsets.all(24),
                
                child: PrimeCareColumn(
                  children: [
                    PrimeCareIcon(Icons.draw_rounded, size: 48, color: PrimeCareColors.slate300),
                    SizedBox(height: 16),
                    PrimeCareText('No pending signatures required for standard treatment protocol today.', textAlign: TextAlign.center, style: TextStyle(color: PrimeCareColors.slate500)),
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
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PrimeCareColors.radarDark)),
              SizedBox(height: 4),
              PrimeCareText(status, style: TextStyle(color: signed ? PrimeCareColors.emerald : Color(0xFFEF4444))),
            ],
          ),
          PrimeCareIcon(signed ? Icons.check_circle : Icons.warning_rounded, color: signed ? PrimeCareColors.emerald : Color(0xFFEF4444)),
        ],
      ),
    );
  }
}
