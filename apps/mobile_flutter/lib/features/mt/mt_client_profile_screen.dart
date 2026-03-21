import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class MtClientProfileScreen extends StatelessWidget {
  const MtClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('Clinical Profile', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: PrimeCareColors.radarDark),
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper( // Desktop Responsive
          child: PrimeCareListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildPatientHeader(),
              const PrimeCareSizedBox(height: 24),
              _buildContraindicationAlert(),
              const PrimeCareSizedBox(height: 24),
              const PrimeCareText('CLINICAL DIRECTIVES', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const PrimeCareSizedBox(height: 12),
              _buildDirectiveCard('Friction Constraints', 'Do NOT apply deep friction to lower lumbar L4-L5 due to recent surgical fusion (2024).'),
              _buildDirectiveCard('Pressure Limits', 'Max pressure scale: 6/10. Patient bruises extremely easily (taking Warfarin).'),
              
              const PrimeCareSizedBox(height: 40),
              PrimeCareRow(
                children: [
                   PrimeCareExpanded(
                     child: ElevatedButton.icon(
                       icon: const PrimeCareIcon(Icons.description_outlined, color: Colors.blueAccent),
                       label: const PrimeCareText('Intake Forms', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                       
                       onPressed: () => context.push('/mt/intake-forms'),
                     ),
                   ),
                   const PrimeCareSizedBox(width: 16),
                   PrimeCareExpanded(
                     child: ElevatedButton.icon(
                       icon: const PrimeCareIcon(Icons.edit_document, color: Colors.white),
                       label: const PrimeCareText('BEGIN CHARTING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                       
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
        const CircleAvatar(radius: 36, backgroundColor: PrimeCareColors.slate200, child: PrimeCareIcon(Icons.person, size: 40, color: PrimeCareColors.slate500)),
        const PrimeCareSizedBox(width: 16),
        PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
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
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimeCareIcon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 28),
          const PrimeCareSizedBox(width: 12),
          PrimeCareExpanded(
            child: PrimeCareColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareText(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PrimeCareColors.radarDark)),
          const PrimeCareSizedBox(height: 6),
          PrimeCareText(desc, style: const TextStyle(color: Color(0xFF475569), height: 1.4)),
        ],
      ),
    );
  }
}
