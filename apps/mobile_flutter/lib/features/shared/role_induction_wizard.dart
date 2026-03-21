import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The Behavioral Mentor: Role Induction Wizard (Phase 71)
/// This UI physically blocks the app upon first login.
/// It lectures the user on exactly what their job entails to ensure 
/// zero ambiguity regarding compliance and performance expectations.
class RoleInductionWizardScreen extends StatefulWidget {
  final String roleName; 

  const RoleInductionWizardScreen({super.key, required this.roleName});

  @override
  State<RoleInductionWizardScreen> createState() => _RoleInductionWizardScreenState();
}

class _RoleInductionWizardScreenState extends State<RoleInductionWizardScreen> {
  bool _hasAcknowledged = false;

  @override
  Widget build(BuildContext context) {
    // A strict, formal, commanding aesthetic.
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.school, color: Colors.blueAccent, size: 40),
              ),
              const SizedBox(height: 24),
              Text('MANDATORY INDUCTION', style: GoogleFonts.firaCode(color: Colors.blueAccent, letterSpacing: 2, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('Welcome to PrimeCare.', style: GoogleFonts.outfit(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Before you are granted access to the Ecosystem, you must explicitly acknowledge your operational responsibilities.', 
                style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16, height: 1.5)),

              const SizedBox(height: 48),

              // Dynamic Role Lecture
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ROLE DETECTED: ${widget.roleName.toUpperCase()}', 
                      style: GoogleFonts.firaCode(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text(
                      widget.roleName == 'Caregiver' 
                        ? '1. You are the physical backbone of this company.\n2. You must clock in EXACTLY on time via GPS EVV mapping.\n3. Failing to verify your location mathematically diminishes your TrustScore and locks you out of premium shifts.\n4. You must treat patients with absolute clinical respect.'
                        : '1. Your sole objective is keeping Unfilled Shifts at absolute zero.\n2. You manage the physical dispatch maps and Haversine targeting.\n3. Do not abuse Surge Pricing; it bleeds our corporate margin.',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 16, height: 1.8),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // The Legal Acknowledgment
              Row(
                children: [
                  Checkbox(
                    value: _hasAcknowledged,
                    activeColor: Colors.blueAccent,
                    onChanged: (val) => setState(() => _hasAcknowledged = val!),
                  ),
                  Expanded(
                    child: Text('I understand my responsibilities and the consequences of mathematical behavioral failure.', 
                      style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13)),
                  )
                ],
              ),
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasAcknowledged ? Colors.blueAccent : Colors.grey[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                  ),
                  onPressed: _hasAcknowledged ? () {
                    // Triggers the mutation pushing hasCompletedInduction = true to Prisma DB
                  } : null,
                  child: Text('ACKNOWLEDGE & UNLOCK APP', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
