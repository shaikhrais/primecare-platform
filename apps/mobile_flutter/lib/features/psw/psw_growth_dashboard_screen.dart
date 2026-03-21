import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// The Gamified Growth Dashboard (Phase 67)
/// Translates the backend Prisma `TrustScore` and `GamificationProfile`
/// into a beautiful consumer-facing UI that motivates Field Workers.
class PswGrowthDashboardScreen extends StatelessWidget {
  const PswGrowthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A vibrant, positive, energetic aesthetic
    return PrimeCareScaffold(
      backgroundColor: Colors.white,
      appBar: PrimeCareNavBar(
        title: PrimeCareText('My Growth Profile', style: GoogleFonts.outfit(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PrimeCareScrollWrapper(
        padding: const EdgeInsets.all(24.0),
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The Elite Status Banner
            PrimeCareCard(
              padding: const EdgeInsets.all(24),
              
              child: PrimeCareRow(
                children: [
                  const PrimeCareStack(
                    alignment: Alignment.center,
                    children: [
                      PrimeCareSizedBox(
                        width: 80, height: 80,
                        child: CircularProgressIndicator(value: 0.98, strokeWidth: 8, color: Colors.amberAccent, backgroundColor: Colors.white24),
                      ),
                      PrimeCareText('98', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const PrimeCareSizedBox(width: 24),
                  PrimeCareExpanded(
                    child: PrimeCareColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimeCareText('Elite Responder', style: GoogleFonts.outfit(color: Colors.amberAccent, fontSize: 24, fontWeight: FontWeight.bold)),
                        const PrimeCareSizedBox(height: 4),
                        PrimeCareText('Your TrustScore ranks in the top 2% of the network. You have priority access to Surge Shifts.', 
                          style: GoogleFonts.inter(color: Colors.white70, fontSize: 13, height: 1.4)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const PrimeCareSizedBox(height: 32),
            PrimeCareText('Career Achievements', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),

            // Achievement Badges
            PrimeCareRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBadge(Icons.shield, 'Flawless EVV', '20 Shifts', Colors.teal),
                _buildBadge(Icons.local_fire_department, 'Crisis Averted', '12 Solved', Colors.deepOrange),
                _buildBadge(Icons.star, '5-Star Care', '8 Reviews', Colors.amber),
              ],
            ),

            const PrimeCareSizedBox(height: 48),
            PrimeCareText('Next Milestone', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            
            // Promotion Progress
            PrimeCareCard(
              padding: const EdgeInsets.all(20),
              
              child: PrimeCareColumn(
                children: [
                  PrimeCareRow(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const PrimeCareText('Senior Caregiver', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      PrimeCareText('4 Shifts Away', style: TextStyle(color: Colors.indigo[400], fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const PrimeCareSizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.8,
                    minHeight: 12,
                    backgroundColor: Colors.grey[200],
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  const PrimeCareSizedBox(height: 16),
                  const PrimeCareText('Complete 4 more shifts with zero unacknowledged incident reports to automatically bump your base rate by +1.05x.',
                    style: TextStyle(color: Colors.black54, height: 1.5)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String title, String subtitle, Color color) {
    return PrimeCareColumn(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: color.withOpacity(0.1),
          child: PrimeCareIcon(icon, size: 36, color: color),
        ),
        const PrimeCareSizedBox(height: 12),
        PrimeCareText(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const PrimeCareSizedBox(height: 4),
        PrimeCareText(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 13)),
      ],
    );
  }
}
