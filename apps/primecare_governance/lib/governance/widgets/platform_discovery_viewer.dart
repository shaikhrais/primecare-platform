import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/network_parity_service.dart';

/// A premium widget that displays the results of the platform-wide microservice discovery audit.
class PlatformDiscoveryViewer extends ConsumerStatefulWidget {
  final String baseUrl;

  const PlatformDiscoveryViewer({super.key, required this.baseUrl});

  @override
  ConsumerState<PlatformDiscoveryViewer> createState() => _PlatformDiscoveryViewerState();
}

class _PlatformDiscoveryViewerState extends ConsumerState<PlatformDiscoveryViewer> {
  Map<String, dynamic>? _discoveryData;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDiscoveryData();
  }

  Future<void> _loadDiscoveryData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final service = NetworkParityService(baseUrl: widget.baseUrl);
      final data = await service.fetchPlatformAudit();
      
      if (data.containsKey('error')) {
        setState(() {
          _error = data['error'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _discoveryData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
            SizedBox(height: 16),
            Text('Scanning Mesh Architecture...', style: TextStyle(letterSpacing: 1.2, fontSize: 12)),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Discovery Protocol Failed', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red)),
              const SizedBox(height: 8),
              Text('$_error', style: const TextStyle(color: Colors.red, fontSize: 12)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadDiscoveryData,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Re-initialize Discovery'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_discoveryData == null || _discoveryData!['discovery'] == null) {
      return const Center(child: Text('No discovery data available.'));
    }

    final discovery = _discoveryData!['discovery'] as Map<String, dynamic>;
    final services = discovery.keys.toList()..sort();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.webhook, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Microservice Mesh Discovery',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                    ),
                    Text(
                      'Real-time visualization of platform architecture and route distribution.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: _loadDiscoveryData,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Sync Mesh'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildStatsHeader(services.length, discovery),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: services.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final serviceName = services[index];
                final serviceData = discovery[serviceName] as Map<String, dynamic>;
                final routes = List<String>.from(serviceData['routes'] ?? []);

                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    shape: const RoundedRectangleBorder(side: BorderSide.none),
                    collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withValues(alpha: 0.1),
                      child: const Icon(Icons.settings_input_component, color: Colors.blue, size: 18),
                    ),
                    title: Text(
                      serviceName.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    subtitle: Text(
                      'Entry: ${serviceData['entry'] ?? 'Unknown'}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${routes.length} Active Endpoints',
                        style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const SizedBox(height: 8),
                            const Text(
                              'ARCHITECTURE ROUTE MAP',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 1.2, color: Colors.blue),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: routes.map((route) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.api, size: 12, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      route,
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(int serviceCount, Map<String, dynamic> discovery) {
    int totalRoutes = 0;
    discovery.forEach((_, data) {
      totalRoutes += (data['routes'] as List).length;
    });

    return Row(
      children: [
        _buildStatCard('Services', serviceCount.toString(), Icons.cloud_queue, Colors.blue),
        const SizedBox(width: 16),
        _buildStatCard('Endpoints', totalRoutes.toString(), Icons.link, Colors.green),
        const SizedBox(width: 16),
        _buildStatCard('Readiness', 'High', Icons.verified_user_outlined, Colors.orange),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
