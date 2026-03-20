import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MtClientProfileScreen extends StatelessWidget {
  const MtClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Clinical Profile', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800), // Desktop Responsive
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildPatientHeader(),
              const SizedBox(height: 24),
              _buildContraindicationAlert(),
              const SizedBox(height: 24),
              const Text('CLINICAL DIRECTIVES', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const SizedBox(height: 12),
              _buildDirectiveCard('Friction Constraints', 'Do NOT apply deep friction to lower lumbar L4-L5 due to recent surgical fusion (2024).'),
              _buildDirectiveCard('Pressure Limits', 'Max pressure scale: 6/10. Patient bruises extremely easily (taking Warfarin).'),
              
              const SizedBox(height: 40),
              Row(
                children: [
                   Expanded(
                     child: ElevatedButton.icon(
                       icon: const Icon(Icons.description_outlined, color: Colors.blueAccent),
                       label: const Text('Intake Forms', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.white,
                         padding: const EdgeInsets.symmetric(vertical: 20),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.blueAccent)),
                       ),
                       onPressed: () => context.push('/mt/intake-forms'),
                     ),
                   ),
                   const SizedBox(width: 16),
                   Expanded(
                     child: ElevatedButton.icon(
                       icon: const Icon(Icons.edit_document, color: Colors.white),
                       label: const Text('BEGIN CHARTING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                       style: ElevatedButton.styleFrom(
                         backgroundColor: const Color(0xFF8B5CF6), // Premium MT Purple
                         padding: const EdgeInsets.symmetric(vertical: 20),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                       ),
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
    return Row(
      children: [
        const CircleAvatar(radius: 36, backgroundColor: Color(0xFFE2E8F0), child: Icon(Icons.person, size: 40, color: Color(0xFF64748B))),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Arthur Pendelton', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
            SizedBox(height: 4),
            Text('DOB: 1948-04-12 (78 Yrs)', style: TextStyle(color: Color(0xFF64748B), fontSize: 16)),
          ],
        )
      ],
    );
  }

  Widget _buildContraindicationAlert() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFFEF2F2), border: Border.all(color: const Color(0xFFFCA5A5)), borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('CRITICAL CONTRAINDICATION', style: TextStyle(color: Color(0xFFB91C1C), fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Active DVT (Deep Vein Thrombosis) diagnosed in right calf. Absolute restriction on lower right extremity compression.', style: TextStyle(color: Color(0xFF7F1D1D), height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDirectiveCard(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
          const SizedBox(height: 6),
          Text(desc, style: const TextStyle(color: Color(0xFF475569), height: 1.4)),
        ],
      ),
    );
  }
}
