import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';

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
    {
      'name': 'Toronto General Hospital',
      'contact': 'Sarah J. (Discharge Planner)',
      'status': 'Meeting Scheduled',
      'value': '\$12,000/mo',
      'color': Colors.amberAccent,
    },
    {
      'name': 'Mount Sinai Clinic',
      'contact': 'Dr. Alan Peterson',
      'status': 'Prospecting',
      'value': '\$8,500/mo',
      'color': Colors.cyanAccent,
    },
    {
      'name': 'North York Elders Care',
      'contact': 'Lisa Wong',
      'status': 'Active Partner',
      'value': '\$45,000/mo',
      'color': Colors.tealAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // A highly professional, obsidian "Executive Desk" aesthetic
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.darkMatrixCard,

      body: PrimeCarePadding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            PrimeCareText(
              'Your Growth Pipeline',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            PrimeCareText(
              'Track hospital outreach, add physical meeting notes, and monitor the value of your referral networks.',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 15),
            ),

            SizedBox(height: 32),

            // KPI Summary Row
            PrimeCareRow(
              children: [
                _buildKpiCard(
                  'Total Active Value',
                  '\$45,000',
                  Colors.tealAccent,
                ),
                SizedBox(width: 16),
                _buildKpiCard(
                  'Pending Pipeline',
                  '\$20,500',
                  Colors.amberAccent,
                ),
              ],
            ),

            SizedBox(height: 32),
            PrimeCareText(
              'ACTIVE TARGETS',
              style: GoogleFonts.firaCode(
                color: Colors.grey[500],
                fontSize: 13,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 16),

            // The Work List (Kanban List)
            PrimeCareExpanded(
              child: ListView.builder(
                itemCount: _pipeline.length,
                itemBuilder: (context, index) {
                  final target = _pipeline[index];
                  return PrimeCareCard(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(24),

                    child: PrimeCareRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimeCareColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimeCareText(
                              target['name'],
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            PrimeCareRow(
                              children: [
                                PrimeCareIcon(
                                  Icons.person_outline,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                PrimeCareText(
                                  target['contact'],
                                  style: GoogleFonts.inter(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        PrimeCareColumn(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            PrimeCareCard(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),

                              child: PrimeCareText(
                                target['status'],
                                style: GoogleFonts.inter(
                                  color: target['color'],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            PrimeCareText(
                              target['value'],
                              style: GoogleFonts.firaCode(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        icon: PrimeCareIcon(Icons.add, color: Colors.white),
        label: PrimeCareText(
          'Log New Work Update',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          // Open sliding pane to add a physical update/note to a target
        },
      ),
    );
  }

  Widget _buildKpiCard(String label, String value, Color color) {
    return PrimeCareExpanded(
      child: PrimeCareCard(
        padding: EdgeInsets.all(20),

        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareText(
              label,
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
            ),
            SizedBox(height: 8),
            PrimeCareText(
              value,
              style: GoogleFonts.outfit(
                color: color,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
