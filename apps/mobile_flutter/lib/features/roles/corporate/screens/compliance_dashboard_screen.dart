import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceDashboardScreen extends StatelessWidget {
  const ComplianceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Franchise Compliance Overview'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeaderWidget(name: 'Date: Oct 26, 2023 | 9:45 AM'),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildCompliancePerformanceRow(context),
            const SizedBox(height: 24),
            _buildActionItemsRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return PrimeCareResponsiveKpiGrid(
 children: [
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                           Text('Compliance Score', style: TextStyle(fontWeight: FontWeight.bold)),
                           Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                     ),
                     const SizedBox(height: 16),
                     Center(
                        child: SizedBox(
                           width: 80, height: 80, 
                           child: Stack(
                              alignment: Alignment.center,
                              children: [
                                 CircularProgressIndicator(value: 0.88, color: const Color(0xFF0F4C81), strokeWidth: 12, backgroundColor: Colors.grey.shade200),
                                 const Text('88%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ]
                           )
                        )
                     )
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Active Locations',
                value: '14/15',
                deltaSuffix: '93% Compliant',
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Upcoming Audits',
                value: '4',
                deltaSuffix: 'this week',
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Open Actions',
                value: '23',
                deltaSuffix: 'Items',
            ),
         ),
      ],
    );
  }

  Widget _buildCompliancePerformanceRow(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
 children: [
        // Left: Franchise Compliance Performance Grouped Bar Chart
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      const Text('Franchise Compliance Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      PrimeCareResponsiveKpiGrid(
 children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: [Container(width: 12, height: 2, color: const Color(0xFF0F4C81)), const SizedBox(width: 4), const Text('Target', style: TextStyle(fontSize: 12))])),
                            const SizedBox(width: 8),
                            const Icon(Icons.more_horiz, color: Colors.grey),
                         ]
                      ),
                   ]
                ),
                const SizedBox(height: 24),
                // Pseudo Grouped Bar Chart implementation using Row spacing
                SizedBox(child: Stack(
                     children: [
                        // Target Line
                        Positioned(
                           top: 40, left: 0, right: 0,
                           child: PrimeCareResponsiveKpiGrid(
 children: [
                                 SizedBox(child: Container(height: 1, color: Colors.grey.shade400)),
                                 const SizedBox(width: 4),
                                 const Text('Target', style: TextStyle(fontSize: 10, color: Colors.grey)),
                              ]
                           )
                        ),
                        // Bars
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                              _buildGroupedBar('Boston', 0.85, 0.78),
                              _buildGroupedBar('NY Central', 0.95, 0.88),
                              _buildGroupedBar('Chicago', 0.90, 0.82),
                              _buildGroupedBar('Austin', 0.98, 0.90),
                              _buildGroupedBar('More', 0.85, 0.75),
                           ]
                        )
                     ]
                  )
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Right: Audit Status and Findings
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: const [
                      Text('Audit Status & Findings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.more_horiz, color: Colors.grey),
                   ]
                ),
                const SizedBox(height: 16),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      SizedBox(
                         width: 100, height: 100,
                         child: Stack(
                            alignment: Alignment.center,
                            children: [
                               CircularProgressIndicator(value: 1.0, color: Colors.red.shade400, strokeWidth: 20),
                               CircularProgressIndicator(value: 0.85, color: Colors.teal.shade400, strokeWidth: 20),
                               CircularProgressIndicator(value: 0.65, color: const Color(0xFF0F4C81), strokeWidth: 20),
                            ]
                         )
                      ),
                      const SizedBox(width: 24),
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                            _buildLegendDot('Passed (65%)', const Color(0xFF0F4C81)),
                            const SizedBox(height: 8),
                            _buildLegendDot('Pending (20%)', Colors.teal.shade400),
                            const SizedBox(height: 8),
                            _buildLegendDot('Failed (15%)', Colors.red.shade400),
                         ]
                      )
                   ]
                ),
                const SizedBox(height: 24),
                const Text('Recent Findings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 12),
                _buildLegendDot('Boston Center | HIPAA Records Audit Findings', Colors.teal.shade400),
                const SizedBox(height: 6),
                _buildLegendDot('Pending Require | Defined Items Audit Findings', Colors.amber),
                const SizedBox(height: 6),
                _buildLegendDot('Action Required | Friction Required Audit Findings', Colors.red.shade400),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupedBar(String label, double val1, double val2) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           PrimeCareResponsiveKpiGrid(
 children: [
                 Container(width: 24, height: 160 * val1, color: const Color(0xFF0F4C81)),
                 const SizedBox(width: 4),
                 Container(width: 24, height: 160 * val2, color: Colors.teal.shade400),
              ]
           ),
           const SizedBox(height: 8),
           Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ]
     );
  }

  Widget _buildLegendDot(String text, Color color) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
           const SizedBox(width: 8),
           Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ]
     );
  }

  Widget _buildActionItemsRow(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Recent Audits & Action Items Table
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Text('Recent Audits & Action Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.more_horiz, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 16),
                  SizedBox(child: PrimeCareDataTable<Map<String, dynamic>>(
                      columns: const ['Location', 'Audit Type', 'Date', 'Auditor', 'Score', 'Status', 'Actions'],
                      data: const [
                        {'loc': 'Boston Center', 'type': 'HIPAA', 'date': '10/21/23', 'aud': 'Dr. Lee', 'score': '92%', 'stat': 'Compliant', 'act': 'View Report'},
                        {'loc': 'NY North', 'type': 'OSHA', 'date': '10/19/23', 'aud': 'J. Smith', 'score': '85%', 'stat': 'Action Required', 'act': 'Resolve Now'},
                        {'loc': 'Boston Center', 'type': 'OSHA', 'date': '10/19/23', 'aud': 'J. Smith', 'score': '92%', 'stat': 'Compliant', 'act': 'View Report'},
                      ],
                      rowBuilder: (data) => [
                        DataCell(Text(data['loc']!)),
                        DataCell(Text(data['type']!)),
                        DataCell(Text(data['date']!)),
                        DataCell(Text(data['aud']!)),
                        DataCell(Text(data['score']!)),
                        DataCell(
                           Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: (data['stat'] == 'Compliant') ? Colors.teal.shade50 : Colors.red.shade50, borderRadius: BorderRadius.circular(4)),
                              child: Text(data['stat']!, style: TextStyle(color: (data['stat'] == 'Compliant') ? Colors.teal : Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                           )
                        ),
                        DataCell(
                           Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: (data['act'] == 'Resolve Now') ? Colors.teal : Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                              child: Text(data['act']!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: (data['act'] == 'Resolve Now') ? Colors.white : Colors.black87)),
                           )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Tasks
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Text('Tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.more_horiz, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 16),
                  _buildTaskTile(true, 'High-priority compliance steps', 'Oct 26, 2023 | 9:45 AM'),
                  const Divider(height: 24),
                  _buildTaskTile(false, 'Low priority compliance compltana', 'Oct 26, 2023 | 9:45 AM'),
                  const Divider(height: 24),
                  _buildTaskTile(false, 'High-priority both nood and compliance documents', 'Oct 26, 2023 | 9:45 AM'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskTile(bool isUrgent, String title, String date) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Icon(isUrgent ? Icons.error : Icons.circle_outlined, color: isUrgent ? Colors.red.shade400 : Colors.grey.shade300, size: 20),
           const SizedBox(width: 12),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                 ]
              )
           )
        ]
     );
  }
}
