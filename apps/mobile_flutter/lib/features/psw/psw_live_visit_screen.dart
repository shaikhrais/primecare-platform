import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'psw_shift_tasks_screen.dart';
import 'psw_clinical_notes_screen.dart';
import 'psw_evv_checkout_screen.dart';

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
        content: Text(_isCheckedIn ? 'Clocked In to Visit Successfully' : 'Clocked Out & Shift Closed'),
        backgroundColor: const Color(0xFF0F172A),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(label: 'UNDO', textColor: const Color(0xFF10B981), onPressed: () {
          HapticFeedback.mediumImpact();
          setState(() { _isCheckedIn = !_isCheckedIn; });
        }),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Live Telemetry',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Header Info
            Text(
              'Sarah Jenkins',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '10:00 AM - 2:00 PM',
              style: TextStyle(color: const Color(0xFF64748B), fontSize: 18, fontWeight: FontWeight.w600),
            ),
            
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Apple Watch Style Progress Ring
                    SizedBox(
                      width: 280,
                      height: 280,
                      child: CircularProgressIndicator(
                        value: _isCheckedIn ? null : 0.0, // Indeterminate when checked in
                        strokeWidth: 16,
                        backgroundColor: const Color(0xFFE2E8F0),
                        color: const Color(0xFF10B981),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    
                    // Outer Pulse Ring
                    if (_isCheckedIn)
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Container(
                            width: 280 + (_pulseController.value * 40),
                            height: 280 + (_pulseController.value * 40),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF10B981).withOpacity(0.3 - (_pulseController.value * 0.3)),
                                width: 2,
                              ),
                            ),
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
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isCheckedIn ? const Color(0xFF10B981) : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: _isCheckedIn ? const Color(0x4410B981) : const Color(0x0A000000),
                                blurRadius: _isCheckedIn ? 30 : 20,
                                offset: const Offset(0, 10),
                              )
                            ],
                            border: _isCheckedIn ? null : Border.all(color: const Color(0xFFE2E8F0), width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isCheckedIn ? Icons.stop_rounded : Icons.fingerprint,
                                size: 64,
                                color: _isCheckedIn ? Colors.white : const Color(0xFF0F172A),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _isCheckedIn ? 'CLOCK OUT' : 'CHECK IN',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                  color: _isCheckedIn ? Colors.white : const Color(0xFF0F172A),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PswShiftTasksScreen()));
                    },
                    icon: const Icon(Icons.format_list_bulleted_rounded, color: Color(0xFF0F172A)),
                    label: const Text('View Schedule Tasks', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PswClinicalNotesScreen()));
                    },
                    icon: const Icon(Icons.note_add_rounded, color: Color(0xFF0F172A)),
                    label: const Text('Add Clinical Progress Note', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PswEvvCheckoutScreen()));
                    },
                    icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
                    label: const Text('Initiate Shift Checkout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE11D48),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
