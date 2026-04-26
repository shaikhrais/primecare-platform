import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_adapters/src/infrastructure/01_I_telemetry_service.dart';
import 'package:flutter_core/src/resilience/01_I_mechanical_repair_kit.dart';

/// A high-fidelity diagnostic HUD that displays real-time execution gate telemetry.
/// This provides immediate visibility into structural integrity and governance states.
class GovernanceTelemetryHud extends ConsumerStatefulWidget {
  final String? currentUri;
  const GovernanceTelemetryHud({super.key, this.currentUri});

  @override
  ConsumerState<GovernanceTelemetryHud> createState() =>
      _GovernanceTelemetryHudState();
}

class _GovernanceTelemetryHudState extends ConsumerState<GovernanceTelemetryHud>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _showFailuresOnly = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only show in debug mode or if explicitly enabled
    if (!kDebugMode) return const SizedBox.shrink();

    // Auto-expand on failure and show Diagnostic Toasts
    ref.listen(executionGateProvider, (previous, next) {
      final lastGate = next.lastGate;
      if (lastGate != null && lastGate.status == ExecutionGateStatus.fail) {
        // 1. Auto-expand if not already
        if (!_isExpanded) {
          _toggleExpanded();
        }

        // 2. Show Diagnostic Toast (SnackBar)
        _showDiagnosticToast(lastGate);
      }
    });

    final gateService = ref.watch(executionGateProvider);
    final allGates = gateService.allGates;

    final gates = _showFailuresOnly
        ? allGates.where((g) => g.status == ExecutionGateStatus.fail).toList()
        : allGates;

    final failCount = allGates
        .where((g) => g.status == ExecutionGateStatus.fail)
        .length;
    final passCount = allGates
        .where((g) => g.status == ExecutionGateStatus.pass)
        .length;

    return Positioned(
      bottom: 24,
      right: 24,
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isExpanded) _buildExpandedPanel(gates),
            const SizedBox(height: 12),
            _buildSummaryBadge(passCount, failCount),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBadge(int pass, int fail) {
    final hasFailures = fail > 0;
    final color = hasFailures ? Colors.redAccent : Colors.greenAccent;

    return InkWell(
      onTap: _toggleExpanded,
      borderRadius: BorderRadius.circular(32),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 15,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasFailures ? LucideIcons.shieldAlert : LucideIcons.shieldCheck,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              'TELEMETRY',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 8),
            _buildCountCircle(pass, Colors.greenAccent),
            const SizedBox(width: 4),
            _buildCountCircle(fail, Colors.redAccent),
            const SizedBox(width: 8),
            Icon(
              _isExpanded ? LucideIcons.chevronDown : LucideIcons.chevronUp,
              color: Colors.white30,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountCircle(int count, Color color) {
    if (count == 0 && color == Colors.redAccent) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        count.toString(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildExpandedPanel(List<ExecutionGate> gates) {
    return SizeTransition(
      sizeFactor: _expandAnimation,
      axisAlignment: 1.0,
      child: Container(
        width: 380,
        height: 500,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              _buildPanelHeader(),
              Expanded(
                child: gates.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: gates.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final gate =
                              gates[gates.length -
                                  1 -
                                  index]; // Reverse chronological
                          return _buildGateItem(gate);
                        },
                      ),
              ),
              _buildPanelFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanelHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Governance Audit Log',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Real-time structural integrity tracking',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () => ref.read(executionGateProvider).clearGates(),
                icon: const Icon(
                  LucideIcons.trash2,
                  color: Colors.white30,
                  size: 18,
                ),
                tooltip: 'Clear Logs',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(LucideIcons.globe, color: Colors.white24, size: 14),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.currentUri ?? 'Unknown Location',
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              _buildFilterToggle(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterToggle() {
    return InkWell(
      onTap: () => setState(() => _showFailuresOnly = !_showFailuresOnly),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _showFailuresOnly
              ? Colors.redAccent.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _showFailuresOnly
                ? Colors.redAccent.withValues(alpha: 0.4)
                : Colors.white10,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _showFailuresOnly ? LucideIcons.filterX : LucideIcons.filter,
              color: _showFailuresOnly ? Colors.redAccent : Colors.white30,
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              'ERRORS ONLY',
              style: TextStyle(
                color: _showFailuresOnly ? Colors.redAccent : Colors.white30,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGateItem(ExecutionGate gate) {
    final isFail = gate.status == ExecutionGateStatus.fail;
    final isResilience = gate.category == ExecutionGateCategory.resilience;

    final color = isFail
        ? Colors.redAccent
        : (isResilience ? Colors.amberAccent : Colors.greenAccent);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFail
              ? color.withValues(alpha: 0.3)
              : color.withValues(alpha: 0.1),
          width: isFail ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  gate.category.name.toUpperCase(),
                  style: TextStyle(
                    color: color,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (isResilience && isFail) ...[
                const SizedBox(width: 8),
                const Icon(
                  LucideIcons.wrench,
                  size: 10,
                  color: Colors.amberAccent,
                ),
              ],
              const Spacer(),
              Text(
                _formatTime(gate.timestamp),
                style: const TextStyle(color: Colors.white24, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            gate.message,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13,
              height: 1.4,
              fontWeight: isFail ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          if (gate.error != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FAILURE TRACE',
                    style: TextStyle(
                      color: Colors.redAccent.withValues(alpha: 0.5),
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    gate.error.toString(),
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                  if (gate.metadata != null && gate.metadata!.isNotEmpty) ...[
                    const Divider(color: Colors.white10, height: 16),
                    ...gate.metadata!.entries.map(
                      (e) => Text(
                        '${e.key.toUpperCase()}: ${e.value}',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.activity, color: Colors.white10, size: 48),
          SizedBox(height: 16),
          Text(
            'No telemetry data captured.',
            style: TextStyle(color: Colors.white24, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildPanelFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.amberAccent.withValues(alpha: 0.2),
                    Colors.orangeAccent.withValues(alpha: 0.1),
                  ],
                ),
                border: Border.all(
                  color: Colors.amberAccent.withValues(alpha: 0.3),
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  MechanicalRepairKit.performDeepFlush();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mechanical Deep Flush Initiated... System recalibrating.',
                      ),
                      backgroundColor: Color(0xFF0F172A),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(LucideIcons.wrench, size: 16),
                label: const Text(
                  'MECHANICAL REPAIR',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.amberAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDiagnosticToast(ExecutionGate gate) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              LucideIcons.shieldAlert,
              color: Colors.redAccent,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Diagnostic Failure: ${gate.category.name.toUpperCase()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    gate.message,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => _toggleExpanded(),
              child: const Text(
                'VIEW',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }
}
