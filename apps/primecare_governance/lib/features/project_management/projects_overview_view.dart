import 'package:flutter/material.dart';

class ProjectsOverviewScreen extends StatelessWidget {
  const ProjectsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> projects = [
      {
        'name': 'primecare_business_development',
        'status': 'Stable',
        'type': 'App',
      },
      {'name': 'primecare_client', 'status': 'Stable', 'type': 'App'},
      {'name': 'primecare_clinic', 'status': 'Stable', 'type': 'App'},
      {'name': 'primecare_corporate', 'status': 'Stable', 'type': 'App'},
      {'name': 'primecare_franchise', 'status': 'Stable', 'type': 'App'},
      {'name': 'primecare_governance', 'status': 'Active', 'type': 'App'},
      {'name': 'primecare_marketing', 'status': 'Stable', 'type': 'App'},
      {'name': 'primecare_support', 'status': 'Stable', 'type': 'App'},
      {'name': 'verification-service', 'status': 'Stable', 'type': 'Service'},
      {'name': 'governance_service', 'status': 'Active', 'type': 'Service'},
      {'name': 'primecare_adapters', 'status': 'Stable', 'type': 'Package'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Platform Projects & Services',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFe5e7eb)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      project['type'] == 'App'
                          ? Icons.apps
                          : project['type'] == 'Service'
                          ? Icons.cloud
                          : Icons.extension,
                      color: Colors.blue,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            project['type']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: project['status'] == 'Stable'
                            ? Colors.green.withValues(alpha: 0.15)
                            : Colors.blue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        project['status']!,
                        style: TextStyle(
                          color: project['status'] == 'Stable'
                              ? Colors.green
                              : Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
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
