import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingDirectorDashboardScreen extends StatelessWidget {
  const TrainingDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Training Director Overview'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeaderWidget(name: 'Welcome, Sarah Jenkins!'),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildPerformanceAndAlertsRow(context),
            const SizedBox(height: 24),
            _buildActivityAndSatisfactionRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return PrimeCareResponsiveKpiGrid(
 children: [
         const SizedBox(child: PrimeCareStatCard(
                title: 'Active Trainees',
                value: '12,850',
                delta: 5.2,
                icon: Icons.people_outline,
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Franchise Compliance',
                value: '94.1%',
                delta: 2.8,
                icon: Icons.verified,
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Courses Completed',
                value: '6,782',
                deltaSuffix: 'This Month',
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Average Quiz Score',
                value: '88.6%',
                delta: null,
                icon: Icons.analytics,
            ),
         ),
      ],
    );
  }

  Widget _buildPerformanceAndAlertsRow(BuildContext context) {
    return SizedBox(
      height: 340,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Franchise Training Performance
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Text('Franchise Training Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.more_horiz, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 24),
                  SizedBox(child: PrimeCareResponsiveKpiGrid(
 children: [
                          SizedBox(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                         Text('Monthly Completion Rates & Compliance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                         Icon(Icons.info_outline, size: 16, color: Colors.grey),
                                      ]
                                   ),
                                   const SizedBox(height: 16),
                                   const SizedBox(child: ServerLoadGraph(), // Multi-line aesthetic proxy
                                   )
                                ]
                             ),
                          ),
                          const SizedBox(width: 24),
                          SizedBox(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                         Text('Completion by Franchisee', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                         Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                      ]
                                   ),
                                   const SizedBox(height: 16),
                                   SizedBox(child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                         children: [
                                            _buildVerticalBar('NY', 0.8),
                                            _buildVerticalBar('CA', 0.65),
                                            _buildVerticalBar('TX', 0.95),
                                            _buildVerticalBar('FL', 0.55),
                                         ]
                                      )
                                   )
                                ]
                             )
                          ),
                       ],
                    )
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Alerts & Actions List
          SizedBox(child: Column(
              children: [
                SizedBox(child: PrimeCareCard(
                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: const [
                                  Text('Urgent Compliance Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Icon(Icons.more_vert, color: Colors.grey),
                               ]
                            ),
                            _buildAlertText('3 critical issues'),
                            _buildAlertText('3 critical issues'),
                         ]
                      )
                   )
                ),
                const SizedBox(height: 16),
                SizedBox(child: PrimeCareCard(
                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: const [
                                  Text('My Action Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Icon(Icons.more_vert, color: Colors.grey),
                               ]
                            ),
                            _buildActionItem('Review curriculum'),
                            _buildActionItem('Onboard new franchisees'),
                            _buildActionItem('Update protocols'),
                         ]
                      )
                   )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalBar(String label, double val) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(
              width: 24,
              height: 180 * val,
              decoration: BoxDecoration(color: Colors.teal.shade400, borderRadius: BorderRadius.circular(2)),
           ),
           const SizedBox(height: 8),
           Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ]
     );
  }

  Widget _buildAlertText(String text) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           const Icon(Icons.warning, color: Colors.red, size: 16),
           const SizedBox(width: 8),
           Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ]
     );
  }

  Widget _buildActionItem(String text) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           const Icon(Icons.check_circle_outline, color: Colors.grey, size: 16),
           const SizedBox(width: 8),
           Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ]
     );
  }

  Widget _buildActivityAndSatisfactionRow(BuildContext context) {
    return SizedBox(
      height: 280,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Recent Activity Feed
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                              Text('Recent Activity Feed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('Latest completions, course updates', style: TextStyle(color: Colors.grey, fontSize: 12)),
                           ]
                        ),
                        Icon(Icons.more_vert, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 24),
                  _buildActivityListTile(Icons.person, 'Sarah Jenkins', ' unboarted compeltions\n6 months ago'),
                  const Divider(height: 32),
                  _buildActivityListTile(Icons.calendar_today, 'Sarah Jenkins', ' an\'l course Trainings update\n6 months ago'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Trainee Satisfaction Feedback
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Text('Trainee Satisfaction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.more_vert, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 16),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const Icon(Icons.star_half, color: Colors.amber, size: 18),
                        const SizedBox(width: 8),
                        const Text('4.8/5', style: TextStyle(fontWeight: FontWeight.bold)),
                     ]
                  ),
                  const SizedBox(height: 16),
                  Container(
                     padding: const EdgeInsets.all(12),
                     decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                           Text('Feedback comments', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                           SizedBox(height: 4),
                           Text('Prevent your lovere-leainted empliiitior and noviirvachers andmore; and saingen comments.', style: TextStyle(fontSize: 11, color: Colors.black87)),
                        ]
                     )
                  ),
                  const SizedBox(height: 12),
                  Container(
                     padding: const EdgeInsets.all(12),
                     decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                     child: const Text('Digent team fiws', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityListTile(IconData icon, String boldText, String normalText) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
              child: Icon(icon, color: const Color(0xFF0F4C81), size: 18),
           ),
           const SizedBox(width: 16),
           SizedBox(child: RichText(
                 text: TextSpan(
                    style: const TextStyle(color: Colors.black87, fontSize: 13),
                    children: [
                       TextSpan(text: boldText, style: const TextStyle(fontWeight: FontWeight.bold)),
                       TextSpan(text: normalText),
                    ]
                 )
              )
           ),
           const Icon(Icons.chevron_right, color: Colors.grey),
        ]
     );
  }
}
