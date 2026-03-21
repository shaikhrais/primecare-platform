import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class MtClientProfileScreen extends StatelessWidget {
  const MtClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: PrimeCareText('Clinical Profile', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: PrimeCareColors.radarDark),
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper( // Desktop Responsive
          child: PrimeCareListView(
            padding: EdgeInsets.all(24),
            children: [
              _buildPatientHeader(),
              PrimeCareSizedBox(height: 24),
              _buildContraindicationAlert(),
              PrimeCareSizedBox(height: 24),
              PrimeCareText('CLINICAL DIRECTIVES', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              PrimeCareSizedBox(height: 12),
              _buildDirectiveCard('Friction Constraints', 'Do NOT apply deep friction to lower lumbar L4-L5 due to recent surgical fusion (2024).'),
              _buildDirectiveCard('Pressure Limits', 'Max pressure scale: 6/10. Patient bruises extremely easily (taking Warfarin).'),
              
              PrimeCareSizedBox(height: 40),
              PrimeCareRow(
                children: [
                   PrimeCareExpanded(
                     child: ElevatedButton.icon(
                       icon: PrimeCareIcon(Icons.description_outlined, color: Colors.blueAccent),
                       label: PrimeCareText('Intake Forms', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                       
                       onPressed: () => context.push('/mt/intake-forms'),
                     ),
                   ),
                   PrimeCareSizedBox(width: 16),
                   PrimeCareExpanded(
                     child: ElevatedButton.icon(
                       icon: PrimeCareIcon(Icons.edit_document, color: Colors.white),
                       label: PrimeCareText('BEGIN CHARTING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                       
                       onPressed: () => context.push('/mt/soap-notes'),
                     ),
                   )
                ]
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientHeader() {
    return PrimeCareRow(
      children: [
        CircleAvatar(radius: 36, backgroundColor: PrimeCareColors.slate200, child: PrimeCareIcon(Icons.person, size: 40, color: PrimeCareColors.slate500)),
        PrimeCareSizedBox(width: 16),
        PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareText('Arthur Pendelton', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
            PrimeCareSizedBox(height: 4),
            PrimeCareText('DOB: 1948-04-12 (78 Yrs)', style: TextStyle(color: PrimeCareColors.slate500, fontSize: 16)),
          ],
        )
      ],
    );
  }

  Widget _buildContraindicationAlert() {
    return PrimeCareCard(
      padding: EdgeInsets.all(16),
      
      child: PrimeCareRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareIcon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 28),
          PrimeCareSizedBox(width: 12),
          PrimeCareExpanded(
            child: PrimeCareColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareText('CRITICAL CONTRAINDICATION', style: TextStyle(color: Color(0xFFB91C1C), fontWeight: FontWeight.bold)),
                PrimeCareSizedBox(height: 4),
                PrimeCareText('Active DVT (Deep Vein Thrombosis) diagnosed in right calf. Absolute restriction on lower right extremity compression.', style: TextStyle(color: Color(0xFF7F1D1D), height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDirectiveCard(String title, String desc) {
    return PrimeCareCard(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareText(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PrimeCareColors.radarDark)),
          PrimeCareSizedBox(height: 6),
          PrimeCareText(desc, style: TextStyle(color: Color(0xFF475569), height: 1.4)),
        ],
      ),
    );
  }
}
