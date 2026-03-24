import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ManagerAnalyticsMatrixScreen extends StatelessWidget {
  const ManagerAnalyticsMatrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: Color(0xFFF1F5F9),
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
                    padding: EdgeInsets.all(24.0),
                    child: PrimeCareColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        PrimeCareRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimeCareText('EXECUTIVE SUITE', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
                            PrimeCareBadge(text: 'Q3 Target: 94%', color: PrimeCareColors.amber),
                          ],
                        ),
                        SizedBox(height: 8),
                        PrimeCareText('Global Overview', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                        Spacer(),
                        
                        PrimeCareRow(
                          children: [
                            _buildMacroKpi(icon: Icons.check_circle_rounded, label: AppLocalizations.of(context)!.compliance, value: '91.4%'),
                            SizedBox(width: 16),
                            _buildMacroKpi(icon: Icons.groups_rounded, label: AppLocalizations.of(context)!.activeStaff, value: '1,420'),
                            SizedBox(width: 16),
                            _buildMacroKpi(icon: Icons.warning_rounded, label: AppLocalizations.of(context)!.criticalSos, value: '2', isDanger: true),
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
            padding: EdgeInsets.fromLTRB(24, 24, 24, 120),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Phase 54: Dynamic Desktop Fluid Grid Logic
                  final isDesktop = constraints.maxWidth >= 800;
                  
                  return PrimeCareColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      PrimeCareText('ORGANIZATIONAL HEALTH', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF475569), letterSpacing: 1.5, fontSize: 12)),
                      SizedBox(height: 16),
                      
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
                          if (isDesktop) SizedBox(width: 24) else SizedBox(height: 24),
                          Flexible(
                            flex: isDesktop ? 1 : 1,
                            fit: isDesktop ? FlexFit.tight : FlexFit.loose,
                            child: PrimeCareColumn(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildInsightWidget(),
                                SizedBox(height: 24),
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
      padding: EdgeInsets.all(24),
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimeCareText('Payroll vs Billables', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: PrimeCareColors.radarDark)),
              PrimeCareIcon(Icons.trending_up_rounded, color: PrimeCareColors.emerald, size: 28),
            ],
          ),
          SizedBox(height: 8),
          PrimeCareText('Last 30 Days Trajectory', style: TextStyle(color: PrimeCareColors.slate500, fontSize: 14)),
          SizedBox(height: 24),
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
      padding: EdgeInsets.all(24),
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            children: [
              PrimeCareIcon(Icons.auto_awesome_rounded, color: PrimeCareColors.purple, size: 24),
              SizedBox(width: 8),
              PrimeCareText('AI Execution Matrix', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: PrimeCareColors.radarDark)),
            ],
          ),
          SizedBox(height: 16),
          PrimeCareText(
            'System heuristics detect a 12% surplus in unmapped MT (Massage Therapy) hours across the Greater Toronto Area radius.', 
            style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.5)
          ),
          SizedBox(height: 16),
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
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        backgroundColor: isDanger ? Color(0xFFBE123C) : Color(0x22FFFFFF),
        child: PrimeCareColumn(
          children: [
            PrimeCareIcon(icon, color: isDanger ? Colors.white : PrimeCareColors.slate400, size: 20),
            SizedBox(height: 8),
            PrimeCareText(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
            SizedBox(height: 4),
            PrimeCareText(label, style: TextStyle(color: PrimeCareColors.slate300, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildChartBar({required double height, required Color color}) {
    return PrimeCareExpanded(
      child: PrimeCareCard(child: const SizedBox.shrink(), margin: EdgeInsets.symmetric(horizontal: 4), height: height,
        
      ),
    );
  }
}
