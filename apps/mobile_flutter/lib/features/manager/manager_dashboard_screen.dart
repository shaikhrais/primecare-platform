import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0F172A), // Absolute Obsidian Backing
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF020617), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('EXECUTIVE SUITE', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: const Color(0x33F59E0B), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFF59E0B))),
                              child: const Text('Q3 Target: 94%', style: TextStyle(color: Color(0xFFF59E0B), fontWeight: FontWeight.bold, fontSize: 11)), // Gold Accent
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('Global Overview', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                        const Spacer(),
                        
                        // Kpi Horizontal Row
                        Row(
                          children: [
                            _buildMacroKpi(icon: Icons.check_circle_rounded, label: 'Compliance', value: '91.4%'),
                            const SizedBox(width: 16),
                            _buildMacroKpi(icon: Icons.groups_rounded, label: 'Active Staff', value: '1,420'),
                            const SizedBox(width: 16),
                            _buildMacroKpi(icon: Icons.warning_rounded, label: 'Critical SOS', value: '2', isDanger: true),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                const Text('ORGANIZATIONAL HEALTH', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF475569), letterSpacing: 1.5, fontSize: 12)),
                const SizedBox(height: 16),
                
                // Static Graphic Widget representing global revenue/payroll metrics
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 8))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Payroll vs Billables', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF0F172A))),
                          Icon(Icons.trending_up_rounded, color: const Color(0xFF10B981), size: 28),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Last 30 Days Trajectory', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                      const SizedBox(height: 24),
                      
                      // Fake Graphic Bars
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildChartBar(height: 60, color: const Color(0xFFE2E8F0)),
                          _buildChartBar(height: 100, color: const Color(0xFFCBD5E1)),
                          _buildChartBar(height: 80, color: const Color(0xFF94A3B8)),
                          _buildChartBar(height: 140, color: const Color(0xFF64748B)),
                          _buildChartBar(height: 110, color: const Color(0xFFF59E0B)), // Current Month Highlight (Gold)
                        ],
                      )
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Deep Link Action Node
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () { HapticFeedback.mediumImpact(); },
                    icon: const Icon(Icons.download_rounded),
                    label: const Text('GENERATE FULL AUDIT REPORT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A), // Obsidian Black Button
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMacroKpi({required IconData icon, required String label, required String value, bool isDanger = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isDanger ? const Color(0xFFBE123C) : const Color(0x22FFFFFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: isDanger ? Colors.white : const Color(0xFF94A3B8), size: 20),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildChartBar({required double height, required Color color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        ),
      ),
    );
  }
}
