import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'psw_shift_tasks_screen.dart';
import 'psw_clinical_notes_screen.dart';
import 'psw_evv_checkout_screen.dart';
import 'psw_incident_wizard_screen.dart';
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
      duration: Duration(seconds: 2),
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
        duration: Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(label: AppLocalizations.of(context)!.undo, textColor: PrimeCareColors.emerald, onPressed: () {
          HapticFeedback.mediumImpact();
          setState(() { _isCheckedIn = !_isCheckedIn; });
        }),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      
      body: PrimeCareSafeArea(
        child: PrimeCareColumn(
          children: [
            SizedBox(height: 40),
            // Header Info
            PrimeCareText(
              'Sarah Jenkins',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
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
                    SizedBox(
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
                          return PrimeCareCard(width: 280 + (_pulseController.value * 40), height: 280 + (_pulseController.value * 40),child: const SizedBox.shrink(),
                            
                          );
                        },
                      ),

                    // Massive Thumb-Zone Haptic Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _toggleCheckIn,
                        splashColor: Color(0x33FFFFFF),
                        highlightColor: Color(0x11000000),
                        customBorder: CircleBorder(),
                        child: PrimeCareCard(
                          
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
                              SizedBox(height: 12),
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
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => PswShiftTasksScreen()));
                    },
                    icon: PrimeCareIcon(Icons.format_list_bulleted_rounded, color: PrimeCareColors.radarDark),
                    label: PrimeCareText('View Schedule Tasks', style: TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
                    
                  ),
                  SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => PswClinicalNotesScreen()));
                    },
                    icon: PrimeCareIcon(Icons.note_add_rounded, color: PrimeCareColors.radarDark),
                    label: PrimeCareText('Add Clinical Progress Note', style: TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
                    
                  ),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => PswEvvCheckoutScreen()));
                    },
                    icon: PrimeCareIcon(Icons.exit_to_app_rounded, color: Colors.white),
                    label: PrimeCareText('Initiate Shift Checkout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    
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
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => PswIncidentWizardScreen()));
        },
        backgroundColor: PrimeCareColors.rose,
        elevation: 8,
        icon: PrimeCareIcon(Icons.sos_rounded, color: Colors.white, size: 28),
        label: PrimeCareText('EMERGENCY SOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ),
    );
  }
}
