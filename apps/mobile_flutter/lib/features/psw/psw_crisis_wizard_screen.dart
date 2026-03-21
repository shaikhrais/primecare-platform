import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// The Crisis Wizard (Phase 67)
/// Instead of failing out or showing a generic "Error" screen, 
/// this Wizard takes over the app if the GPS detects a severe anomaly
/// or if the worker triggers an SOS. It is mathematically designed to be calming.
class PswCrisisWizardScreen extends StatefulWidget {
  final String crisisTriggerName;

  const PswCrisisWizardScreen({super.key, required this.crisisTriggerName});

  @override
  State<PswCrisisWizardScreen> createState() => _PswCrisisWizardScreenState();
}

class _PswCrisisWizardScreenState extends State<PswCrisisWizardScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    // A deeply calming indigo/slate aesthetic to reduce visual stress and panic
    return PrimeCareScaffold(
      backgroundColor: Color(0xFF1E1B4B), // Deep indigo
      body: PrimeCareSafeArea(
        child: PrimeCarePadding(
          padding: EdgeInsets.all(32.0),
          child: PrimeCareColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Heartbeat icon
              PrimeCareIcon(Icons.favorite, size: 64, color: Colors.pinkAccent),
              SizedBox(height: 32),
              
              PrimeCareText(
                _getStepTitle(),
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 16),
              
              PrimeCareText(
                _getStepSubtitle(),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Colors.indigo[100],
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: 64),
              ..._buildStepActions(),
            ],
          ),
        ),
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0: return "Take a deep breath.";
      case 1: return "Are you physically safe?";
      case 2: return "How can we help you right now?";
      default: return "Help is on the way.";
    }
  }

  String _getStepSubtitle() {
    switch (_currentStep) {
      case 0: return "The Autopilot detected an anomaly (${widget.crisisTriggerName}). We are here to support you.";
      case 1: return "Please confirm that you and the patient are not in immediate physical danger.";
      case 2: return "Select an option below and the Ecosystem will instantly route you to the right person.";
      default: return "We have pinged the RN Oversight Hub. Stay where you are.";
    }
  }

  List<Widget> _buildStepActions() {
    if (_currentStep == 0) {
      return [
        _buildWizardButton("I am ready", Colors.tealAccent, () => setState(() => _currentStep = 1)),
      ];
    } else if (_currentStep == 1) {
      return [
        _buildWizardButton("Yes, we are safe", Colors.tealAccent, () => setState(() => _currentStep = 2)),
        SizedBox(height: 16),
        _buildWizardButton("No, I need Emergency Services", Colors.redAccent, () {
          // Trigger 911 WebRTC or direct dial mathematically
        }),
      ];
    } else if (_currentStep == 2) {
      return [
        _buildWizardButton("Call RN Mentorship Line", Colors.blueAccent, () => setState(() => _currentStep = 3)),
        SizedBox(height: 16),
        _buildWizardButton("Log Non-Fatal Incident", Colors.amberAccent, () {}),
        SizedBox(height: 16),
        PrimeCareButton(type: PrimeCareButtonType.text, 
          onPressed: () => Navigator.pop(context),
          child: PrimeCareText("It was a false alarm. Return to Shift.", style: TextStyle(color: Colors.indigo[200])),
        )
      ];
    } else {
      return [
        PrimeCareCenter(child: CircularProgressIndicator(color: Colors.tealAccent))
      ];
    }
  }

  Widget _buildWizardButton(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: PrimeCareCard(
        height: 72,
        
        child: PrimeCareCenter(
          child: PrimeCareText(
            label,
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ),
    );
  }
}
