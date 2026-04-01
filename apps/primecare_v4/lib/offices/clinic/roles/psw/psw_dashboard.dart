import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../components/glass_surface.dart';
import '../../../../services/auth_service.dart';

// Represents the functional dashboard for a Personal Support Worker (PSW)
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
                   Text(
                    'Welcome back, Sarah (PSW)',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF006565),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You have 4 clients scheduled today in the Downtown Zone.',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 32),
                  
                  // TOP METRICS ROW
                  Row(
                    children: [
                      Expanded(child: _buildGlassMetricCard(context, Icons.schedule, 'Next Visit In', '45 Mins', Colors.orange)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildGlassMetricCard(context, Icons.check_circle_outline, 'Completed ADLs', '12 / 18', Colors.green)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildGlassMetricCard(context, Icons.directions_walk, 'Active Shifts', '3 Remaining', Colors.blue)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GlassSurface(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF006565).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.qr_code_scanner, size: 32, color: Color(0xFF006565)),
                                  SizedBox(height: 8),
                                  Text('Fast Check-In', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF006565))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),

                  // ACTIVE SCHEDULE & CARE TASKS
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT COLUMN: Schedule
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Today’s Shifts', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _buildShiftCard(context, '09:00 AM - 11:30 AM', 'Eleanor Rigby', 'Bathing Assist, Mobility, Check Vitals', true),
                            _buildShiftCard(context, '12:00 PM - 02:00 PM', 'John Smith', 'Meal Prep, Light Housekeeping', false),
                            _buildShiftCard(context, '02:30 PM - 04:30 PM', 'Martha Wayne', 'Medication Reminders, Companionship', false),
                          ],
                        )
                      ),
                      
                      const SizedBox(width: 24),
                      
                      // RIGHT COLUMN: Quick ADL Logging
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pending Care Tasks', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            GlassSurface(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    _buildAdlCheckbox('Morning Meds (Eleanor)'),
                                    _buildAdlCheckbox('Ambulation / Walk'),
                                    _buildAdlCheckbox('Skin Integrity Check'),
                                    const Divider(height: 32),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add_task),
                                        label: const Text('Log Daily Notes'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF006565),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 16)
                                        ),
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
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftCard(BuildContext context, String time, String patient, String duties, bool isNext) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassSurface(
        hasGhostBorder: isNext,
        child: Container(
          decoration: BoxDecoration(
            border: isNext ? Border(left: BorderSide(color: Colors.orange.shade400, width: 4)) : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 100,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isNext ? Colors.orange.withOpacity(0.1) : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isNext ? Colors.orange.shade800 : null), textAlign: TextAlign.center),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patient, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(duties, style: const TextStyle(fontSize: 13, color: Colors.blueGrey)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdlCheckbox(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.radio_button_unchecked, color: Colors.blueGrey, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
