import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:google_fonts/google_fonts.dart';

/// Day-One Diagnostic Radar (Phase 70)
/// This is the physically generated Business Advisor.
/// Instead of a blank canvas, it explicitly tells the Founder what to do next
/// based on mathematical evaluations pulled from the Cloudflare Edge API.
class SuperuserDiagnosticRadarScreen extends StatelessWidget {
  const SuperuserDiagnosticRadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dark terminal aesthetic emphasizing analytical logic and structure
    return Scaffold(
      backgroundColor: PrimeCareColors.radarDark, 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SYSTEM DIAGNOSTIC RADAR', 
                style: GoogleFonts.firaCode(color: Colors.cyanAccent, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 12),
              Text('Business Health Analysis', 
                style: GoogleFonts.outfit(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('Evaluating millions of database rows mathematically to isolate your weakest corporate link.', 
                style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16)),
                
              const SizedBox(height: 48),

              // The Direct Advisor Output
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.cyan[900]!.withOpacity(0.4), Colors.blue[900]!.withOpacity(0.4)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.psychology, color: Colors.cyanAccent, size: 32),
                        const SizedBox(width: 16),
                        Text('AI ADVISOR: NEXT RECOMMENDED MOVE', 
                          style: GoogleFonts.inter(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.5)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('System recommends engaging [Autopilot Margin Freeze] on Franchise Alpha immediately to halt systemic cash bleed.', 
                      style: GoogleFonts.outfit(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600, height: 1.3)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(200, 50),
                        textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15)
                      ),
                      onPressed: () {},
                      child: const Text('EXECUTE MACRO OVERRIDE'),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 48),
              
              // The 4 Vectors Grid
              Text('THE 4 VECTORS', style: GoogleFonts.firaCode(color: Colors.grey[500], fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                   return Wrap(
                     spacing: 24,
                     runSpacing: 24,
                     children: [
                       _buildVectorCard('FINANCIAL HEALTH', 'CRITICAL BLEED', 'EBITDA margin for Franchise Alpha is bleeding 14% below target due to excessive Surge overrides by Coordinator 2.', Colors.redAccent, constraints.maxWidth),
                       _buildVectorCard('LOGISTICAL HEALTH', 'STABLE', '98% of active shifts mathematically matched within Haversine limits.', Colors.greenAccent, constraints.maxWidth),
                       _buildVectorCard('CLINICAL LIABILITY', 'WARNING', '1 unresolved Patient Fall Incident currently unacknowledged by RN Oversight Hub.', Colors.orangeAccent, constraints.maxWidth),
                       _buildVectorCard('HOSPITAL B2B CRM', 'DEGRADING', 'Toronto General Hospital physical touchpoints dropped by 18% in the last 45 days.', Colors.orangeAccent, constraints.maxWidth),
                     ],
                   );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVectorCard(String title, String status, String description, Color statusColor, double parentWidth) {
    // Responsive grid math
    double cardWidth = (parentWidth - 24) / 2;
    if (parentWidth < 800) cardWidth = parentWidth; // Stack on narrow screens

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PrimeCareColors.slate800,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.firaCode(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                child: Text(status, style: GoogleFonts.outfit(color: statusColor, fontWeight: FontWeight.bold, fontSize: 13)),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(description, style: GoogleFonts.inter(color: Colors.white, fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }
}
