import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CtoDashboardScreen extends StatelessWidget {
  const CtoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Welcome, Dr. Aris Thorne (CTO)'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildSystemHealthRow(context),
            const SizedBox(height: 24),
            _buildTechnicalIntegrationsRow(context),
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
                title: 'Franchise Growth',
                value: '112',
                delta: 15.0,
                icon: Icons.store_mall_directory,
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: Container(
               padding: const EdgeInsets.all(24),
               decoration: BoxDecoration(
                  color: Colors.teal, // Special inverted theme from image
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
               ),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                           Text('System Uptime', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                           Icon(Icons.access_time, color: Colors.white70, size: 20),
                        ]
                     ),
                     const SizedBox(height: 16),
                     const Text('99.98%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                     const SizedBox(height: 24),
                     PrimeCareResponsiveKpiGrid(
 children: const [
                           Text('Chart', style: TextStyle(color: Colors.white70)),
                           SizedBox(width: 4),
                           Icon(Icons.arrow_outward, color: Colors.white70, size: 14),
                        ]
                     )
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Daily Telehealth Sessions',
                value: '4.2k',
                delta: 8.0,
                icon: Icons.video_camera_front,
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Active Users',
                value: '1.5m',
                delta: 12.0,
                icon: Icons.group,
            ),
         ),
      ],
    );
  }

  Widget _buildSystemHealthRow(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
 children: [
        // Left: Franchise System Health Map
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: const [
                      Text('Franchise System Health', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.more_horiz, color: Colors.grey),
                   ]
                ),
                const SizedBox(height: 24),
                PrimeCareResponsiveKpiGrid(
 children: [
                      // Map View
                      SizedBox(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               const Text('Network Status Map', style: TextStyle(fontSize: 13, color: Colors.black87)),
                               const SizedBox(height: 16),
                               Container(
                                  height: 240,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                      image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                                      fit: BoxFit.contain,
                                      opacity: 0.25,
                                    )
                                  ),
                                  child: const Icon(Icons.location_on, size: 48, color: Color(0xFF0F4C81)),
                               )
                            ]
                         )
                      ),
                      const SizedBox(width: 24),
                      // Performance Indicators
                      SizedBox(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               const Text('Performance Indicators', style: TextStyle(fontSize: 13, color: Colors.black87)),
                               const SizedBox(height: 24),
                               _buildRadialIndicator(Icons.memory, 'CPU', '42%', 0.42),
                               const SizedBox(height: 24),
                               _buildRadialIndicator(Icons.storage, 'Mem', '65%', 0.65),
                               const SizedBox(height: 24),
                               _buildRadialIndicator(Icons.speed, 'API Latency', '120ms', 0.12), // small visual bar
                            ]
                         )
                      ),
                   ]
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Right: Key Performance Data
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: const [
                      Text('Key Performance Data (Q4)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.more_horiz, color: Colors.grey),
                   ]
                ),
                const SizedBox(height: 16),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      Container(width: 8, height: 8, decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(4))),
                      const SizedBox(width: 8),
                      const Text('Telehealth Adoption', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(width: 8),
                      const Text('EHR Efficiency', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                   ]
                ),
                const SizedBox(height: 24),
                SizedBox(child: Container(
                     padding: const EdgeInsets.only(bottom: 16),
                     child: const ServerLoadGraph(), // Smooth line chart visualization
                  )
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadialIndicator(IconData icon, String label, String value, double percentage) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           SizedBox(
              width: 48, height: 48,
              child: Stack(
                 alignment: Alignment.center,
                 children: [
                    CircularProgressIndicator(value: percentage, strokeWidth: 4, color: const Color(0xFF0F4C81), backgroundColor: Colors.grey.shade200),
                    Icon(icon, size: 20, color: const Color(0xFF0F4C81)),
                 ],
              )
           ),
           const SizedBox(width: 16),
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                 Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ]
           )
        ]
     );
  }

  Widget _buildTechnicalIntegrationsRow(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
 children: [
        // Security Overview
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Security Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                _buildSecurityRow('Vulnerability Status:', 'Low', Colors.teal),
                const SizedBox(height: 8),
                _buildSecurityRow('Incidents:', '2', Colors.black),
                const SizedBox(height: 8),
                _buildSecurityRow('Audit Compliance:', '94%', Colors.teal),
                const SizedBox(height: 24),
                SizedBox(
                   height: 100, 
                   child: const PrimeCareBarChart(
                      data: {'J': 20, 'F': 10, 'M': 50, 'A': 30, 'M ': 80, 'J ': 50, 'J  ': 40, 'A ': 60, 'S': 90}, 
                      barColor: Colors.teal
                   )
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // EHR Implementation Progress
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('EHR Implementation Progress', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: const [
                      Text('Phase', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      Text('Phase 2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      Text('Phase', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                   ]
                ),
                const SizedBox(height: 24),
                _buildEHRProgress('Franchise', 0.9),
                const SizedBox(height: 16),
                _buildEHRProgress('Franchise 2', 0.7),
                const SizedBox(height: 16),
                _buildEHRProgress('Franchise 3', 0.8),
                const SizedBox(height: 16),
                _buildEHRProgress('Franchise 4', 0.5),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Tech Stack Performance
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tech Stack Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 24),
                _buildTechProgress('SaaS usage', '90%', 0.9),
                const SizedBox(height: 24),
                _buildTechProgress('Server load', '100%', 1.0),
                const SizedBox(height: 24),
                _buildTechProgress('API success rates', '94%', 0.94),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityRow(String label, String value, Color valueColor) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
           Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: valueColor)),
        ]
     );
  }

  Widget _buildEHRProgress(String label, double value) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
           const SizedBox(width: 16),
           SizedBox(child: PrimeCareProgressBar(progress: value, activeColor: const Color(0xFF0F4C81))),
        ]
     );
  }

  Widget _buildTechProgress(String label, String percentText, double value) {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                 Text(percentText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ]
           ),
           const SizedBox(height: 8),
           PrimeCareProgressBar(progress: value, activeColor: const Color(0xFF0F4C81)),
        ]
     );
  }
}
