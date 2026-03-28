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

  // --- RESPONSIVE WIDGET BUILDERS ---

  Widget _buildGreetingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Good Morning, Rahil 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: _isShiftActive ? Colors.green : Colors.grey),
                const SizedBox(width: 6),
                Text('Location: ${_isShiftActive ? 'Active ✅' : 'Inactive'}', style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications_active, color: Colors.blueAccent, size: 28),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildShiftExecutionCard() {
    return PrimeCareCard(
      backgroundColor: _isShiftActive ? Colors.blue.shade50 : Colors.white,
      child: Column(
        children: [
          Text(
            _isShiftActive ? 'Active Client: Mrs. Kaur' : 'Next Shift: Mrs. Kaur',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (_isShiftActive) ...[
            const SizedBox(height: 12),
            Text('⏱ $_formattedTime', style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.indigo)),
          ],
          const SizedBox(height: 20),
          PrimeCareButton(
            label: _isShiftActive ? 'End Shift' : 'Locate & Start Shift',
            icon: _isShiftActive ? Icons.stop_circle : Icons.play_circle_fill,
            isFullWidth: true,
            type: _isShiftActive ? PrimeCareButtonType.secondary : PrimeCareButtonType.primary,
            onPressed: _toggleShift,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowQueue() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildQuickDispatchGrid(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quick Dispatch", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isDesktop ? 4 : 4, // 4 tiles natively balance on both mobile widths and desktop panes
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            PrimeCareActionTile(icon: Icons.warning_amber_rounded, label: 'Incident', iconColor: Colors.red, onTap: () => context.push(AppRoutes.pswIncidentReport)),
            PrimeCareActionTile(icon: Icons.medication, label: 'Meds', iconColor: Colors.green, onTap: () => context.push(AppRoutes.pswMar)),
            PrimeCareActionTile(icon: Icons.monitor_heart, label: 'Vitals', iconColor: Colors.purple, onTap: () => context.push(AppRoutes.pswDailyEntry)),
            PrimeCareActionTile(icon: Icons.phone, label: 'Call RN', iconColor: Colors.blue, onTap: () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildClientIntel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Client Intel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
        const SizedBox(height: 12),
        PrimeCareCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mrs. Kaur (78)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Condition: Stroke Recovery', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: const [
                  PrimeStatusBadge(text: '⚠️ Fall Risk', color: Colors.orange),
                  PrimeStatusBadge(text: 'Low BP', color: Colors.red),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceTracker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Shift Compliance Tracker", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(
              child: PrimeCareProgressBar(progress: 0.6, activeColor: Colors.green),
            ),
            SizedBox(width: 16),
            Text('60%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget _buildFastEntryAction() {
    return PrimeCareButton(
      label: '⚡ Complete Daily Entry Wizard',
      isFullWidth: true,
      icon: Icons.flash_on,
      onPressed: () => context.push(AppRoutes.pswDailyEntry),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Sleek subtle gray background
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 800;
            
            if (isDesktop) {
              // --- PREMIUM DESKTOP / TABLET LAYOUT (2 Columns) ---
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
                child: Column(
                  children: [
                    _buildGreetingHeader(),
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Pane: Shift Action & Quick Dispatch
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildShiftExecutionCard(),
                              const SizedBox(height: 32),
                              _buildQuickDispatchGrid(isDesktop),
                              const SizedBox(height: 32),
                              _buildWorkflowQueue(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 48), // Generous Gutter
                        
                        // Right Side Rail: Intelligence & Compliance
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildClientIntel(),
                              const SizedBox(height: 32),
                              _buildComplianceTracker(),
                              const SizedBox(height: 48),
                              _buildFastEntryAction(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              // --- STANDARD NATIVE MOBILE LAYOUT (1 Column Vertical Stack) ---
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildGreetingHeader(),
                    const SizedBox(height: 24),
                    _buildShiftExecutionCard(),
                    const SizedBox(height: 24),
                    _buildWorkflowQueue(),
                    const SizedBox(height: 24),
                    _buildQuickDispatchGrid(isDesktop),
                    const SizedBox(height: 24),
                    _buildClientIntel(),
                    const SizedBox(height: 24),
                    _buildComplianceTracker(),
                    const SizedBox(height: 32),
                    _buildFastEntryAction(),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
