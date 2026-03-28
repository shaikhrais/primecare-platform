import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';
import 'package:primecare_mobile/features/roles/psw/providers/psw_dashboard_provider.dart';

class PswHomeScreen extends ConsumerStatefulWidget {
  const PswHomeScreen({super.key});

  @override
  ConsumerState<PswHomeScreen> createState() => _PswHomeScreenState();
}

class _PswHomeScreenState extends ConsumerState<PswHomeScreen> {
  bool _isShiftActive = false;
  int _shiftSeconds = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleShift() {
    setState(() {
      _isShiftActive = !_isShiftActive;
      if (_isShiftActive) {
        _shiftSeconds = 0;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() => _shiftSeconds++);
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shift Started! Evv tracking enabled.')));
      } else {
        _timer?.cancel();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shift Ended successfully.')));
      }
    });
  }

  String get _formattedTime {
    final h = (_shiftSeconds ~/ 3600).toString().padLeft(2, '0');
    final m = ((_shiftSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (_shiftSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final asyncDashboard = ref.watch(pswDashboardProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Sleek subtle gray background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. TOP HEADER (Identity & Status)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Good Morning, Rahil 👋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: _isShiftActive ? Colors.green : Colors.grey),
                          const SizedBox(width: 4),
                          Text('Location: ${_isShiftActive ? 'Active ✅' : 'Inactive'}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_active, color: Colors.blueAccent),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(height: 24),

              // 2. PRIMARY ACTION CARD
              PrimeCareCard(
                backgroundColor: _isShiftActive ? Colors.blue.shade50 : Colors.white,
                child: Column(
                  children: [
                    Text(
                      _isShiftActive ? 'Client: Mrs. Kaur' : 'Next Shift: Mrs. Kaur',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (_isShiftActive) ...[
                      const SizedBox(height: 8),
                      Text('⏱ $_formattedTime', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.indigo)),
                    ],
                    const SizedBox(height: 16),
                    PrimeCareButton(
                      label: _isShiftActive ? 'End Shift' : 'Start Shift',
                      icon: _isShiftActive ? Icons.stop_circle : Icons.play_circle_fill,
                      isFullWidth: true,
                      type: _isShiftActive ? PrimeCareButtonType.secondary : PrimeCareButtonType.primary,
                      onPressed: _toggleShift,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. TODAY'S TASKS (Checklist)
              const Text("Today's Workflow", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
              const SizedBox(height: 12),
              PrimeCareCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    PrimeCareTaskRow(icon: Icons.health_and_safety, title: 'ADL Care Entry', statusColor: Colors.orange, onTap: () => context.push(AppRoutes.pswDailyEntry)),
                    const Divider(height: 1),
                    PrimeCareTaskRow(icon: Icons.medication, title: 'Medication Assistance', statusColor: Colors.green, onTap: () => context.push(AppRoutes.pswMar)),
                    const Divider(height: 1),
                    PrimeCareTaskRow(icon: Icons.note_alt, title: 'Progress Notes', statusColor: Colors.blue, onTap: () => context.push(AppRoutes.pswProgressNotes)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. QUICK ACTION GRID
              const Text("Quick Dispatch", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  PrimeCareActionTile(icon: Icons.warning_amber_rounded, label: 'Incident', iconColor: Colors.red, onTap: () => context.push(AppRoutes.pswIncidentReport)),
                  PrimeCareActionTile(icon: Icons.medication, label: 'Meds', iconColor: Colors.green, onTap: () => context.push(AppRoutes.pswMar)),
                  PrimeCareActionTile(icon: Icons.monitor_heart, label: 'Vitals', iconColor: Colors.purple, onTap: () => context.push(AppRoutes.pswDailyEntry)),
                  PrimeCareActionTile(icon: Icons.phone, label: 'Call RN', iconColor: Colors.blue, onTap: () {}),
                ],
              ),
              const SizedBox(height: 24),

              // 5. CLIENT SUMMARY
              const Text("Client Intel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
              const SizedBox(height: 12),
              PrimeCareCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mrs. Kaur (78)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Condition: Stroke Recovery', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const PrimeStatusBadge(text: '⚠️ Fall Risk', color: Colors.orange),
                        const SizedBox(width: 8),
                        const PrimeStatusBadge(text: 'Low BP', color: Colors.red),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 6. PROGRESS BAR
              const Text("Shift Compliance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Expanded(
                    child: PrimeCareProgressBar(progress: 0.6, activeColor: Colors.green),
                  ),
                  const SizedBox(width: 12),
                  const Text('60%', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 32),

              // 10. QUICK DAILY ENTRY (SMART FEATURE)
              PrimeCareButton(
                label: '⚡ Complete Daily Entry Wizard',
                isFullWidth: true,
                icon: Icons.flash_on,
                onPressed: () => context.push(AppRoutes.pswDailyEntry),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

}
