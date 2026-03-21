import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Supervisor Escalation Ticket (Phase 71)
/// Displayed natively in the General Manager / Superuser hubs.
/// When the Cloudflare Behavioral Engine fails to rehabilitate a user
/// via automated retraining modules, it generates this physical human ticket.
class SupervisorEscalationTicket extends StatelessWidget {
  final Map<String, dynamic> ticketData;

  const SupervisorEscalationTicket({super.key, required this.ticketData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.red[900]!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_rounded, color: Colors.redAccent, size: 24),
                  const SizedBox(width: 12),
                  Text('AI ESCALATION: SYSTEM REHABILITATION FAILED', 
                    style: GoogleFonts.firaCode(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(4)),
                child: Text('URGENT', style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 10)),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text('Worker: ${ticketData['workerName']} (ID: ${ticketData['workerId']})', 
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('The Embedded Mentor suspended this worker for missing 3 consecutive EVV geo-fences. The worker subsequently failed the mandatory retraining module 2 times. The AI has exhausted systemic correction parameters.', 
            style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 14, height: 1.5)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  child: const Text('INITIATE TERMINATION'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  child: const Text('OVERRIDE LOCKOUT'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
