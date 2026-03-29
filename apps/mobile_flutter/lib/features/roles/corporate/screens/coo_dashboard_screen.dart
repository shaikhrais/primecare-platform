import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CooDashboardScreen extends StatelessWidget {
  const CooDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'COO Operations Overview'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeaderWidget(name: 'Sarah Jensen | COO'),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildNetworkPerformanceRow(context),
            const SizedBox(height: 24),
            _buildOperationsMetricsRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return const Row(
      children: [
         Expanded(
            child: PrimeCareStatCard(
                title: 'Total Locations',
                value: '28 Franchises',
                delta: 2.0,
                icon: Icons.domain,
            ),
         ),
         SizedBox(width: 16),
         Expanded(
            child: PrimeCareStatCard(
                title: 'Revenue YTD',
                value: '\$3.4M',
                delta: 12.0,
                icon: Icons.trending_up,
            ),
         ),
         SizedBox(width: 16),
         Expanded(
            child: PrimeCareStatCard(
                title: 'Staff Utilization',
                value: '89%',
                delta: 3.0,
                icon: Icons.people_outline,
            ),
         ),
         SizedBox(width: 16),
         Expanded(
            child: PrimeCareStatCard(
                title: 'Patient Satisfaction',
                value: '4.7/5.0',
                delta: 4.5,
                icon: Icons.star,
            ),
         ),
      ],
    );
  }

  Widget _buildNetworkPerformanceRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Franchise Network Performance
        Expanded(
          flex: 2,
          child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      const Text('Franchise Network Performance (Revenue & Growth)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const Icon(Icons.more_horiz, color: Colors.grey),
                   ]
                ),
                const SizedBox(height: 16),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      Row(
                         children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(2))),
                            const SizedBox(width: 8),
                            const Text('Monthly Revenue per Franchise', style: TextStyle(fontSize: 12)),
                            const SizedBox(width: 16),
                            Container(width: 12, height: 2, color: Colors.teal.shade300),
                            const SizedBox(width: 8),
                            const Text('Patient Volume', style: TextStyle(fontSize: 12)),
                         ],
                      ),
                      Row(
                         children: [
                            const Text('Top:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(width: 8),
                            _buildPill('New York'),
                            const SizedBox(width: 6),
                            _buildPill('Boston'),
                            const SizedBox(width: 6),
                            _buildPill('Austin'),
                            const SizedBox(width: 6),
                            _buildPill('Denver'),
                         ],
                      ),
                   ],
                ),
                const SizedBox(height: 16),
                const Expanded(
                  child: PrimeCareBarChart(
                    data: {
                      'Jan': 310,
                      'Feb': 310,
                      'Mar': 390,
                      'Apr': 290,
                      'May': 370,
                      'Jun': 500,
                      'Jul': 470,
                      'Aug': 350,
                      'Sep': 440,
                      'Oct': 520,
                    },
                    barColor: Color(0xFF0F4C81),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Staffing Overview
        Expanded(
          flex: 1,
          child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Staffing Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                const Text('Clinician Availability', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 12),
                SizedBox(
                   height: 100, 
                   child: const PrimeCareBarChart(
                      data: {'M': 60, 'T': 80, 'W': 100, 'Th': 70, 'F': 120, 'Sa': 90, 'Su': 140},
                      barColor: Colors.teal,
                      height: 100,
                   )
                ),
                const SizedBox(height: 8),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: const [
                      Text('Staff Count', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text('18', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                   ]
                ),
                const SizedBox(height: 24),
                const Text('Nurse/Physician Ratios', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 16),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                      SizedBox(
                         width: 60, height: 60, 
                         child: CircularProgressIndicator(value: 0.60, color: const Color(0xFF0F4C81), strokeWidth: 12, backgroundColor: Colors.grey.shade200)
                      ),
                      SizedBox(
                         width: 60, height: 60, 
                         child: CircularProgressIndicator(value: 0.40, color: Colors.teal, strokeWidth: 12, backgroundColor: Colors.grey.shade200)
                      ),
                   ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPill(String text) {
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
        child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
     );
  }

  Widget _buildOperationsMetricsRow(BuildContext context) {
    return SizedBox(
      height: 300, 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Operations Metrics
          Expanded(
            flex: 2,
            child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        const Text('Operations Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const Icon(Icons.more_horiz, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 24),
                  Row(
                     children: [
                        Expanded(
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 const Text('Average Wait Time', style: TextStyle(fontSize: 13, color: Colors.black87)),
                                 const SizedBox(height: 4),
                                 const Text('14m', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                 const SizedBox(height: 8),
                                 SizedBox(height: 50, child: const ServerLoadGraph()),
                              ],
                           )
                        ),
                        Container(width: 1, height: 120, color: Colors.grey.shade300),
                        const SizedBox(width: 16),
                        Expanded(
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                 Text('Appointment Efficiency', style: TextStyle(fontSize: 13, color: Colors.black87)),
                                 SizedBox(height: 4),
                                 Text('92%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                 SizedBox(height: 24),
                                 Text('Patient Accupancy', style: TextStyle(fontSize: 13, color: Colors.black87)),
                                 Text('--', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                           )
                        ),
                        Container(width: 1, height: 120, color: Colors.grey.shade300),
                        const SizedBox(width: 16),
                        Expanded(
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                 Text('Room Occupancy', style: TextStyle(fontSize: 13, color: Colors.black87)),
                                 SizedBox(height: 4),
                                 Text('81%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                 SizedBox(height: 24),
                                 Text('Patient Acquisition Rate', style: TextStyle(fontSize: 13, color: Colors.black87)),
                                 Text('--', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                           )
                        ),
                     ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Critical Alerts & Updates
          Expanded(
            flex: 1,
            child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Critical Alerts & Updates', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  _buildAlertTile(Icons.warning, Colors.red, 'Urgent', 'Boston Clinic-Nurse Shortage', true),
                  const SizedBox(height: 12),
                  _buildAlertTile(Icons.inventory, Colors.teal, 'Houston', 'Supply Delay', false),
                  const SizedBox(height: 12),
                  _buildAlertTile(Icons.person, Colors.teal, 'Dallas', 'New Manager', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertTile(IconData icon, Color color, String title, String subtitle, bool isUrgent) {
     return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
           color: isUrgent ? Colors.red.shade50 : Colors.grey.shade50,
           borderRadius: BorderRadius.circular(8),
           border: Border.all(color: isUrgent ? Colors.red.shade200 : Colors.grey.shade200),
        ),
        child: Row(
           children: [
              Container(
                 padding: const EdgeInsets.all(8),
                 decoration: BoxDecoration(color: isUrgent ? Colors.red.shade100 : Colors.teal.shade100, shape: BoxShape.circle),
                 child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isUrgent ? Colors.red.shade700 : Colors.black87)),
                       Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ]
                 ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
           ]
        ),
     );
  }
}
