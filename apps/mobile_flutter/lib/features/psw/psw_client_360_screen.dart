import 'package:flutter/material.dart';
import '../../core/widgets/primecare_app_bar.dart';

class PswClient360Screen extends StatelessWidget {
  final String clientId;
  final String clientName;

  const PswClient360Screen({super.key, required this.clientId, required this.clientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareAppBar(title: '$clientName - 360°'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Structural Header Block
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: const Color(0xFFE2E8F0),
                    child: Text(
                      clientName.substring(0, 1), 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: Color(0xFF0F172A))
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(clientName, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  const Text('Dementia Care Track • Resuscitate (DNR) - No', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Drilled Data Modules
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  _buildNexusCard(
                    context, 
                    title: 'Active Care Plan Vault', 
                    icon: Icons.folder_special_rounded, 
                    color: const Color(0xFF3B82F6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Valid from: Oct 1, 2025 to Oct 1, 2026', style: TextStyle(color: Color(0xFF475569))),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text('View Official Directive (PDF)'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        )
                      ],
                    )
                  ),
                  
                  const SizedBox(height: 16),

                  _buildNexusCard(
                    context, 
                    title: '30-Day Vitals Trend', 
                    icon: Icons.monitor_heart_rounded, 
                    color: const Color(0xFF10B981),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Blood Pressure', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('118/72 mmHg', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Heart Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('68 BPM', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Simulated embedded chart graph area
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(child: Text('Interactive Spline Chart Area', style: TextStyle(color: Color(0xFF94A3B8)))),
                        )
                      ],
                    )
                  ),

                  const SizedBox(height: 16),

                  _buildNexusCard(
                    context, 
                    title: 'Emergency Contacts', 
                    icon: Icons.contact_phone_rounded, 
                    color: const Color(0xFFE11D48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Maria Jenkins (Daughter)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 4),
                            Text('Primary Power of Attorney', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.phone, color: Color(0xFFE11D48)),
                          style: IconButton.styleFrom(backgroundColor: const Color(0x11E11D48)),
                        )
                      ],
                    )
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      )
        ),
      ),
    );
  }

  Widget _buildNexusCard(BuildContext context, {required String title, required IconData icon, required Color color, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF0F172A))),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}
