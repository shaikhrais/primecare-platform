import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RnDashboardScreen extends StatelessWidget {
  const RnDashboardScreen({super.key});

  final List<Map<String, dynamic>> _activeIncidents = const [
    {'id': 'inc_1', 'patient': 'Sarah Jenkins', 'psw': 'John Doe', 'type': 'Patient Fall / Injury', 'time': '3 Mins Ago', 'severity': 'Critical'},
    {'id': 'inc_2', 'patient': 'Robert Kiyosaki', 'psw': 'Jane Smith', 'type': 'Medication Refusal', 'time': '12 Mins Ago', 'severity': 'High'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // Clinical Header
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFFE11D48), // Clinical Crimson
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFBE123C), Color(0xFFE11D48)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -50, right: -50,
                      child: Icon(Icons.local_hospital_rounded, size: 200, color: Colors.white.withOpacity(0.05)),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text('CLINICAL TRIAGE HUB', style: TextStyle(color: Color(0xFFFFE4E6), fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
                            const SizedBox(height: 8),
                            const Text('Active Emergencies', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.warning_amber_rounded, color: Color(0xFFE11D48), size: 20),
                                  SizedBox(width: 8),
                                  Text('2 Require Immediate Action', style: TextStyle(color: Color(0xFFE11D48), fontWeight: FontWeight.bold, fontSize: 14)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          
          // Incident Stream
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.crossAxisExtent >= 900;
                
                if (isDesktop) {
                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      mainAxisExtent: 250, // Static card height constraint
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildIncidentCard(context, _activeIncidents[index]);
                      },
                      childCount: _activeIncidents.length,
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final incident = _activeIncidents[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildIncidentCard(context, incident),
                      );
                    },
                    childCount: _activeIncidents.length,
                  ),
                );
              }
            )
          )
        ],
      ),
    );
  }

  Widget _buildIncidentCard(BuildContext context, Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFECDD3), width: 2), // Light Crimson Border
        boxShadow: const [BoxShadow(color: Color(0x11E11D48), blurRadius: 16, offset: Offset(0, 8))],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimeCareBadge(text: data['time'], color: const Color(0xFFE11D48)),
              Text('Severity: ${data['severity']}', style: const TextStyle(color: Color(0xFFE11D48), fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          Text(data['type'], style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w900, fontSize: 22)),
          const SizedBox(height: 8),
          Text('Patient: ${data['patient']} • Reporter: ${data['psw']}', style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: PrimeCareButton(
                  onPressed: () => HapticFeedback.heavyImpact(),
                  text: 'CALL PSW',
                  isPrimary: true,
                  icon: Icons.phone,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimeCareButton(
                  onPressed: () {},
                  text: 'VIEW REPORT',
                  isPrimary: false,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
