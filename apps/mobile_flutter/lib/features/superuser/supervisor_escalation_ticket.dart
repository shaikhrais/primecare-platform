import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// Supervisor Escalation Ticket (Phase 71)
/// Displayed natively in the General Manager / Superuser hubs.
/// When the Cloudflare Behavioral Engine fails to rehabilitate a user
/// via automated retraining modules, it generates this physical human ticket.
class SupervisorEscalationTicket extends StatelessWidget {
  final Map<String, dynamic> ticketData;

  const SupervisorEscalationTicket({super.key, required this.ticketData});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(24),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimeCareRow(
                children: [
                  PrimeCareIcon(Icons.warning_rounded, color: Colors.redAccent, size: 24),
                  PrimeCareSizedBox(width: 12),
                  PrimeCareText('AI ESCALATION: SYSTEM REHABILITATION FAILED', 
                    style: GoogleFonts.firaCode(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              PrimeCareCard(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                
                child: PrimeCareText('URGENT', style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 10)),
              )
            ],
          ),
          PrimeCareSizedBox(height: 16),
          PrimeCareText('Worker: ${ticketData['workerName']} (ID: ${ticketData['workerId']})', 
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          PrimeCareSizedBox(height: 8),
          PrimeCareText('The Embedded Mentor suspended this worker for missing 3 consecutive EVV geo-fences. The worker subsequently failed the mandatory retraining module 2 times. The AI has exhausted systemic correction parameters.', 
            style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 14, height: 1.5)),
          PrimeCareSizedBox(height: 24),
          PrimeCareRow(
            children: [
              PrimeCareExpanded(
                child: PrimeCareButton(type: PrimeCareButtonType.primary, 
                  
                  onPressed: () {},
                  child: PrimeCareText(AppLocalizations.of(context)!.initiateTermination),
                ),
              ),
              PrimeCareSizedBox(width: 16),
              PrimeCareExpanded(
                child: PrimeCareButton(type: PrimeCareButtonType.secondary, 
                  
                  onPressed: () {},
                  child: PrimeCareText(AppLocalizations.of(context)!.overrideLockout),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
