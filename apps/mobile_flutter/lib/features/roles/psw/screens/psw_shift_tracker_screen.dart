import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswShiftTrackerScreen extends StatefulWidget {
  const PswShiftTrackerScreen({super.key});

  @override
  State<PswShiftTrackerScreen> createState() => _PswShiftTrackerScreenState();
}

class _PswShiftTrackerScreenState extends State<PswShiftTrackerScreen> {
  String _shiftStatus = 'PENDING'; // PENDING, STARTED, COMPLETED

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shift EVV Tracker'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Current Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text('GPS Acquired: Lat 43.6532, Lng -79.3832', style: TextStyle(color: Colors.grey)),
                  const Text('Distance to Client: 45 meters', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),

                  if (_shiftStatus == 'PENDING') ...[
                    PrimeCareButton(
                      label: 'Check-In to Shift',
                      icon: Icons.login,
                      isFullWidth: true,
                      onPressed: () {
                        setState(() => _shiftStatus = 'STARTED');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shift Started securely via GPS.')));
                      },
                    ),
                  ] else if (_shiftStatus == 'STARTED') ...[
                    PrimeCareButton(
                      label: 'Check-Out of Shift',
                      icon: Icons.logout,
                      isFullWidth: true,
                      type: PrimeCareButtonType.secondary,
                      onPressed: () {
                        setState(() => _shiftStatus = 'COMPLETED');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shift Completed securely.')));
                        context.pop();
                      },
                    ),
                  ] else ...[
                    const PrimeStatusBadge(text: 'Shift Completed', color: Colors.blue),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
