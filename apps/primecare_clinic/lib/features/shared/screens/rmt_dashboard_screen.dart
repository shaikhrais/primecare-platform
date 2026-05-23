// Governance - Category: view | Purpose: UI Screen component rendering the Rmt Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'dart:async';

class RmtDashboardScreen extends StatefulWidget {
  const RmtDashboardScreen({Key? key}) : super(key: key);

  @override
  State<RmtDashboardScreen> createState() => _RmtDashboardScreenState();
}

class _RmtDashboardScreenState extends State<RmtDashboardScreen> {
  bool _isActive = false;
  int _seconds = 0;
  Timer? _timer;

  void _toggleTimer() {
    if (_isActive) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() => _seconds++);
      });
    }
    setState(() => _isActive = !_isActive);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_seconds / 60).floor().toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Massage Therapy (RMT)'), backgroundColor: Colors.brown),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Active Session Timer', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown)),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(48),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.brown, width: 8),
                ),
                child: Text('\$minutes:\$seconds', style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: _toggleTimer,
                icon: Icon(_isActive ? Icons.pause : Icons.play_arrow),
                label: Text(_isActive ? 'Pause Session' : 'Start Session'),
                style: ElevatedButton.styleFrom(backgroundColor: _isActive ? Colors.orange : Colors.green, foregroundColor: Colors.white, minimumSize: const Size(200, 56)),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() { _seconds = 0; _isActive = false; });
                  _timer?.cancel();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Session log signed and submitted to EMR.')));
                },
                icon: const Icon(Icons.stop),
                label: const Text('Complete & Sign Log'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, minimumSize: const Size(200, 56)),
              )
            ],
          ),
        ),
        ),
      ),
      ),
    );
  }
}