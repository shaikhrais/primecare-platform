import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'psw_shift_tasks_screen.dart';
import 'psw_clinical_notes_screen.dart';
import 'psw_evv_checkout_screen.dart';
import 'psw_incident_wizard_screen.dart';
import 'psw_evv_checkout_screen.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswLiveVisitScreen extends StatefulWidget {
  final String visitId;
  const PswLiveVisitScreen({super.key, required this.visitId});

  @override
  State<PswLiveVisitScreen> createState() => _PswLiveVisitScreenState();
}

class _PswLiveVisitScreenState extends State<PswLiveVisitScreen> with SingleTickerProviderStateMixin {
  bool _isCheckedIn = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleCheckIn() {
    HapticFeedback.heavyImpact();
    setState(() {
      _isCheckedIn = !_isCheckedIn;
    });

    // Native Snackbar Undo Pattern
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: PrimeCareText(_isCheckedIn ? 'Clocked In to Visit Successfully' : 'Clocked Out & Shift Closed'),
        backgroundColor: PrimeCareColors.radarDark,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(label: 'UNDO', textColor: PrimeCareColors.emerald, onPressed: () {
          HapticFeedback.mediumImpact();
          setState(() { _isCheckedIn = !_isCheckedIn; });
        }),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: PrimeCareText(
          'Live Telemetry',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: PrimeCareSafeArea(
        child: PrimeCareColumn(
          children: [
            const PrimeCareSizedBox(height: 40),
            // Header Info
            PrimeCareText(
              'Sarah Jenkins',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const PrimeCareSizedBox(height: 8),
            PrimeCareText(
              '10:00 AM - 2:00 PM',
              style: TextStyle(color: PrimeCareColors.slate500, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            
            PrimeCareExpanded(
              child: PrimeCareCenter(
                child: PrimeCareStack(
                  alignment: Alignment.center,
                  children: [
                    // Apple Watch Style Progress Ring
                    PrimeCareSizedBox(
                      width: 280,
                      height: 280,
                      child: CircularProgressIndicator(
                        value: _isCheckedIn ? null : 0.0, // Indeterminate when checked in
                        strokeWidth: 16,
                        backgroundColor: PrimeCareColors.slate200,
                        color: PrimeCareColors.emerald,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    
                    // Outer Pulse Ring
                    if (_isCheckedIn)
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return PrimeCareCard(
                            width: 280 + (_pulseController.value * 40),
                            height: 280 + (_pulseController.value * 40),
                            
                          );
                        },
                      ),

                    // Massive Thumb-Zone Haptic Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _toggleCheckIn,
                        splashColor: const Color(0x33FFFFFF),
                        highlightColor: const Color(0x11000000),
                        customBorder: const CircleBorder(),
                        child: AnimatedPrimeCareCard(
                          duration: const Duration(milliseconds: 300),
                          width: 220,
                          height: 220,
                          
                          child: PrimeCareColumn(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimeCareIcon(
                                _isCheckedIn ? Icons.stop_rounded : Icons.fingerprint,
                                size: 64,
                                color: _isCheckedIn ? Colors.white : PrimeCareColors.radarDark,
                              ),
                              const PrimeCareSizedBox(height: 12),
                              PrimeCareText(
                                _isCheckedIn ? 'CLOCK OUT' : 'CHECK IN',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                  color: _isCheckedIn ? Colors.white : PrimeCareColors.radarDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Modals
            PrimeCarePadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PswShiftTasksScreen()));
                    },
                    icon: const PrimeCareIcon(Icons.format_list_bulleted_rounded, color: PrimeCareColors.radarDark),
                    label: const PrimeCareText('View Schedule Tasks', style: TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
                    
                  ),
                  const PrimeCareSizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PswClinicalNotesScreen()));
                    },
                    icon: const PrimeCareIcon(Icons.note_add_rounded, color: PrimeCareColors.radarDark),
                    label: const PrimeCareText('Add Clinical Progress Note', style: TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
                    
                  ),
                  const PrimeCareSizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PswEvvCheckoutScreen()));
                    },
                    icon: const PrimeCareIcon(Icons.exit_to_app_rounded, color: Colors.white),
                    label: const PrimeCareText('Initiate Shift Checkout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.heavyImpact();
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PswIncidentWizardScreen()));
        },
        backgroundColor: PrimeCareColors.rose,
        elevation: 8,
        icon: const PrimeCareIcon(Icons.sos_rounded, color: Colors.white, size: 28),
        label: const PrimeCareText('EMERGENCY SOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ),
    );
  }
}
