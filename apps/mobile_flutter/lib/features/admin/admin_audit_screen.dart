import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AdminAuditScreen extends StatefulWidget {
  const AdminAuditScreen({super.key});

  @override
  State<AdminAuditScreen> createState() => _AdminAuditScreenState();
}

class _AdminAuditScreenState extends State<AdminAuditScreen> {
  late Timer _logTimer;
  final Random _rnd = Random();
  
  // Live Metrics
  String _complianceScore = '99.9%';
  int _threatBlocks = 2144;
  int _activeSessions = 482;

  final List<Map<String, dynamic>> _auditLogs = [
    {'time': 'Just now', 'event': 'Root Access Token Minted', 'region': 'US-East', 'severity': 'CRITICAL', 'ip': '10.2.4.X', 'color': Color(0xFFF43F5E)},
    {'time': '2m ago', 'event': 'Unauthorized API Mutation Blocked', 'region': 'AP-South', 'severity': 'WARNING', 'ip': '192.168.1.X', 'color': Colors.orange},
    {'time': '15m ago', 'event': 'SOC2 Encrypted Backup Completed', 'region': 'CA-Central', 'severity': 'INFO', 'ip': 'Internal', 'color': Color(0xFF3B82F6)},
    {'time': '1h ago', 'event': 'Ghost Node Provisioned', 'region': 'EU-West', 'severity': 'WARNING', 'ip': 'Worker Edge', 'color': Colors.orange},
    {'time': '3h ago', 'event': 'Global MFA Policy Enforced', 'region': 'System', 'severity': 'INFO', 'ip': 'Root', 'color': Color(0xFF3B82F6)},
  ];

  final List<String> _simulatedEvents = [
    'Failed Login Attempt',
    'Tenant Route Refresh',
    'Database Vacuum Triggered',
    'Cross-Origin Request Blocked',
    'JWT Token Expired Segregation'
  ];

  bool _isExporting = false;
  bool _isEnforcing = false;

  @override
  void initState() {
    super.initState();
    // Simulate incoming security logs
    _logTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          if (_rnd.nextBool()) {
            _threatBlocks += _rnd.nextInt(3) + 1;
            
            // Add a new log occasionally
            if (_rnd.nextInt(3) == 0) {
              _auditLogs.insert(0, {
                'time': 'Just now',
                'event': _simulatedEvents[_rnd.nextInt(_simulatedEvents.length)],
                'region': ['US-East', 'CA-Central', 'EU-West', 'AP-South'][_rnd.nextInt(4)],
                'severity': 'INFO',
                'ip': '10.X.X.${_rnd.nextInt(255)}',
                'color': Color(0xFF3B82F6)
              });
              
              if (_auditLogs.length > 8) {
                _auditLogs.removeLast();
              }
            }
          }
          
          if (_rnd.nextBool()) {
            _activeSessions += _rnd.nextInt(5) - 2;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _logTimer.cancel();
    super.dispose();
  }

  Future<void> _handleExport() async {
    setState(() => _isExporting = true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() => _isExporting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cryptographic SOC2 Compliance PDF successfully generated and encrypted.', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Color(0xFF059669))
      );
    }
  }

  Future<void> _handleEnforce() async {
    setState(() => _isEnforcing = true);
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      setState(() {
        _isEnforcing = false;
        _complianceScore = '100.0%';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Global MFA Override successfully pushed to all Cloudflare Edge Tenants.', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Color(0xFF0EA5E9))
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
            Text('Live Security Event Ledger', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
            const SizedBox(height: 16),
            _buildAuditList(),
            const SizedBox(height: 32),
            Text('Root Authorization Controls', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
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
        Icon(Icons.security_rounded, size: 48, color: Color(0xFFF43F5E)), 
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Security Audit & Compliance Node', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
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
        _buildMetricBox('SOC2/HIPAA Score', _complianceScore, Icons.verified_user, _complianceScore == '100.0%' ? Color(0xFF10B981) : Color(0xFF3B82F6)),
        _buildMetricBox('Active Sessions', '$_activeSessions', Icons.people_alt, Color(0xFF8B5CF6)),
        _buildMetricBox('Threats Blocked (24h)', '$_threatBlocks', Icons.gpp_bad, Color(0xFFF43F5E)),
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

  Widget _buildAuditList() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: _auditLogs.map((log) {
          final isLast = _auditLogs.last == log;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: log['color'].withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(log['severity'], style: TextStyle(color: log['color'], fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(log['event'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text('Region: ${log['region']} | IP: ${log['ip']}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        ],
                      ),
                    ),
                    Text(log['time'], style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              if (!isLast) Divider(height: 1, color: Colors.grey.withValues(alpha: 0.2)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCommandCenter() {
    return PrimeCareCard(
      padding: const EdgeInsets.all(32),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isLarge = constraints.maxWidth > 700;
          
          Widget mfaBlock = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global MFA Override', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Forcefully disconnect all active tenants across the edge and require strict Multi-Factor Authentication re-entry.', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 24),
              PrimeCareButton(
                type: PrimeCareButtonType.primary,
                onPressed: _isEnforcing ? null : _handleEnforce,
                child: _isEnforcing 
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text('Enforce Global MFA', style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          );

          Widget generateBlock = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cryptographic Report Generator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Extracts the immutable 90-day ledger logs into an encrypted PDF validating strict SOC2/HIPAA compliance locally.', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 24),
              PrimeCareButton(
                type: PrimeCareButtonType.secondary,
                onPressed: _isExporting ? null : _handleExport,
                child: _isExporting 
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.picture_as_pdf, color: Theme.of(context).primaryColor, size: 18),
                          const SizedBox(width: 8),
                          Text('Export Compliance PDF', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
              )
            ],
          );

          if (isLarge) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(child: mfaBlock),
                const SizedBox(width: 48),
                Container(width: 1, height: 120, color: Colors.grey[300]),
                const SizedBox(width: 48),
                Expanded(child: generateBlock),
              ]
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: [
                mfaBlock,
                const SizedBox(height: 32),
                Container(width: double.infinity, height: 1, color: Colors.grey[300]),
                const SizedBox(height: 32),
                generateBlock,
              ]
            );
          }
        }
      ),
    );
  }
}
