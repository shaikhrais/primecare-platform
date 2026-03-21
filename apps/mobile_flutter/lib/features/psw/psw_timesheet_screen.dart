import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import '../shared/layouts/master_detail_layout.dart';
import 'psw_timesheet_detail_screen.dart';

class PswTimesheetScreen extends StatefulWidget {
  const PswTimesheetScreen({super.key});

  @override
  State<PswTimesheetScreen> createState() => _PswTimesheetScreenState();
}

class _PswTimesheetScreenState extends State<PswTimesheetScreen> {
  Map<String, dynamic>? _selectedPeriod;

  final List<Map<String, dynamic>> _payPeriods = const [
    {'date': 'Oct 28', 'shifts': 2, 'hours': 10.5, 'earnings': 315.00, 'surge': true},
    {'date': 'Oct 27', 'shifts': 1, 'hours': 8.0, 'earnings': 200.00, 'surge': false},
    {'date': 'Oct 26', 'shifts': 3, 'hours': 12.0, 'earnings': 360.00, 'surge': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Payroll & Earnings', 
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: MasterDetailLayout(
        isDetailActive: _selectedPeriod != null,
        onBackToMaster: () => setState(() => _selectedPeriod = null),
        masterList: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
          child: Column(
            children: [
              // Month High-Level Aggregation
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [PrimeCareColors.radarDark, PrimeCareColors.slate800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 20, offset: Offset(0, 8))],
              ),
              child: Column(
                children: [
                   const Text('Est. October Payout', style: TextStyle(color: PrimeCareColors.slate400, fontSize: 16)),
                   const SizedBox(height: 8),
                   const Text('\$4,250.75', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: -1)),
                   const SizedBox(height: 24),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       _buildMetric('Hours', '142.5'),
                       Container(width: 1, height: 40, color: PrimeCareColors.slate700),
                       _buildMetric('Shifts', '22'),
                       Container(width: 1, height: 40, color: PrimeCareColors.slate700),
                       _buildMetric('Surge OT', '18h'),
                     ],
                   )
                ],
              ),
            ),

            const SizedBox(height: 32),
            
            // Interactive 30-Day Grid Space (Placeholder for GitHub UI)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: PrimeCareColors.slate200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Activity Heatmap', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: PrimeCareColors.radarDark)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(28, (index) {
                      final intensity = (index % 5 == 0) ? 0.8 : (index % 3 == 0) ? 0.4 : 0.1;
                      return Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: PrimeCareColors.emerald.withOpacity(intensity),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),

            const SizedBox(height: 32),
            
            // Level 1 Daily Rows -> Drills directly to Level 2
            ..._payPeriods.map((period) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    final isDesktop = MediaQuery.of(context).size.width >= 800;
                    if (isDesktop) {
                      setState(() => _selectedPeriod = period);
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PswTimesheetDetailScreen(date: period['date'], earnings: period['earnings'], surgeActive: period['surge']))
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: PrimeCareColors.slate200),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.receipt_long_rounded, color: Color(0xFF475569)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(period['date'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Text('${period['hours']} Hours • ${period['shifts']} Shifts', style: const TextStyle(color: PrimeCareColors.slate500, fontSize: 13)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('\$${period['earnings'].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: PrimeCareColors.radarDark)),
                            if (period['surge'])
                              const Text('Surge +1.5x', style: TextStyle(color: PrimeCareColors.emerald, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios_rounded, color: PrimeCareColors.slate300, size: 16),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()
          ],
        ),
        ),
        detailView: _selectedPeriod == null ? const SizedBox.shrink() : PswTimesheetDetailScreen(
          date: _selectedPeriod!['date'],
          earnings: _selectedPeriod!['earnings'],
          surgeActive: _selectedPeriod!['surge'],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: PrimeCareColors.slate500, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
