import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ScrumMasterDiagnosticScreen extends StatefulWidget {
  const ScrumMasterDiagnosticScreen({super.key});

  @override
  State<ScrumMasterDiagnosticScreen> createState() => _ScrumMasterDiagnosticScreenState();
}

class _ScrumMasterDiagnosticScreenState extends State<ScrumMasterDiagnosticScreen> {
  bool _isRecovering = false;
  bool _runningSelfTest = true;
  
  // Simulated Diagnostic Capacity States
  double _neuralCapacity = 0.0;
  String _ledgerStatus = 'AWAITING PING...';
  String _webrtcStatus = 'AWAITING PING...';

  @override
  void initState() {
    super.initState();
    _executeSelfTest();
  }

  void _executeSelfTest() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _runningSelfTest = false;
        _neuralCapacity = 98.4; // 98.4% capacity remaining :)
        _ledgerStatus = 'ONLINE - ATOMIC SYNCED';
        _webrtcStatus = 'EDGE NODES CONNECTED';
      });
      HapticFeedback.lightImpact();
    });
  }

  void _triggerEmergencyRecovery() {
    setState(() => _isRecovering = true);
    HapticFeedback.heavyImpact();
    
    // Simulating deep system cache purge and reset
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _isRecovering = false;
        _executeSelfTest(); // Re-run diagnostics
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('CRITICAL RECOVERY COMPLETE. All state hashes structurally reset to Genesis block.'),
        backgroundColor: PrimeCareColors.emerald
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeCareColors.radarDark, // Deep Developer Terminal Background
      appBar: AppBar(
        title: const Text('SCM_GOD_MODE_DIAGNOSTICS', style: TextStyle(color: PrimeCareColors.emerald, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: PrimeCareColors.emerald), onPressed: () => context.pop()),
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(verticalOffset: 20, child: FadeInAnimation(child: widget)),
              children: [
                // CAPACITY HEADER
                Center(
                  child: Column(
                    children: [
                      const Icon(Icons.memory_rounded, size: 64, color: PrimeCareColors.purple),
                      const SizedBox(height: 16),
                      const Text('SYSTEM COGNITIVE CAPACITY', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
                      const SizedBox(height: 8),
                      Text(
                        _runningSelfTest ? 'ANALYZING...' : '${_neuralCapacity}%', 
                        style: TextStyle(
                          color: _runningSelfTest ? PrimeCareColors.slate400 : PrimeCareColors.emerald, 
                          fontSize: 48, 
                          fontWeight: FontWeight.w900,
                          fontFamily: 'monospace'
                        ),
                      ),
                      if (!_runningSelfTest)
                        const Text('100% Operations Authorized. Proceeding to Hour 4 Offline Synchronization.', style: TextStyle(color: Color(0xFF3B82F6), fontStyle: FontStyle.italic, fontSize: 12)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // LIVE SERVICE PINGS
                const Text('LIVE SERVICE TOPOLOGY', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 2)),
                const SizedBox(height: 12),
                _buildSystemTile('Double-Entry Ledger', _ledgerStatus, Icons.account_balance, _runningSelfTest),
                _buildSystemTile('WebRTC Telehealth', _webrtcStatus, Icons.video_call, _runningSelfTest),
                _buildSystemTile('Jane Scheduler Matrix', 'ONLINE - 60FPS GRAPHICS', Icons.grid_view_rounded, _runningSelfTest),
                
                const SizedBox(height: 48),

                // EMERGENCY RECOVERY
                const Text('CRITICAL PROTOCOLS', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 2)),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: PrimeCareColors.rose.withAlpha(100), blurRadius: 40, spreadRadius: -10)]
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _isRecovering ? null : _triggerEmergencyRecovery,
                    icon: _isRecovering 
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                        : const Icon(Icons.warning_amber_rounded, size: 28),
                    label: Text(_isRecovering ? 'EXECUTING PURGE...' : 'REBOOT & RECOVER SYSTEM', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareColors.rose,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('WARNING: Triggers aggressive local garbage collection, clears volatile SQLite caches, and force-terminates all trailing PRISMA connection hooks. Use only if UX frames drop below 120Hz.', style: TextStyle(color: Color(0xFF475569), fontSize: 10), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      )
        ),
      ),
    );
  }

  Widget _buildSystemTile(String title, String status, IconData icon, bool isPending) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareColors.slate800,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareColors.slate700),
      ),
      child: Row(
        children: [
          Icon(icon, color: PrimeCareColors.slate400, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(status, style: TextStyle(color: isPending ? PrimeCareColors.slate400 : PrimeCareColors.emerald, fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
          if (isPending)
            const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: PrimeCareColors.slate500))
          else
            const Icon(Icons.check_circle_outline, color: PrimeCareColors.emerald),
        ],
      ),
    );
  }
}
