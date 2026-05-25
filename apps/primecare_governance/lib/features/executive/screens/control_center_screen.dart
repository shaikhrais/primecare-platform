import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'control_center_screen_controller.dart';

class ControlCenterScreen extends ConsumerWidget {
  const ControlCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(controlCenterScreenControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A), // Sleek deep slate dark theme
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.cyan.withOpacity(0.3)),
              ),
              child: const Icon(LucideIcons.shield, color: Colors.cyan, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PRIMECARE GOVERNANCE COMMAND CENTER',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'REALTIME SOFTWARE FACTORY MONITOR',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.2,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color(0xFF07080D),
        elevation: 4,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(LucideIcons.wifi, color: Colors.green, size: 12),
                SizedBox(width: 6),
                Text(
                  'SQLITE ACTIVE',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: stateAsync.when(
        data: (state) => LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            
            // Ultra-responsive Grid Viewports: 
            // 4K/3K/2K screens: 3 wide columns
            // Standard Desktop (1000px+): 2 columns
            // Tablet/Mobile: 1 column
            if (width > 1600) {
              return _build3ColumnLayout(context, ref, state);
            } else if (width > 1000) {
              return _build2ColumnLayout(context, ref, state);
            } else {
              return _build1ColumnLayout(context, ref, state);
            }
          },
        ),
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.cyan)),
              SizedBox(height: 16),
              Text(
                'Hydrating relational registry queue from master SQLite view...',
                style: TextStyle(color: Colors.cyan, fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Compliance drift detected: $err',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }

  // --- Layout Implementations ---

  Widget _build3ColumnLayout(BuildContext context, WidgetRef ref, ControlCenterState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left panel: Health Overview, Phase Progress & Failed Telemetry
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildHealthScoreCard(context, state),
                const SizedBox(height: 12),
                Expanded(child: _buildPhaseProgressCard(context, state)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Middle panel: The Task Dispatch Queue (SQLite queue)
          Expanded(
            flex: 4,
            child: _buildTaskQueuePanel(context, ref, state),
          ),
          const SizedBox(width: 12),
          // Right panel: Agent HUD, Logs Terminal & Evidence inspector
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(flex: 5, child: _buildAgentHUDPanel(context, ref, state)),
                const SizedBox(height: 12),
                Expanded(flex: 4, child: _buildEvidencePanel(context, ref, state)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _build2ColumnLayout(BuildContext context, WidgetRef ref, ControlCenterState state) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: Queue + Health Overview
          Expanded(
            flex: 5,
            child: Column(
              children: [
                _buildHealthScoreCard(context, state),
                const SizedBox(height: 12),
                Expanded(child: _buildTaskQueuePanel(context, ref, state)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Right: Agent HUD HUD + Evidence panel
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(flex: 5, child: _buildAgentHUDPanel(context, ref, state)),
                const SizedBox(height: 12),
                Expanded(flex: 4, child: _buildEvidencePanel(context, ref, state)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _build1ColumnLayout(BuildContext context, WidgetRef ref, ControlCenterState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          _buildHealthScoreCard(context, state),
          const SizedBox(height: 12),
          SizedBox(
            height: 450,
            child: _buildTaskQueuePanel(context, ref, state),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 400,
            child: _buildAgentHUDPanel(context, ref, state),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 350,
            child: _buildEvidencePanel(context, ref, state),
          ),
        ],
      ),
    );
  }

  // --- Panels & Components ---

  Widget _buildHealthScoreCard(BuildContext context, ControlCenterState state) {
    return Card(
      color: const Color(0xFF161925),
      elevation: 6,
      shadowColor: Colors.cyan.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.cyan.withOpacity(0.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Circular Glowing Score Meter
            SizedBox(
              height: 72,
              width: 72,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: state.overallScore / 100,
                    strokeWidth: 6,
                    backgroundColor: Colors.white.withOpacity(0.05),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
                  ),
                  Center(
                    child: Text(
                      '${state.overallScore.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'GOVERNANCE OVERALL SCORE',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildMiniBadge(Icons.bug_report, '${state.driftsCount} drifts', Colors.orange),
                      const SizedBox(width: 8),
                      _buildMiniBadge(Icons.warning, '${state.mismatchesCount} warnings', Colors.redAccent),
                      const SizedBox(width: 8),
                      _buildMiniBadge(Icons.api, '${state.failedEndpointsCount} errors', Colors.purpleAccent),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniBadge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 10),
          const SizedBox(width: 4),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 8,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseProgressCard(BuildContext context, ControlCenterState state) {
    // Calculates percentage of task completion across phases
    final total = state.tasks.length;
    final completed = state.tasks.where((t) => t.status == 'completed').length;
    final progress = total > 0 ? completed / total : 0.0;

    return Card(
      color: const Color(0xFF161925),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SOFTWARE FACTORY LIFECYCLE PROGRESS',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 1.1,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.05),
              valueColor: const AlwaysStoppedAnimation(Colors.cyan),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'COMPLIANCE GATE METRICS',
                  style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.5)),
                ),
                Text(
                  '$completed / $total COMPLETED',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.cyan, fontFamily: 'monospace'),
                ),
              ],
            ),
            const Divider(height: 24, color: Colors.white10),
            Expanded(
              child: ListView(
                children: [
                  _buildPhaseListTile('PHASE 1: DISCOVERY', 'Zero-drift crawler verification', 4, 3, Colors.blue),
                  _buildPhaseListTile('PHASE 2: IMPLEMENTATION', 'Wiring screen closures & forms', 4, 2, Colors.orange),
                  _buildPhaseListTile('PHASE 3: RUNTIME TESTING', 'SSO OAuth Callback & E2E checks', 4, 2, Colors.green),
                  _buildPhaseListTile('PHASE 4: RELEASE VERIFICATION', 'Cloudflare gates & audits', 4, 1, Colors.purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseListTile(String name, String desc, int total, int done, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.check_circle_outline, color: color, size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  desc,
                  style: TextStyle(fontSize: 9, color: Colors.white.withOpacity(0.4)),
                ),
              ],
            ),
          ),
          Text(
            '$done / $total',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskQueuePanel(BuildContext context, WidgetRef ref, ControlCenterState state) {
    final pendingTasks = state.tasks.where((t) => t.status != 'completed').toList();

    return Card(
      color: const Color(0xFF161925),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(LucideIcons.list, color: Colors.cyan, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'PENDING WORK DISPATCH QUEUE',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${pendingTasks.length} INCOMPLETE',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'SQLite Query: SELECT * FROM v_agent_pending_task_queue ORDER BY priority_rank ASC;',
              style: TextStyle(
                fontSize: 9,
                fontFamily: 'monospace',
                color: Colors.white.withOpacity(0.35),
              ),
            ),
            const Divider(height: 20, color: Colors.white10),
            Expanded(
              child: pendingTasks.isEmpty
                  ? const Center(
                      child: Text(
                        'All tasks fully verified and closed cleanly!',
                        style: TextStyle(color: Colors.green, fontFamily: 'monospace'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: pendingTasks.length,
                      itemBuilder: (context, index) {
                        final task = pendingTasks[index];
                        final isSelected = state.selectedTaskId == task.id;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.cyan.withOpacity(0.06) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.cyan.withOpacity(0.3)
                                  : Colors.white.withOpacity(0.05),
                            ),
                          ),
                          child: ListTile(
                            selected: isSelected,
                            onTap: () {
                              ref.read(controlCenterScreenControllerProvider.notifier).selectTask(task.id);
                            },
                            title: Row(
                              children: [
                                _buildPriorityBadge(task.priority),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    task.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    task.phase,
                                    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 9),
                                  ),
                                  _buildStatusBadge(task.status),
                                ],
                              ),
                            ),
                            trailing: const Icon(LucideIcons.chevronRight, color: Colors.cyan, size: 14),
                          ),
                        ).animate(target: isSelected ? 1.0 : 0.0).scaleXY(end: 1.02, curve: Curves.easeOut);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color col;
    switch (priority) {
      case 'critical':
        col = Colors.redAccent;
        break;
      case 'high':
        col = Colors.orangeAccent;
        break;
      case 'medium':
        col = Colors.blueAccent;
        break;
      default:
        col = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: col.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: col.withOpacity(0.4)),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(color: col, fontWeight: FontWeight.bold, fontSize: 8, fontFamily: 'monospace'),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color col;
    switch (status) {
      case 'test_failed':
      case 'build_failed':
      case 'runtime_failed':
        col = Colors.redAccent;
        break;
      case 'fixing':
      case 'investigating':
        col = Colors.orangeAccent;
        break;
      case 'assigned':
        col = Colors.yellow;
        break;
      case 'proof_missing':
        col = Colors.purpleAccent;
        break;
      case 'verified':
        col = Colors.greenAccent;
        break;
      default:
        col = Colors.cyanAccent;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: col.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: col, fontWeight: FontWeight.bold, fontSize: 8, fontFamily: 'monospace'),
      ),
    );
  }

  Widget _buildAgentHUDPanel(BuildContext context, WidgetRef ref, ControlCenterState state) {
    final selectedTask = state.tasks.firstWhere(
      (t) => t.id == state.selectedTaskId,
      orElse: () => state.tasks.first,
    );

    final isAgentActive = state.agentStatus != 'idle';

    return Card(
      color: const Color(0xFF161925),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isAgentActive ? Colors.cyan.withOpacity(0.3) : Colors.white.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.terminal, color: Colors.cyan, size: 16),
                    const SizedBox(width: 8),
                    const Text(
                      'AGENT TELEMETRY CONSOLE HUD',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.2,
                        color: Colors.white,
                      ),
                    ),
                    if (isAgentActive) ...[
                      const SizedBox(width: 10),
                      const SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.cyan)),
                      ),
                    ],
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isAgentActive ? Colors.cyan.withOpacity(0.15) : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    state.agentStatus.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: isAgentActive ? Colors.cyan : Colors.white60,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.white10),
            // Selected Task Details summary
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F111A),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedTask.title.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.cyan, fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedTask.description,
                    style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        key: const ValueKey('data-cy-btn-dispatch'),
                        onPressed: isAgentActive || selectedTask.status == 'completed'
                            ? null
                            : () => ref.read(controlCenterScreenControllerProvider.notifier).dispatchToAgent(selectedTask.id),
                        icon: const Icon(LucideIcons.play, size: 12),
                        label: const Text('DISPATCH AGENT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(LucideIcons.refreshCw, size: 14),
                            onPressed: () => ref.read(controlCenterScreenControllerProvider.notifier).triggerRetest(selectedTask.id),
                            tooltip: 'Trigger Retest',
                          ),
                          IconButton(
                            icon: const Icon(LucideIcons.eye, size: 14),
                            onPressed: () => ref.read(controlCenterScreenControllerProvider.notifier).verifyScreenUI(selectedTask.id),
                            tooltip: 'Verify Screen UI',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Live logs console
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: ListView.builder(
                  reverse: true,
                  itemCount: state.agentLogs.length,
                  itemBuilder: (context, index) {
                    final log = state.agentLogs[state.agentLogs.length - 1 - index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        log,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEvidencePanel(BuildContext context, WidgetRef ref, ControlCenterState state) {
    final selectedTask = state.tasks.firstWhere(
      (t) => t.id == state.selectedTaskId,
      orElse: () => state.tasks.first,
    );

    return Card(
      color: const Color(0xFF161925),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(LucideIcons.fileSignature, color: Colors.cyan, size: 16),
                SizedBox(width: 8),
                Text(
                  'RELATIONAL COMPLIANCE PROOF',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.white10),
            Expanded(
              child: selectedTask.proof == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.lock, color: Colors.white.withOpacity(0.2), size: 36),
                          const SizedBox(height: 8),
                          Text(
                            'No telemetry proof generated yet.',
                            style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            key: const ValueKey('data-cy-btn-upload-proof'),
                            onPressed: selectedTask.status == 'completed'
                                ? null
                                : () {
                                    ref.read(controlCenterScreenControllerProvider.notifier).addVerificationProof(
                                      selectedTask.id,
                                      "Manual validation assertion matched responsive grids successfully.",
                                      "assets/screenshots/manual_verify_pass.png",
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.05),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: const Text('UPLOAD MANUAL PROOF', style: TextStyle(fontSize: 10)),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'STATUS: ${selectedTask.status.toUpperCase()}',
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              if (selectedTask.completedAt != null)
                                Text(
                                  'CLOSED AT: ${selectedTask.completedAt}',
                                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 9, fontFamily: 'monospace'),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'AUDIT TELEMETRY LOG:',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.cyan, fontFamily: 'monospace'),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F111A),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              selectedTask.proof?['audit_logs'] ?? selectedTask.proof?['runtime_exception'] ?? '',
                              style: const TextStyle(fontFamily: 'monospace', fontSize: 9, color: Colors.white70),
                            ),
                          ),
                          if (selectedTask.proof?['screenshot_path'] != null || selectedTask.proof?['target_file'] != null) ...[
                            const SizedBox(height: 12),
                            const Text(
                              'VERIFICATION SIGNATURE / ARTIFACT:',
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.cyan, fontFamily: 'monospace'),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedTask.proof?['signature'] ?? 'TARGET FILE: ${selectedTask.proof?['target_file']}',
                              style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

