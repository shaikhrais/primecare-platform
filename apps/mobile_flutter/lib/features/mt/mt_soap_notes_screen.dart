import 'package:flutter/material.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';
import 'package:go_router/go_router.dart';

class MtSoapNotesScreen extends StatelessWidget {
  const MtSoapNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Clinical SOAP Notes', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: Center(
        child: DesktopPaneWrapper( // Desktop Responsive
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildSoapInput('Subjective', 'What the patient reported feeling today...', maxLines: 3),
              const SizedBox(height: 20),
              _buildSoapInput('Objective', 'Visual/Palpation findings (e.g. Hypertonicity in Traps)...', maxLines: 4),
              const SizedBox(height: 20),
              _buildSoapInput('Assessment', 'Clinical reaction to treatment today...', maxLines: 3),
              const SizedBox(height: 20),
              _buildSoapInput('Plan', 'Recommended home care, stretching, follow-up frequency...', maxLines: 3),
              
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text('SIGN & SUBMIT TO LEDGER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981), // Emerald Success
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A), fontSize: 16, letterSpacing: 1.2)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF8B5CF6))),
          ),
        )
      ],
    );
  }
}
