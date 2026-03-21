import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class MtSoapNotesScreen extends StatelessWidget {
  const MtSoapNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: Colors.white,
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('Clinical SOAP Notes', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 1,
        iconTheme: const IconThemeData(color: PrimeCareColors.radarDark),
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper( // Desktop Responsive
          child: PrimeCareListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildSoapInput('Subjective', 'What the patient reported feeling today...', maxLines: 3),
              const PrimeCareSizedBox(height: 20),
              _buildSoapInput('Objective', 'Visual/Palpation findings (e.g. Hypertonicity in Traps)...', maxLines: 4),
              const PrimeCareSizedBox(height: 20),
              _buildSoapInput('Assessment', 'Clinical reaction to treatment today...', maxLines: 3),
              const PrimeCareSizedBox(height: 20),
              _buildSoapInput('Plan', 'Recommended home care, stretching, follow-up frequency...', maxLines: 3),
              
              const PrimeCareSizedBox(height: 32),
              ElevatedButton.icon(
                icon: const PrimeCareIcon(Icons.check_circle, color: Colors.white),
                label: const PrimeCareText('SIGN & SUBMIT TO LEDGER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
                
                onPressed: () {
                   // Mock submitting, Route to double-entry invoice
                   context.push('/mt/invoice');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSoapInput(String title, String hint, {int maxLines = 1}) {
    return PrimeCareColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimeCareText(title, style: const TextStyle(fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark, fontSize: 16, letterSpacing: 1.2)),
        const PrimeCareSizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: PrimeCareColors.slate400),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: PrimeCareColors.slate200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: PrimeCareColors.slate200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: PrimeCareColors.purple)),
          ),
        )
      ],
    );
  }
}
