import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PswLiveVisitScreen extends StatefulWidget {
  final String visitId;
  const PswLiveVisitScreen({super.key, required this.visitId});

  @override
  State<PswLiveVisitScreen> createState() => _PswLiveVisitScreenState();
}

class _PswLiveVisitScreenState extends State<PswLiveVisitScreen> {
  bool _isCheckedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Telemetry Protocol', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: _isCheckedIn ? const Color(0xFF10B981) : const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  Icon(_isCheckedIn ? Icons.gps_fixed : Icons.gps_off, size: 48, color: _isCheckedIn ? const Color(0xFF10B981) : const Color(0xFF64748B)),
                  const SizedBox(height: 16),
                  Text(
                    _isCheckedIn ? 'GPS Geofence Verified' : 'Awaiting Geofence Arrival',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isCheckedIn ? const Color(0xFF10B981) : const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Shift Anchor: ${widget.visitId}', style: const TextStyle(color: Color(0xFF94A3B8))),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                setState(() => _isCheckedIn = !_isCheckedIn);
              },
              icon: Icon(_isCheckedIn ? Icons.stop_circle : Icons.play_circle, color: Colors.white),
              label: Text(_isCheckedIn ? 'Clock Out & Handover' : 'Clock In Securely', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCheckedIn ? const Color(0xFFE11D48) : const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.note_add, color: Color(0xFF0EA5E9)),
              label: const Text('Add Clinical Progress Note', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0EA5E9))),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                side: const BorderSide(color: Color(0xFF0EA5E9)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
