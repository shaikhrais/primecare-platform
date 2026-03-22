import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class MtCredentialsScreen extends StatelessWidget {
  const MtCredentialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: PrimeCareNavBar(
        title: PrimeCareText('Regulatory Credentials', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
            padding: EdgeInsets.all(24),
            children: [
              PrimeCareIcon(Icons.verified_user_rounded, size: 64, color: PrimeCareColors.emerald),
              SizedBox(height: 16),
              PrimeCareText('ACTIVE LICENSE STATUS', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
              SizedBox(height: 48),
              _buildCredentialField('Registration Body', 'CMTO (Ontario)'),
              _buildCredentialField('License / Registration #', '12098-XA'),
              _buildCredentialField('Expiration Date', 'December 31, 2026'),
              SizedBox(height: 24),
              PrimeCareText('If your license expires, the Jane App Scheduler will automatically block Coordinators from assigning you new clinical treatments.', textAlign: TextAlign.center, style: TextStyle(color: PrimeCareColors.slate500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialField(String label, String value) {
    return PrimeCareCard(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareText(label, style: TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.slate500)),
          SizedBox(height: 4),
          PrimeCareText(value, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: PrimeCareColors.radarDark)),
        ],
      ),
    );
  }
}
