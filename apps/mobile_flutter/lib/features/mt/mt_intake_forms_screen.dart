import 'package:flutter/material.dart';

class MtIntakeFormsScreen extends StatelessWidget {
  const MtIntakeFormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Patient Digital Consents', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildDigitalForm('General Liability Waiver', 'Signed on Oct 14, 2025', true),
              _buildDigitalForm('Consent to Treat (Massage)', 'Signed on Oct 14, 2025', true),
              _buildDigitalForm('Acupuncture Add-on Consent', 'Pending Signature', false),
              
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: Column(
                  children: [
                    const Icon(Icons.draw_rounded, size: 48, color: Color(0xFFCBD5E1)),
                    const SizedBox(height: 16),
                    const Text('No pending signatures required for standard treatment protocol today.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF64748B))),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
              const SizedBox(height: 4),
              Text(status, style: TextStyle(color: signed ? const Color(0xFF10B981) : const Color(0xFFEF4444))),
            ],
          ),
          Icon(signed ? Icons.check_circle : Icons.warning_rounded, color: signed ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
        ],
      ),
    );
  }
}
