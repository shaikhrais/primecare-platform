import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TelemetryNode {
  final String id;
  final String name;
  final String role;
  String currentPath;
  Duration timeLogged;
  int workDone;
  int workTotal;

  TelemetryNode({
    required this.id, required this.name, required this.role,
    required this.currentPath, required this.timeLogged,
    required this.workDone, required this.workTotal
  });

  double get productivity => workTotal == 0 ? 0 : (workDone / workTotal);
}

class AdminTelemetryScreen extends StatefulWidget {
  const AdminTelemetryScreen({super.key});

  @override
  State<AdminTelemetryScreen> createState() => _AdminTelemetryScreenState();
}

class _AdminTelemetryScreenState extends State<AdminTelemetryScreen> {
  late Timer _pingTimer;
  final Random _rnd = Random();
  
  int _activeSessions = 412;
  int _totalHours = 1204;
  int _totalWork = 5432;

  final List<TelemetryNode> _liveUsers = [
    TelemetryNode(id: 'u1', name: 'Sarah Jenkins', role: 'RN', currentPath: '/rn/clinical-hub', timeLogged: const Duration(hours: 6, minutes: 12), workDone: 11, workTotal: 12),
    TelemetryNode(id: 'u2', name: 'Marcus Cole', role: 'PSW', currentPath: '/psw/timesheets', timeLogged: const Duration(hours: 8, minutes: 4), workDone: 8, workTotal: 10),
    TelemetryNode(id: 'u3', name: 'Dr. Emily Chen', role: 'Client', currentPath: '/client/calendar', timeLogged: const Duration(hours: 0, minutes: 45), workDone: 2, workTotal: 3),
    TelemetryNode(id: 'u4', name: 'James Wilson', role: 'Coordinator', currentPath: '/coordinator/jane-matrix', timeLogged: const Duration(hours: 4, minutes: 30), workDone: 45, workTotal: 60),
    TelemetryNode(id: 'u5', name: 'Elena Rostova', role: 'MT', currentPath: '/mt/invoices', timeLogged: const Duration(hours: 5, minutes: 20), workDone: 14, workTotal: 15),
    TelemetryNode(id: 'u6', name: 'David Kim', role: 'GM', currentPath: '/gm/executive', timeLogged: const Duration(hours: 7, minutes: 10), workDone: 18, workTotal: 25),
    TelemetryNode(id: 'u7', name: 'Root System', role: 'Admin', currentPath: '/admin/telemetry', timeLogged: const Duration(hours: 9, minutes: 55), workDone: 99, workTotal: 100),
  ];

  final List<String> _simulatedPaths = [
    '/shared/daily-actions', '/network/ping', '/audit/logs', '/timesheet/view', '/clinical/form', '/billing/hub'
  ];

  @override
  void initState() {
    super.initState();
    // Simulate incoming WebSocket heartbeat metrics explicitly updating lengths
    _pingTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _activeSessions += _rnd.nextInt(5) - 2;
          
          if (_rnd.nextBool()) {
            _totalWork += _rnd.nextInt(4);
            // Randomly update a user's target to simulate live movement natively
            int targetIdx = _rnd.nextInt(_liveUsers.length);
            _liveUsers[targetIdx].currentPath = _simulatedPaths[_rnd.nextInt(_simulatedPaths.length)];
            
            if (_rnd.nextBool() && _liveUsers[targetIdx].workDone < _liveUsers[targetIdx].workTotal) {
               _liveUsers[targetIdx].workDone++;
            }
          }
          
          for(var user in _liveUsers) {
            user.timeLogged += const Duration(minutes: 1);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pingTimer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    int hours = d.inHours;
    int minutes = d.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderLine(),
            const SizedBox(height: 32),
            _buildTopMetricsRow(),
            const SizedBox(height: 32),
            Text('Live Enterprise Telemetry Array', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
            const SizedBox(height: 16),
            _buildTelemetryTable(context),
            const SizedBox(height: 32),
            Text('Platform Screen-Wise Traffic Distribution', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
            const SizedBox(height: 16),
            _buildScreenWiseUsage(context),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderLine() {
    return Row(
      children: [
        Icon(Icons.radar, size: 48, color: Color(0xFF6366F1)), 
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Global User Telemetry & Worker Diagnostics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            Text('Real-Time physical routing matrix tracking global execution loops exclusively.', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }

  Widget _buildTopMetricsRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildMetricBox('Active WebSocket Syncs', '$_activeSessions', Icons.wifi_tethering, Color(0xFF0EA5E9)),
        _buildMetricBox('Time Locked Today', '$_totalHours Hrs', Icons.timer_outlined, Color(0xFF8B5CF6)),
        _buildMetricBox('Operations Synced', '$_totalWork', Icons.work_history, Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildMetricBox(String label, String value, IconData icon, Color color) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: Offset(0, 4))
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
              Icon(icon, color: color, size: 24),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }

  Widget _buildTelemetryTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 800),
          child: DataTable(
            headingTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 13),
            dataTextStyle: TextStyle(fontWeight: FontWeight.w600, color: PrimeCareColors.radarDark, fontSize: 14),
            columns: const [
              DataColumn(label: Text('EMPLOYEE / USER')),
              DataColumn(label: Text('ROLE IDENTIFIER')),
              DataColumn(label: Text('LIVE VIEWPORT URL')),
              DataColumn(label: Text('TIME SPENT')),
              DataColumn(label: Text('WORK EXECUTED')),
              DataColumn(label: Text('HEALTH SCORE')),
            ],
            rows: _liveUsers.map((user) {
              final double score = user.productivity;
              Color pColor = score >= 0.9 ? Color(0xFF10B981) : score >= 0.7 ? Colors.orange : Color(0xFFF43F5E);
              
              return DataRow(
                cells: [
                  DataCell(Row(
                    children: [
                      CircleAvatar(radius: 14, backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1), child: Text(user.name[0], style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold))),
                      const SizedBox(width: 12),
                      Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )),
                  DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                    child: Text(user.role, style: TextStyle(color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.bold)),
                  )),
                  DataCell(Text(user.currentPath, style: TextStyle(color: Colors.blue[700], fontFamily: 'monospace'))),
                  DataCell(Text(_formatDuration(user.timeLogged))),
                  DataCell(Text('${user.workDone} / ${user.workTotal} Tasks')),
                  DataCell(Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text('${(score * 100).toInt()}%', style: TextStyle(color: pColor, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: score,
                          backgroundColor: Colors.grey[200],
                          color: pColor,
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      )
                    ],
                  )),
                ]
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildScreenWiseUsage(BuildContext context) {
    // Simulated live screen analytics modeling exact view ingestion mapping perfectly
    final List<Map<String, dynamic>> screenData = [
      {'route': '/psw/timesheets', 'views': 12430, 'color': Color(0xFF10B981), 'percentage': 0.38},
      {'route': '/rn/clinical-hub', 'views': 8211, 'color': Color(0xFF3B82F6), 'percentage': 0.25},
      {'route': '/coordinator/jane-matrix', 'views': 6042, 'color': Color(0xFFF59E0B), 'percentage': 0.18},
      {'route': '/client/dashboard', 'views': 3105, 'color': Color(0xFF0EA5E9), 'percentage': 0.09},
      {'route': '/admin/audit', 'views': 840, 'color': Color(0xFFF43F5E), 'percentage': 0.02},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: screenData.map((data) {
        return Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: Offset(0, 4))
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(data['route'], style: TextStyle(color: Colors.blue[700], fontFamily: 'monospace', fontWeight: FontWeight.bold))),
                  Icon(Icons.remove_red_eye, color: data['color'], size: 18),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${data['views']} views', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text('${(data['percentage'] * 100).toInt()}% Total Tnx', style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: data['percentage'],
                backgroundColor: Colors.grey[200],
                color: data['color'],
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
