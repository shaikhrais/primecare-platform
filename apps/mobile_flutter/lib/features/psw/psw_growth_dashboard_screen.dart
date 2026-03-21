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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Growth Profile', style: GoogleFonts.outfit(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The Elite Status Banner
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF3F3D56)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.indigo.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Row(
                children: [
                  const Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80, height: 80,
                        child: CircularProgressIndicator(value: 0.98, strokeWidth: 8, color: Colors.amberAccent, backgroundColor: Colors.white24),
                      ),
                      Text('98', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Elite Responder', style: GoogleFonts.outfit(color: Colors.amberAccent, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Your TrustScore ranks in the top 2% of the network. You have priority access to Surge Shifts.', 
                          style: GoogleFonts.inter(color: Colors.white70, fontSize: 13, height: 1.4)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 32),
            Text('Career Achievements', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Achievement Badges
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBadge(Icons.shield, 'Flawless EVV', '20 Shifts', Colors.teal),
                _buildBadge(Icons.local_fire_department, 'Crisis Averted', '12 Solved', Colors.deepOrange),
                _buildBadge(Icons.star, '5-Star Care', '8 Reviews', Colors.amber),
              ],
            ),

            const SizedBox(height: 48),
            Text('Next Milestone', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            // Promotion Progress
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Senior Caregiver', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('4 Shifts Away', style: TextStyle(color: Colors.indigo[400], fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.8,
                    minHeight: 12,
                    backgroundColor: Colors.grey[200],
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  const SizedBox(height: 16),
                  const Text('Complete 4 more shifts with zero unacknowledged incident reports to automatically bump your base rate by +1.05x.',
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
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, size: 36, color: color),
        ),
        const SizedBox(height: 12),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 13)),
      ],
    );
  }
}
