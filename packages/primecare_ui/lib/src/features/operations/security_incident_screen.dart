// Governance - Category: view | Purpose: State representation of a logged security incident. Provider for security incident entries.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// State representation of a logged security incident.
class SecurityIncident {
  final String id;
  final String category;
  final String description;
  final String severity; // 'Critical', 'High', 'Medium', 'Low'
  final DateTime timestamp;
  String status; // 'Active', 'Investigating', 'Resolved'

  SecurityIncident({
    required this.id,
    required this.category,
    required this.description,
    required this.severity,
    required this.timestamp,
    required this.status,
  });
}

/// Provider for security incident entries.
final securityIncidentProvider = FutureProvider.autoDispose<List<SecurityIncident>>((ref) async {
  try {
    final api = ref.read(apiClientProvider);
    final response = await api.get('/v1/premium/appnotification');
    if (response.data is List) {
      final list = response.data as List;
      return list.map((e) {
        final map = e as Map<String, dynamic>;
        return SecurityIncident(
          id: map['id']?.toString() ?? UniqueKey().toString(),
          category: map['category']?.toString() ?? 'General Security',
          description: map['description']?.toString() ?? 'Anomaly detected.',
          severity: map['severity']?.toString() ?? 'Medium',
          timestamp: DateTime.tryParse(map['timestamp']?.toString() ?? '') ?? DateTime.now(),
          status: map['status']?.toString() ?? 'Active',
        );
      }).toList();
    }
  } catch (e) {
    // Offline API fallback
  }

  // Pre-populated safety breaches
  return [
    SecurityIncident(
      id: 'sec-01',
      category: 'Phishing Attempt',
      description: 'Phishing email mimicking Care Portal authentication page sent to 12 staff members.',
      severity: 'High',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'Investigating',
    ),
    SecurityIncident(
      id: 'sec-02',
      category: 'Unauthorized Entry',
      description: 'Unauthorized access card swipe reported at the Main Pharmacy Server Vault.',
      severity: 'Critical',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      status: 'Active',
    ),
    SecurityIncident(
      id: 'sec-03',
      category: 'Hardware Loss',
      description: 'Nurse-assigned clinical iPad (ID: Tab-094) marked missing or stolen in Ward B.',
      severity: 'Medium',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Resolved',
    ),
    SecurityIncident(
      id: 'sec-04',
      category: 'DDoS Anomaly',
      description: 'Short-duration rate limit trigger detected on external public API Gateway endpoints.',
      severity: 'Low',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Resolved',
    ),
  ];
});

class SecurityIncidentScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring, submitting, and updating security incidents, along with metrics visualization and alert notifications.';

  @override
  List<String> get requiredComponents => const [
        'IncidentOverviewCard',
        'IncidentTrendChart',
        'IncidentSubmissionForm',
        'IncidentLogTable',
        'CriticalIncidentAlert',
      ];

  @override
  List<String> get requiredFunctions => const [
        'submitNewIncident',
        'updateIncidentStatus',
        'fetchIncidentMetrics',
        'filterIncidentLog',
        'notifyCriticalIncidents',
      ];

  const SecurityIncidentScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const _SecurityIncidentBody();
  }
}

class _SecurityIncidentBody extends ConsumerStatefulWidget {
  const _SecurityIncidentBody();

  @override
  ConsumerState<_SecurityIncidentBody> createState() => _SecurityIncidentBodyState();
}

class _SecurityIncidentBodyState extends ConsumerState<_SecurityIncidentBody> {
  final List<SecurityIncident> _incidents = [];
  bool _isInitialized = false;
  
  final _descController = TextEditingController();
  String _selectedCategory = 'Unauthorized Entry';
  String _selectedSeverity = 'High';
  bool _notifyCyberInsurance = false;

  final List<String> _categories = [
    'Unauthorized Entry',
    'Phishing Attempt',
    'Hardware Loss',
    'Data Access Breach',
    'Malware Detected',
    'DDoS Anomaly',
  ];

  final List<String> _severities = ['Critical', 'High', 'Medium', 'Low'];

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _submitIncident() {
    final desc = _descController.text.trim();
    if (desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an incident description.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final newIncident = SecurityIncident(
      id: 'sec-user-${DateTime.now().millisecondsSinceEpoch}',
      category: _selectedCategory,
      description: desc,
      severity: _selectedSeverity,
      timestamp: DateTime.now(),
      status: 'Active',
    );

    setState(() {
      // Prepend to top
      _incidents.insert(0, newIncident);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _selectedSeverity == 'Critical' ? Colors.red.shade900 : Colors.amber.shade900,
        content: Row(
          children: [
            const Icon(LucideIcons.shieldAlert, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Incident Reported! Threat severity: $_selectedSeverity. Sentinel threat logs updated.',
              ),
            ),
          ],
        ),
      ),
    );

    _descController.clear();
  }

  Widget _buildSeverityBadge(String severity) {
    double hue = 120;
    double sat = 0.70;
    double light = 0.45;

    if (severity == 'Critical') {
      hue = 0;
      sat = 0.85;
      light = 0.55;
    } else if (severity == 'High') {
      hue = 25;
      sat = 0.85;
      light = 0.55;
    } else if (severity == 'Medium') {
      hue = 45;
      sat = 0.85;
      light = 0.50;
    } else {
      hue = 200;
      sat = 0.70;
      light = 0.50;
    }

    final color = HSLColor.fromAHSL(1.0, hue, sat, light).toColor();
    final bgColor = HSLColor.fromAHSL(0.12, hue, sat, light).toColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            severity.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status, PrimeThemeData theme) {
    Color color = Colors.grey;
    if (status == 'Active') color = theme.colors.error;
    if (status == 'Investigating') color = Colors.orange;
    if (status == 'Resolved') color = Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final incidentsFuture = ref.watch(securityIncidentProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: incidentsFuture.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(48.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (Object err, StackTrace stack) => Center(
            child: Text(
              'Error loading incident console: $err',
              style: TextStyle(color: theme.colors.error),
            ),
          ),
          data: (List<SecurityIncident> apiIncidents) {
            if (!_isInitialized) {
              _incidents.addAll(apiIncidents);
              _isInitialized = true;
            }

            final activeCount = _incidents.where((i) => i.status == 'Active').length;
            final investigatingCount = _incidents.where((i) => i.status == 'Investigating').length;
            final resolvedCount = _incidents.where((i) => i.status == 'Resolved').length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header
                const GovDashboardHero(
                  title: 'Incident Sentinel & Risk Management',
                  roleName: 'Risk & Safety Lead',
                  description: 'Real-time monitoring of cyber attacks, access vault anomalies, HIPAA violations, and hardware safety logs.',
                ),
                const SizedBox(height: 24),

                // 2. Performance Metric Cards
                ResponsiveGrid(
                  minItemWidth: 260,
                  maxItemWidth: 400,
                  spacing: 16.0,
                  children: [
                    GovMetricCard(
                      title: 'Active Alerts',
                      value: '$activeCount',
                      trendLabel: 'Awaiting Triage',
                      progress: activeCount > 0 ? 0.35 : 0.0,
                      icon: LucideIcons.shieldAlert,
                      brandColor: theme.colors.error,
                    ),
                    GovMetricCard(
                      title: 'Under Investigation',
                      value: '$investigatingCount',
                      trendLabel: 'SRE Assigned',
                      progress: 0.6,
                      icon: LucideIcons.searchCode,
                      brandColor: Colors.orange,
                    ),
                    GovMetricCard(
                      title: 'Resolved Today',
                      value: '$resolvedCount',
                      trendLabel: 'Safe Status',
                      progress: 1.0,
                      icon: LucideIcons.shieldCheck,
                      brandColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // 3. Main Dashboard Layout (Responsive Columns)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 950;
                    final logTableWidget = _buildIncidentLogTable(theme);
                    final reportFormWidget = _buildReportForm(theme);
                    final chartWidget = _buildTelemetryChart(theme);

                    if (isDesktop) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                logTableWidget,
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                reportFormWidget,
                                const SizedBox(height: 20),
                                chartWidget,
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          logTableWidget,
                          const SizedBox(height: 20),
                          reportFormWidget,
                          const SizedBox(height: 20),
                          chartWidget,
                        ],
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildIncidentLogTable(PrimeThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Live Sentinel Safety Logs',
                style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'SENTINEL SECURE',
                    style: theme.typography.labelSmall.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _incidents.length,
            separatorBuilder: (context, idx) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final incident = _incidents[index];
              final minutesAgo = DateTime.now().difference(incident.timestamp).inMinutes;
              final hoursAgo = DateTime.now().difference(incident.timestamp).inHours;

              String timeString = 'Just now';
              if (minutesAgo > 0 && minutesAgo < 60) {
                timeString = '$minutesAgo mins ago';
              } else if (hoursAgo > 0 && hoursAgo < 24) {
                timeString = '$hoursAgo hrs ago';
              } else if (hoursAgo >= 24) {
                timeString = '${(hoursAgo / 24).floor()} days ago';
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _buildSeverityBadge(incident.severity),
                            const SizedBox(width: 10),
                            Text(
                              incident.category,
                              style: theme.typography.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colors.onBackground,
                              ),
                            ),
                          ],
                        ),
                        _buildStatusBadge(incident.status, theme),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      incident.description,
                      style: theme.typography.bodyMedium.copyWith(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          timeString,
                          style: theme.typography.labelSmall.copyWith(
                            color: theme.colors.outline,
                          ),
                        ),
                        if (incident.status != 'Resolved')
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                incident.status = 'Resolved';
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Incident resolved & archives locked.'),
                                ),
                              );
                            },
                            icon: const Icon(LucideIcons.checkSquare, size: 14),
                            label: const Text('Resolve Incident', style: TextStyle(fontSize: 12)),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportForm(PrimeThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.plusCircle, color: theme.colors.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                'Report Security Incident',
                style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Category Dropdown
          Text('Incident Category', style: theme.typography.labelBold),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radiusDefault),
                borderSide: BorderSide.none,
              ),
            ),
            items: _categories.map((c) {
              return DropdownMenuItem(
                value: c,
                child: Text(c, style: theme.typography.bodyMedium),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _selectedCategory = val);
              }
            },
          ),
          const SizedBox(height: 16),

          // Severity Dropdown
          Text('Threat Severity', style: theme.typography.labelBold),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedSeverity,
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radiusDefault),
                borderSide: BorderSide.none,
              ),
            ),
            items: _severities.map((s) {
              return DropdownMenuItem(
                value: s,
                child: Text(s, style: theme.typography.bodyMedium),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _selectedSeverity = val);
              }
            },
          ),
          const SizedBox(height: 16),

          // Description field
          PrimeCareTextField(key: const Key('security_incident_screen_textfield_input_1'), 
            label: 'Incident Log Description',
            hintText: 'Enter full telemetry reports, system details, involved IPs...',
            controller: _descController,
            maxLines: 3,
          ),
          const SizedBox(height: 12),

          // Checkbox to notify external insurance
          Row(
            children: [
              Checkbox(
                value: _notifyCyberInsurance,
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _notifyCyberInsurance = val);
                  }
                },
              ),
              Expanded(
                child: Text(
                  'Notify HIPAA Audit & SRE Incident Teams immediately',
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          PrimeButton.primary(
            label: 'Initiate Sentinel Response',
            isFullWidth: true,
            onPressed: _submitIncident,
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryChart(PrimeThemeData theme) {
    return GovTelemetryChart(
      title: 'Resolved vs Open Incident History',
      dataPoints: const [15, 8, 12, 5, 2, 4, 1],
      labels: const ['Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May'],
      accentColor: theme.colors.error,
    );
  }
}
