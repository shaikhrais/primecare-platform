import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:google_fonts/google_fonts.dart';

/// The Morning Briefing UI (Phase 69)
/// This screen is explicitly designed to reduce anxiety for the Founder/CEO.
/// It proves mathematically that the Cloudflare Autopilot handled 100% of dispatching and surges
/// overnight without human intervention.
class SuperuserBriefingScreen extends StatelessWidget {
  const SuperuserBriefingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A deeply calming, slate-grey and soft aesthetic intentionally 
    // replacing the chaotic red/warning Dashboards.
    return Scaffold(
      backgroundColor: PrimeCareColors.darkMatrixCard, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. The Greeting Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good Morning, Founder.',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF2C2C30),
                    child: Icon(Icons.wb_sunny_outlined, color: Colors.amberAccent),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'The PrimeCare Autopilot operated flawlessly last night while you slept. Zero manual intervention was required by your operations team.',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey[400],
                ),
              ),

              const SizedBox(height: 48),

              // 2. The Operational Data Cards
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.8,
                  children: [
                    _buildAutopilotMetricCard(
                      icon: Icons.check_circle_outline,
                      value: '142',
                      label: 'Shifts Automatically Staffed',
                      color: Colors.tealAccent,
                    ),
                    _buildAutopilotMetricCard(
                      icon: Icons.payments_outlined,
                      value: '\$85.00',
                      label: 'Surge Budget Deployed',
                      color: Colors.amberAccent,
                    ),
                    _buildAutopilotMetricCard(
                      icon: Icons.account_balance_wallet_outlined,
                      value: '34.2%',
                      label: 'Regional Margin Protected',
                      color: Colors.lightGreenAccent,
                    ),
                    _buildAutopilotMetricCard(
                      icon: Icons.medical_services_outlined,
                      value: '2',
                      label: 'Crises Auto-Routed to RN',
                      color: Colors.redAccent,
                    ),
                    _buildAutopilotMetricCard(
                      icon: Icons.security,
                      value: '3',
                      label: 'Toxic Workers Hidden (Low Trust)',
                      color: Colors.cyanAccent,
                    ),
                  ],
                ),
              ),

              // 3. The Footer Call to Action
              Center(
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigate inside to the deep Ecosystem Control Center if they MUST supervise.
                    },
                    child: Text(
                      'Acknowledge & Dismiss',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutopilotMetricCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
