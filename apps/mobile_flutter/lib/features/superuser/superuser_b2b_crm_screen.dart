import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The Founder Workspace & B2B Pipeline (Phase 72)
/// This is the physical tool the Super Admin uses to "add his work".
/// It is a Kanban-style CRM tracking external Hospital relationships,
/// Lead Generation, and Franchise Development milestones.
class SuperuserB2BCrmScreen extends StatefulWidget {
  const SuperuserB2BCrmScreen({super.key});

  @override
  State<SuperuserB2BCrmScreen> createState() => _SuperuserB2BCrmScreenState();
}

class _SuperuserB2BCrmScreenState extends State<SuperuserB2BCrmScreen> {
  // Mocking the Prisma `HospitalTarget` data 
  final List<Map<String, dynamic>> _pipeline = [
    {'name': 'Toronto General Hospital', 'contact': 'Sarah J. (Discharge Planner)', 'status': 'Meeting Scheduled', 'value': '\$12,000/mo', 'color': Colors.amberAccent},
    {'name': 'Mount Sinai Clinic', 'contact': 'Dr. Alan Peterson', 'status': 'Prospecting', 'value': '\$8,500/mo', 'color': Colors.cyanAccent},
    {'name': 'North York Elders Care', 'contact': 'Lisa Wong', 'status': 'Active Partner', 'value': '\$45,000/mo', 'color': Colors.tealAccent},
  ];

  @override
  Widget build(BuildContext context) {
    // A highly professional, obsidian "Executive Desk" aesthetic
    return Scaffold(
      backgroundColor: const Color(0xFF141416),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141416),
        elevation: 0,
        title: Text('BUSINESS DEVELOPMENT CRM', style: GoogleFonts.firaCode(color: Colors.white, fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box, color: Colors.blueAccent, size: 28),
            onPressed: () {
              // Open modal to add new Hospital Target or Work Item
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text('Your Growth Pipeline', style: GoogleFonts.outfit(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Track hospital outreach, add physical meeting notes, and monitor the value of your referral networks.', 
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 15)),
            
            const SizedBox(height: 32),
            
            // KPI Summary Row
            Row(
              children: [
                _buildKpiCard('Total Active Value', '\$45,000', Colors.tealAccent),
                const SizedBox(width: 16),
                _buildKpiCard('Pending Pipeline', '\$20,500', Colors.amberAccent),
              ],
            ),

            const SizedBox(height: 32),
            Text('ACTIVE TARGETS', style: GoogleFonts.firaCode(color: Colors.grey[500], fontSize: 13, letterSpacing: 1.5)),
            const SizedBox(height: 16),

            // The Work List (Kanban List)
            Expanded(
              child: ListView.builder(
                itemCount: _pipeline.length,
                itemBuilder: (context, index) {
                  final target = _pipeline[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E22),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(target['name'], style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.person_outline, color: Colors.grey, size: 16),
                                const SizedBox(width: 6),
                                Text(target['contact'], style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (target['color'] as Color).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(target['status'], style: GoogleFonts.inter(color: target['color'], fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                            const SizedBox(height: 8),
                            Text(target['value'], style: GoogleFonts.firaCode(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Log New Work Update', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () {
          // Open sliding pane to add a physical update/note to a target
        },
      ),
    );
  }

  Widget _buildKpiCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13)),
            const SizedBox(height: 8),
            Text(value, style: GoogleFonts.outfit(color: color, fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
