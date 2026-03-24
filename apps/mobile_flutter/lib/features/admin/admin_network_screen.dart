import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AdminNetworkScreen extends StatefulWidget {
  const AdminNetworkScreen({super.key});

  @override
  State<AdminNetworkScreen> createState() => _AdminNetworkScreenState();
}

class _AdminNetworkScreenState extends State<AdminNetworkScreen> {
  late Timer _telemetryTimer;
  final Random _rnd = Random();
  
  // Live Metrics tracking
  int _globalLatency = 18;
  int _activeWebRtc = 142;
  double _dataTransmittedTb = 24.7;
  double _cpuLoad = 34.2;

  // Visual Node array explicitly mapping Cloudflare edge emulation
  final List<Map<String, dynamic>> _edgeNodes = [
    {'region': 'US-East-1', 'status': 'HEALTHY', 'ping': 12, 'type': 'Core Routing'},
    {'region': 'CA-Central', 'status': 'HEALTHY', 'ping': 8, 'type': 'Primary DB'},
    {'region': 'EU-West-2', 'status': 'DEGRADED', 'ping': 145, 'type': 'Edge Replica'},
    {'region': 'AP-South', 'status': 'OFFLINE', 'ping': 0, 'type': 'Ghost Node'},
  ];

  bool _isPurging = false;
  bool _isRestarting = false;

  @override
  void initState() {
    super.initState();
    // Simulate live telemetry ingestion dynamically
    _telemetryTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _globalLatency = 15 + _rnd.nextInt(12); // Fluctuate 15-27ms
          if (_rnd.nextBool()) {
            _activeWebRtc += _rnd.nextInt(5) - 2; // Market drift
          }
          if (_activeWebRtc < 100) _activeWebRtc = 100;
          _dataTransmittedTb += (_rnd.nextDouble() * 0.05);
          _cpuLoad = 30.0 + _rnd.nextDouble() * 15.0; // 30-45%

          // Fluctuate EU node securely simulating live constraints
          _edgeNodes[2]['ping'] = 140 + _rnd.nextInt(30);
        });
      }
    });
  }

  @override
  void dispose() {
    _telemetryTimer.cancel();
    super.dispose();
  }

  Future<void> _handlePurge() async {
    setState(() => _isPurging = true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() => _isPurging = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Global Edge Cache thoroughly purged.', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Color(0xFF059669))
      );
    }
  }

  Future<void> _handleRestart() async {
    setState(() => _isRestarting = true);
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      setState(() {
        _isRestarting = false;
        _globalLatency = 12; // Flush latency visually
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Telemetry Engine forced restart successful.', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Color(0xFF0EA5E9))
      );
    }
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
            Text('Global Edge Routing Array', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
            const SizedBox(height: 16),
            _buildRoutingGrid(),
            const SizedBox(height: 32),
            Text('Execute Core Network Commands', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
            const SizedBox(height: 16),
            _buildCommandCenter(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderLine() {
    return Row(
      children: [
        Icon(Icons.hub_rounded, size: 48, color: Color(0xFF8B5CF6)), 
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Global Network Operations Center (NOC)', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            Text('PrimeCare Platform Ecosystem - Live Environment', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
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
        _buildMetricBox('Edge Latency', '${_globalLatency}ms', Icons.speed_rounded, _globalLatency > 23 ? Colors.orange : Color(0xFF10B981)),
        _buildMetricBox('Active WebRTC', '$_activeWebRtc', Icons.videocam, Color(0xFF3B82F6)),
        _buildMetricBox('Data Transferred', '${_dataTransmittedTb.toStringAsFixed(2)} TB', Icons.data_usage, Color(0xFF8B5CF6)),
        _buildMetricBox('CPU Load', '${_cpuLoad.toStringAsFixed(1)}%', Icons.memory, Colors.amber[700]!),
      ],
    );
  }

  Widget _buildMetricBox(String label, String value, IconData icon, Color color) {
    return Container(
      width: 250,
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

  Widget _buildRoutingGrid() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: _edgeNodes.map((node) {
        Color statusColor;
        switch(node['status']) {
          case 'HEALTHY': statusColor = Color(0xFF10B981); break;
          case 'DEGRADED': statusColor = Colors.orange; break;
          default: statusColor = PrimeCareColors.rose;
        }

        return Container(
          width: 360,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 2),
            boxShadow: [
              BoxShadow(color: statusColor.withValues(alpha: 0.1), blurRadius: 10, offset: Offset(0, 4))
            ]
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(Icons.dns, color: statusColor, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(node['region'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 4),
                    Text(node['type'], style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(12)),
                    child: Text(node['status'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  const SizedBox(height: 8),
                  Text(node['ping'] > 0 ? '${node['ping']}ms ping' : 'Timeout', style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCommandCenter() {
    return PrimeCareCard(
      padding: const EdgeInsets.all(32),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isLarge = constraints.maxWidth > 700;

          Widget purgeBlock = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edge Caching Controls', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Aggressively flush Cloudflare Edge Workers terminating lingering WebRTC sockets instantly.', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 24),
              PrimeCareButton(
                type: PrimeCareButtonType.primary,
                onPressed: _isPurging ? null : _handlePurge,
                child: _isPurging 
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text('Purge Edge Cache', style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          );

          Widget restartBlock = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Telemetry Instance Restart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Forces a rolling restart of the polling metric ingestion engine smoothing latency spikes locally.', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 24),
              PrimeCareButton(
                type: PrimeCareButtonType.secondary,
                onPressed: _isRestarting ? null : _handleRestart,
                child: _isRestarting 
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text('Restart Telemetry Engine', style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          );

          if (isLarge) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(child: purgeBlock),
                const SizedBox(width: 48),
                Container(width: 1, height: 120, color: Colors.grey[300]),
                const SizedBox(width: 48),
                Expanded(child: restartBlock),
              ]
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: [
                purgeBlock,
                const SizedBox(height: 32),
                Container(width: double.infinity, height: 1, color: Colors.grey[300]),
                const SizedBox(height: 32),
                restartBlock,
              ]
            );
          }
        }
      ),
    );
  }
}
