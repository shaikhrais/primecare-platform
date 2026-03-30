import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/api_client.dart';

final clientMetricsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  return await apiClient.get('/v1/client/dashboard/metrics');
});

class ClientSideDashboardScreen extends ConsumerWidget {
  const ClientSideDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(clientMetricsProvider);

    return PageTemplate(
      title: 'My Care Dashboard',
      subtitle: 'Welcome back, Robert S.',
      kpiCards: null, // Custom flex grid bypasses the layout constraints
      children: [
        metricsAsync.when(
          data: (data) => _buildDashboardGrid(context, data),
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
          error: (err, stack) => Center(child: Text('Error loading dashboard: $err', style: const TextStyle(color: Colors.red))),
        ),
      ],
    );
  }

  Widget _buildDashboardGrid(BuildContext context, Map<String, dynamic> data) {
    // 900px breakpoint for PC layout expansion
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Emergency SOS, Today's Visitor, Daily Health Survey
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: isDesktop ? 1 : 0, child: _buildEmergencySnsCard()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: isDesktop ? 2 : 0, child: _buildCaregiverVisitCard()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: isDesktop ? 2 : 0, child: _buildDailyWellnessSurvey()),
          ],
        ),
        const SizedBox(height: 16),
        // Bottom Row: Chart (Vitals), Messages, Medication Reminders
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildVitalsTracker()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: 1, child: _buildInboxMini()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: 1, child: _buildMedicationReminders()),
          ],
        ),
      ],
    );
  }

  Widget _buildEmergencySnsCard() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const SizedBox(height: 8),
           const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 48),
           const SizedBox(height: 16),
           const Text('Emergency Call', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
           const SizedBox(height: 8),
           const Text('Instantly dispatch rapid response nurse or connect to 911.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
           const SizedBox(height: 16),
           ElevatedButton(
             onPressed: () {},
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.redAccent,
               minimumSize: const Size(double.infinity, 50),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
             ),
             child: const Text('SOS DISPATCH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
           ),
           const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildCaregiverVisitCard() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Upcoming Visit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Chip(label: const Text('Today', style: TextStyle(fontSize: 12)), backgroundColor: Colors.teal.shade50),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text('Sarah Jenkins', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                   const Text('Primary Support Worker (PSW)', style: TextStyle(fontSize: 14, color: Colors.grey)),
                   Row(
                      children: const [
                         Icon(Icons.star, color: Colors.amber, size: 14),
                         Icon(Icons.star, color: Colors.amber, size: 14),
                         Icon(Icons.star, color: Colors.amber, size: 14),
                         Icon(Icons.star, color: Colors.amber, size: 14),
                         Icon(Icons.star_half, color: Colors.amber, size: 14),
                         SizedBox(width: 4),
                         Text('4.8/5.0', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                   )
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                     Text('Arrival Window', style: TextStyle(fontSize: 12, color: Colors.grey)),
                     Text('1:00 PM - 3:30 PM', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
               ),
               ElevatedButton.icon(
                 onPressed: () {},
                 icon: const Icon(Icons.chat_bubble_outline, size: 18),
                 label: const Text('Direct Message'),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.grey.shade100,
                   foregroundColor: Colors.black87,
                   elevation: 0,
                 ),
               )
             ],
          )
        ],
      ),
    );
  }

  Widget _buildDailyWellnessSurvey() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daily Check-In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('How are you feeling today physically?', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               _wellnessEmoji(Icons.sentiment_very_dissatisfied, Colors.redAccent, 'Poor'),
               _wellnessEmoji(Icons.sentiment_dissatisfied, Colors.orangeAccent, 'Okay'),
               _wellnessEmoji(Icons.sentiment_neutral, Colors.amber, 'Neutral'),
               _wellnessEmoji(Icons.sentiment_satisfied, Colors.lightGreen, 'Good'),
               _wellnessEmoji(Icons.sentiment_very_satisfied, Colors.green, 'Great', selected: true),
             ],
          ),
          const SizedBox(height: 24),
          OutlinedButton(
             onPressed: () {},
             style: OutlinedButton.styleFrom(
               minimumSize: const Size(double.infinity, 45),
               side: const BorderSide(color: Colors.teal),
             ),
             child: const Text('Submit Full Health Survey (2 mins)', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _wellnessEmoji(IconData icon, Color color, String label, {bool selected = false}) {
     return Column(
        children: [
           CircleAvatar(
              radius: selected ? 24 : 20,
              backgroundColor: selected ? color.withOpacity(0.2) : Colors.transparent,
              child: Icon(icon, color: color, size: selected ? 32 : 28),
           ),
           const SizedBox(height: 4),
           Text(label, style: TextStyle(fontSize: 11, fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ? color : Colors.grey)),
        ],
     );
  }

  Widget _buildVitalsTracker() {
      return PrimeCareCard(
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     const Text('Blood Pressure Trends', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                     const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                  ],
               ),
               const SizedBox(height: 8),
               const Text('Weekly Sys/Dia Measurement Log', style: TextStyle(fontSize: 12, color: Colors.grey)),
               const SizedBox(height: 16),
               SizedBox(
                  height: 150,
                  child: LineChart(
                     LineChartData(
                        gridData: const FlGridData(show: true, drawVerticalLine: false),
                        titlesData: const FlTitlesData(
                           bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
                           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28)),
                           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                           LineChartBarData(
                              spots: const [FlSpot(1, 120), FlSpot(2, 118), FlSpot(3, 122), FlSpot(4, 119), FlSpot(5, 121), FlSpot(6, 120), FlSpot(7, 118)],
                              isCurved: true,
                              color: Colors.redAccent,
                              barWidth: 3,
                              dotData: const FlDotData(show: true),
                           ),
                           LineChartBarData(
                              spots: const [FlSpot(1, 80), FlSpot(2, 78), FlSpot(3, 79), FlSpot(4, 82), FlSpot(5, 80), FlSpot(6, 81), FlSpot(7, 79)],
                              isCurved: true,
                              color: Colors.blueAccent,
                              barWidth: 3,
                              dotData: const FlDotData(show: true),
                           )
                        ],
                     ),
                  ),
               )
            ],
         )
      );
  }

  Widget _buildInboxMini() {
      return PrimeCareCard(
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Text('Recent Messages', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
               const SizedBox(height: 16),
               _messageTile('Coordination Team', 'Your schedule has been updated...', '10m ago'),
               const Divider(),
               _messageTile('Dr. Alistair', 'Bloodwork results look stable.', 'Yesterday'),
               const Divider(),
               _messageTile('Billing Dept', 'Invoice #1042 generated.', 'Mon'),
            ]
         )
      );
  }

  Widget _messageTile(String sender, String snippet, String time) {
      return Padding(
         padding: const EdgeInsets.symmetric(vertical: 4.0),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(sender, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                     Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
               ),
               const SizedBox(height: 4),
               Text(snippet, style: const TextStyle(color: Colors.grey, fontSize: 12), overflow: TextOverflow.ellipsis),
            ],
         ),
      );
  }

  Widget _buildMedicationReminders() {
      return PrimeCareCard(
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Text('Medications', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
               const SizedBox(height: 16),
               _medTile('Lisinopril 10mg', '8:00 AM (With Food)', true),
               _medTile('Metformin 500mg', '12:00 PM', false),
               _medTile('Atorvastatin 20mg', '8:00 PM', false),
            ]
         )
      );
  }

  Widget _medTile(String medName, String time, bool isTaken) {
     return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(border: Border(left: BorderSide(color: isTaken ? Colors.green : Colors.orangeAccent, width: 3))),
        padding: const EdgeInsets.only(left: 8),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(medName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, decoration: isTaken ? TextDecoration.lineThrough : null)),
                    Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                 ],
              ),
              if (isTaken)
                 const Icon(Icons.check_circle, color: Colors.green, size: 18)
              else
                 const Icon(Icons.circle_outlined, color: Colors.orangeAccent, size: 18)
           ],
        ),
     );
  }
}
