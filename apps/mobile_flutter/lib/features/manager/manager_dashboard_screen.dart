import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart';

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
            backgroundColor: const Color(0xFF0F172A),
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
                            const PrimeCareBadge(text: 'Q3 Target: 94%', color: Color(0xFFF59E0B)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('Global Overview', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                        const Spacer(),
                        
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
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Phase 54: Dynamic Desktop Fluid Grid Logic
                  final isDesktop = constraints.maxWidth >= 800;
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text('ORGANIZATIONAL HEALTH', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF475569), letterSpacing: 1.5, fontSize: 12)),
                      const SizedBox(height: 16),
                      
                      Flex(
                        direction: isDesktop ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: isDesktop ? 2 : 1,
                            fit: isDesktop ? FlexFit.tight : FlexFit.loose,
                            child: _buildGraphicWidget(),
                          ),
                          if (isDesktop) const SizedBox(width: 24) else const SizedBox(height: 24),
                          Flexible(
                            flex: isDesktop ? 1 : 1,
                            fit: isDesktop ? FlexFit.tight : FlexFit.loose,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildInsightWidget(),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: PrimeCareButton(
                                    onPressed: () => HapticFeedback.mediumImpact(),
                                    text: 'GENERATE FULL AUDIT REPORT',
                                    icon: Icons.download_rounded,
                                    isPrimary: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGraphicWidget() {
    return PrimeCareCard(
      padding: const EdgeInsets.all(24),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildChartBar(height: 60, color: const Color(0xFFE2E8F0)),
              _buildChartBar(height: 100, color: const Color(0xFFCBD5E1)),
              _buildChartBar(height: 80, color: const Color(0xFF94A3B8)),
              _buildChartBar(height: 140, color: const Color(0xFF64748B)),
              _buildChartBar(height: 110, color: const Color(0xFFF59E0B)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInsightWidget() {
    return PrimeCareCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: const Color(0xFF8B5CF6), size: 24),
              const SizedBox(width: 8),
              const Text('AI Execution Matrix', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF0F172A))),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'System heuristics detect a 12% surplus in unmapped MT (Massage Therapy) hours across the Greater Toronto Area radius.', 
            style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.5)
          ),
          const SizedBox(height: 16),
          PrimeCareButton(
            onPressed: () {},
            text: 'Deploy Marketing Push',
            icon: Icons.podcasts_rounded,
            isPrimary: false,
          )
        ],
      ),
    );
  }

  Widget _buildMacroKpi({required IconData icon, required String label, required String value, bool isDanger = false}) {
    return Expanded(
      child: PrimeCareCard(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        backgroundColor: isDanger ? const Color(0xFFBE123C) : const Color(0x22FFFFFF),
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
