import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            floating: false,
            pinned: true,
            backgroundColor: PrimeCareColors.radarDark,
            flexibleSpace: FlexibleSpaceBar(
              background: PrimeCareCard(
                
                child: PrimeCareSafeArea(
                  child: PrimeCarePadding(
                    padding: const EdgeInsets.all(24.0),
                    child: PrimeCareColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PrimeCareSizedBox(height: 10),
                        PrimeCareRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const PrimeCareText('EXECUTIVE SUITE', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
                            const PrimeCareBadge(text: 'Q3 Target: 94%', color: PrimeCareColors.amber),
                          ],
                        ),
                        const PrimeCareSizedBox(height: 8),
                        const PrimeCareText('Global Overview', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                        const Spacer(),
                        
                        PrimeCareRow(
                          children: [
                            _buildMacroKpi(icon: Icons.check_circle_rounded, label: 'Compliance', value: '91.4%'),
                            const PrimeCareSizedBox(width: 16),
                            _buildMacroKpi(icon: Icons.groups_rounded, label: 'Active Staff', value: '1,420'),
                            const PrimeCareSizedBox(width: 16),
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
                  
                  return PrimeCareColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PrimeCareSizedBox(height: 8),
                      const PrimeCareText('ORGANIZATIONAL HEALTH', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF475569), letterSpacing: 1.5, fontSize: 12)),
                      const PrimeCareSizedBox(height: 16),
                      
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
                          if (isDesktop) const PrimeCareSizedBox(width: 24) else const PrimeCareSizedBox(height: 24),
                          Flexible(
                            flex: isDesktop ? 1 : 1,
                            fit: isDesktop ? FlexFit.tight : FlexFit.loose,
                            child: PrimeCareColumn(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildInsightWidget(),
                                const PrimeCareSizedBox(height: 24),
                                PrimeCareSizedBox(
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
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PrimeCareText('Payroll vs Billables', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: PrimeCareColors.radarDark)),
              PrimeCareIcon(Icons.trending_up_rounded, color: PrimeCareColors.emerald, size: 28),
            ],
          ),
          const PrimeCareSizedBox(height: 8),
          const PrimeCareText('Last 30 Days Trajectory', style: TextStyle(color: PrimeCareColors.slate500, fontSize: 14)),
          const PrimeCareSizedBox(height: 24),
          PrimeCareRow(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildChartBar(height: 60, color: PrimeCareColors.slate200),
              _buildChartBar(height: 100, color: PrimeCareColors.slate300),
              _buildChartBar(height: 80, color: PrimeCareColors.slate400),
              _buildChartBar(height: 140, color: PrimeCareColors.slate500),
              _buildChartBar(height: 110, color: PrimeCareColors.amber),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInsightWidget() {
    return PrimeCareCard(
      padding: const EdgeInsets.all(24),
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            children: [
              PrimeCareIcon(Icons.auto_awesome_rounded, color: PrimeCareColors.purple, size: 24),
              const PrimeCareSizedBox(width: 8),
              const PrimeCareText('AI Execution Matrix', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: PrimeCareColors.radarDark)),
            ],
          ),
          const PrimeCareSizedBox(height: 16),
          const PrimeCareText(
            'System heuristics detect a 12% surplus in unmapped MT (Massage Therapy) hours across the Greater Toronto Area radius.', 
            style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.5)
          ),
          const PrimeCareSizedBox(height: 16),
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
    return PrimeCareExpanded(
      child: PrimeCareCard(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        backgroundColor: isDanger ? const Color(0xFFBE123C) : const Color(0x22FFFFFF),
        child: PrimeCareColumn(
          children: [
            PrimeCareIcon(icon, color: isDanger ? Colors.white : PrimeCareColors.slate400, size: 20),
            const PrimeCareSizedBox(height: 8),
            PrimeCareText(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
            const PrimeCareSizedBox(height: 4),
            PrimeCareText(label, style: const TextStyle(color: PrimeCareColors.slate300, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildChartBar({required double height, required Color color}) {
    return PrimeCareExpanded(
      child: PrimeCareCard(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: height,
        
      ),
    );
  }
}
