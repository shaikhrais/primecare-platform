import 'package:flutter/material.dart';

class ErrorMonitoringScreen extends StatelessWidget {
  const ErrorMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> errors = [
      {
        'project': 'primecare_client',
        'file': 'lib/screens/dashboard.dart',
        'error':
            'The method \'withOpacity\' is deprecated and shouldn\'t be used. Use withValues instead.',
        'severity': 'Warning',
      },
      {
        'project': 'governance_service',
        'file': 'bin/server.dart',
        'error': 'Unhandled exception: Database connection timeout.',
        'severity': 'Critical',
      },
      {
        'project': 'primecare_adapters',
        'file': 'lib/src/registry/06_G_3d_governance.dart',
        'error': 'Missing type annotation for \'registryNodes\'.',
        'severity': 'Warning',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Error & Warning Monitor',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Active issues across the PrimeCare workspace.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: errors.length,
            itemBuilder: (context, index) {
              final error = errors[index];
              final isCritical = error['severity'] == 'Critical';
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isCritical
                        ? Colors.red.withValues(alpha: 0.3)
                        : const Color(0xFFe5e7eb),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isCritical ? Icons.error : Icons.warning,
                      color: isCritical ? Colors.red : Colors.orange,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                error['project']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFf3f4f6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  error['file']!,
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                    color: Color(0xFF4b5563),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error['error']!,
                            style: TextStyle(
                              color: isCritical
                                  ? Colors.red.shade700
                                  : Colors.black87,
                              fontSize: 14,
                            ),
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
    );
  }
}
