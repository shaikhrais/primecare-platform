import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class IssueTrackingScreen extends StatelessWidget {
  const IssueTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                            children: [
                                _buildKanbanBoard(context),
                            ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildTechDebtScore(context),
                            const SizedBox(height: 24),
                            _buildCriticalIncidents(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Issue Tracking & Tech Debt',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage active bugs, monitor technical debt, and review incident timelines.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.siren, 'Declare Incident'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.plus, 'Log Issue'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildKPIUnit(context, 'Open Issues', '142', LucideIcons.bug, '-12 this week', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Mean Time to Resolve', '4.2h', LucideIcons.timer, 'Target: < 4.0h', Colors.orange)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Critical Bugs (P0)', '0', LucideIcons.alertTriangle, 'All quiet', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Tech Debt Ratio', '14%', LucideIcons.code, 'Acceptable range', Colors.blue)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String subtitle, Color color) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
            ),
           )
        ],
      ),
    );
  }

  Widget _buildKanbanBoard(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Active Sprints & Backlog',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                ),
                const Text('View All Jira Boards', style: TextStyle(color: Colors.blueAccent, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Expanded(child: _buildKanbanColumn('To Do', [
                      _buildKanbanCard('PRIME-402', 'Update scheduling adapter to v2', 'Tech Debt', Colors.orange),
                      _buildKanbanCard('PRIME-415', 'Fix styling on mobile EMR view', 'Bug', Colors.redAccent),
                  ])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildKanbanColumn('In Progress', [
                      _buildKanbanCard('PRIME-399', 'Migrate billing to new API gateway', 'Feature', Colors.blue),
                  ])),
                   const SizedBox(width: 16),
                  Expanded(child: _buildKanbanColumn('In Review', [
                      _buildKanbanCard('PRIME-380', 'Implement 2FA backup codes', 'Security', PrimeCareTheme.emeraldTeal),
                      _buildKanbanCard('PRIME-381', 'Optimize Postgres queries', 'Perf', Colors.purpleAccent),
                  ])),
              ]
          )
        ],
      ),
    );
  }

  Widget _buildKanbanColumn(String title, List<Widget> cards) {
      return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...cards,
              ]
          )
      );
  }

  Widget _buildKanbanCard(String id, String desc, String tag, Color tagColor) {
      return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(id, style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: tagColor.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                              child: Text(tag, style: TextStyle(color: tagColor, fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                      ]
                  ),
                  const SizedBox(height: 8),
                  Text(desc, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.3)),
                  const SizedBox(height: 12),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Icon(LucideIcons.messageSquare, color: Colors.white54, size: 14),
                           const CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.person, size: 12, color: Colors.white),
                          )
                      ]
                  )
              ]
          )
      );
  }

    Widget _buildTechDebtScore(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                 Text(
                  'Technical Debt Index',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            const SizedBox(height: 24),
            Stack(
                 alignment: Alignment.center,
                 children: [
                     SizedBox(
                         height: 140,
                         width: 140,
                         child: CircularProgressIndicator(
                             value: 0.86, // Inverted so green is good (low debt)
                             strokeWidth: 12,
                             backgroundColor: Colors.white12,
                             valueColor: const AlwaysStoppedAnimation<Color>(PrimeCareTheme.emeraldTeal),
                         )
                     ),
                     Column(
                         children: [
                             const Text('B+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 42)),
                             Text('Score: 86/100', style: TextStyle(color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.8), fontSize: 14, fontWeight: FontWeight.bold)),
                         ]
                     )
                 ]
             ),
             const SizedBox(height: 24),
             _buildCodeSmell('Duplicate Code', 'Low', PrimeCareTheme.emeraldTeal),
             const SizedBox(height: 12),
             _buildCodeSmell('Outdated Packages', 'Med', Colors.orange),
             const SizedBox(height: 12),
             _buildCodeSmell('Test Coverage (78%)', 'Med', Colors.orange),
          ],
        ),
      );
    }

     Widget _buildCodeSmell(String title, String level, Color color) {
         return Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                 Text(title, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                 Text(level, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
             ]
         );
     }

    Widget _buildCriticalIncidents(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                        children: [
                            Icon(LucideIcons.history, color: Colors.blue, size: 24),
                            const SizedBox(width: 12),
                            Text(
                            'Incident Post-Mortems',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                        ],
                    ),
                    const SizedBox(height: 24),
                    _buildIncidentRow('Oct 12', 'Database Deadlock', 'Resolved (22m)', PrimeCareTheme.emeraldTeal),
                    const Divider(color: Colors.white12, height: 24),
                    _buildIncidentRow('Oct 04', 'Auth Service Outage', 'Resolved (1h 5m)', Colors.orange),
                    const Divider(color: Colors.white12, height: 24),
                    _buildIncidentRow('Sep 28', 'DDoS on API Gateway', 'Resolved (14m)', PrimeCareTheme.emeraldTeal),
                ]
            )
        );
    }

    Widget _buildIncidentRow(String date, String name, String status, Color dotColor) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Container(
                     width: 10,
                     height: 10,
                     margin: const EdgeInsets.only(top: 4),
                     decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                     child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                             Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                             const SizedBox(height: 4),
                             Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                     Text(date, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                                     Text(status, style: TextStyle(color: dotColor, fontSize: 12)),
                                 ]
                             )
                         ]
                     )
                 )
             ]
        );
    }
}
