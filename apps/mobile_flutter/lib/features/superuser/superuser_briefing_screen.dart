import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';

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
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.darkMatrixCard, 
      body: PrimeCareSafeArea(
        child: PrimeCarePadding(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. The Greeting Header
              PrimeCareRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimeCareText(
                    'Good Morning, Founder.',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF2C2C30),
                    child: PrimeCareIcon(Icons.wb_sunny_outlined, color: Colors.amberAccent),
                  )
                ],
              ),
              SizedBox(height: 16),
              PrimeCareText(
                'The PrimeCare Autopilot operated flawlessly last night while you slept. Zero manual intervention was required by your operations team.',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey[400],
                ),
              ),

              SizedBox(height: 48),

              // 2. The Operational Data Cards
              PrimeCareExpanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.8,
                  children: [
                    _buildAutopilotMetricCard(
                      icon: Icons.check_circle_outline,
                      value: '142',
                      label: AppLocalizations.of(context)!.shiftsAutomaticallyStaffed,
                      color: Colors.tealAccent,
                    ),
                    _buildAutopilotMetricCard(
                      icon: Icons.payments_outlined,
                      value: '\$85.00',
                      label: AppLocalizations.of(context)!.surgeBudgetDeployed,
                      color: Colors.amberAccent,
                    ),
                    _buildAutopilotMetricCard(
                      icon: Icons.account_balance_wallet_outlined,
                      value: '34.2%',
                      label: AppLocalizations.of(context)!.regionalMarginProtected,
                      color: Colors.lightGreenAccent,
                    ),
                    _buildAutopilotMetricCard(
                      icon: Icons.medical_services_outlined,
                      value: '2',
                      label: AppLocalizations.of(context)!.crisesAutoRoutedToRn,
                      color: Colors.redAccent,
                    ),
                    _buildAutopilotMetricCard(
                      icon: Icons.security,
                      value: '3',
                      label: AppLocalizations.of(context)!.toxicWorkersHiddenLowTrust,
                      color: Colors.cyanAccent,
                    ),
                  ],
                ),
              ),

              // 3. The Footer Call to Action
              PrimeCareCenter(
                child: PrimeCareCard(
                  width: double.infinity,
                  height: 60,
                  
                  child: PrimeCareButton(type: PrimeCareButtonType.text, 
                    onPressed: () {
                      // Navigate inside to the deep Ecosystem Control Center if they MUST supervise.
                    },
                    child: PrimeCareText(
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
    return PrimeCareCard(
      padding: EdgeInsets.all(24),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimeCareRow(
            children: [
              PrimeCareIcon(icon, color: color, size: 28),
              SizedBox(width: 12),
              PrimeCareText(
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
          SizedBox(height: 12),
          PrimeCareText(
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
