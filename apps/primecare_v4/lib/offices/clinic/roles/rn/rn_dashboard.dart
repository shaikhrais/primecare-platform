import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../components/glass_surface.dart';

// Represents the functional dashboard for a Registered Nurse (RN)
class PlaceholderScreen extends ConsumerWidget {
  const PlaceholderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.transparent, // Inherit shell background
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                        'Registered Nurse Overview (Downtown Sector)',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF006565),
                        ),
                                           ),
                       ElevatedButton.icon(
                         onPressed: () {},
                         icon: const Icon(Icons.add_box),
                         label: const Text('Add Nursing Note'),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: const Color(0xFF006565),
                           foregroundColor: Colors.white,
                         ),
                       )
                     ],
                   ),
                  const SizedBox(height: 8),
                  Text(
                    'You are supervising 14 active care plans and have 2 critical updates.',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 32),
                  
                  // TOP METRICS ROW (Clinical)
                  Row(
                    children: [
                      Expanded(child: _buildGlassMetricCard(context, Icons.medical_services, 'Care Plans to Review', '3 Pending', Colors.blue)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildGlassMetricCard(context, Icons.medication, 'Medication Passes', '18 Scheduled', Colors.purple)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildGlassMetricCard(context, Icons.warning_amber, 'Incident Reports', '0 Active', Colors.green)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildGlassMetricCard(context, Icons.people_alt, 'Supervised PSWs', '6 Active', Colors.teal)),
                    ],
                  ),
                  
                  const SizedBox(height: 32),

                  // CLINICAL WORKFLOW & ALERTS
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT COLUMN: Triage & Clinical Schedule
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Urgent Triage & Alerts', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _buildTriageCard('Eleanor Rigby - Missed Morning Medication (8:00 AM)', context),
                            _buildTriageCard('John Smith - Elevated Blood Pressure Report filed by PSW', context),
                            
                            const SizedBox(height: 24),
                            Text('Today’s Clinical Schedule', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _buildShiftCard(context, '10:00 AM', 'Wound Care Assessment', 'Room 102 - Post-Op observation and dressing change.', true),
                            _buildShiftCard(context, '01:00 PM', 'IV Therapy Session', 'Room 304 - Hydration & Antibiotic protocol.', false),
                            _buildShiftCard(context, '03:15 PM', 'Initial Intake Assessment', 'Room 216 - Full systems check and care plan generation.', false),
                          ],
                        )
                      ),
                      
                      const SizedBox(width: 24),
                      
                      // RIGHT COLUMN: Quick Care Plan Access
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Recent Activity Logs', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            GlassSurface(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    _buildLogEntry('PSW Sarah checked out of John Smith\'s care. Vitals normal.'),
                                    const Divider(),
                                    _buildLogEntry('Vitals flagged: Martha Wayne Temp 38.2°C.'),
                                    const Divider(),
                                    _buildLogEntry('Pharmacy confirmed medication restock for Ward B.'),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.history),
                                        label: const Text('View Full Client History'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGlassMetricCard(BuildContext context, IconData icon, String label, String value, Color color) {
    return GlassSurface(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTriageCard(String alert, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        hasGhostBorder: false,
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: Colors.red.shade400, width: 4)),
            color: Colors.red.withOpacity(0.05),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Colors.red, size: 20),
              const SizedBox(width: 12),
              Expanded(child: Text(alert, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
              TextButton(onPressed: () {}, child: const Text('Review', style: TextStyle(color: Colors.red)))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShiftCard(BuildContext context, String time, String task, String details, bool isNext) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassSurface(
        hasGhostBorder: isNext,
        child: Container(
          decoration: BoxDecoration(
            border: isNext ? Border(left: BorderSide(color: const Color(0xFF006565), width: 4)) : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 90,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: isNext ? const Color(0xFF006565).withOpacity(0.1) : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isNext ? const Color(0xFF006565) : null), textAlign: TextAlign.center),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(details, style: const TextStyle(fontSize: 13, color: Colors.blueGrey)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.arrow_forward_ios, size: 16), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogEntry(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.sync_alt, color: Colors.blueGrey, size: 16),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4))),
        ],
      ),
    );
  }
}
