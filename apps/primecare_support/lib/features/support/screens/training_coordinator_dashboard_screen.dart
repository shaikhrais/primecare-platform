import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TrainingCoordinatorDashboardScreen extends StatefulWidget {
  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  State<TrainingCoordinatorDashboardScreen> createState() => _TrainingCoordinatorDashboardScreenState();
}

class _TrainingCoordinatorDashboardScreenState extends State<TrainingCoordinatorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Coordinator Dashboard'),
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(color: Colors.indigo[50], shape: BoxShape.circle),
                                child: const Icon(LucideIcons.graduationCap, color: Color(0xFF4F46E5)),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Active Trainees', style: TextStyle(color: Colors.grey)),
                                  Text('45', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(color: Colors.red[50], shape: BoxShape.circle),
                                child: const Icon(LucideIcons.alertTriangle, color: Colors.red),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Overdue Certifications', style: TextStyle(color: Colors.grey)),
                                  Text('12', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(color: Colors.green[50], shape: BoxShape.circle),
                                child: const Icon(LucideIcons.checkSquare, color: Colors.green),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Course Completion Rate', style: TextStyle(color: Colors.grey)),
                                  Text('88%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('New Hire Onboarding Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        _OnboardingRow(name: 'Sarah Jenkins', role: 'Registered Nurse', progress: 0.9),
                        _OnboardingRow(name: 'Kevin Hart', role: 'Personal Support Worker', progress: 0.4),
                        _OnboardingRow(name: 'David Smith', role: 'Physiotherapist', progress: 0.1),
                        _OnboardingRow(name: 'Amanda Brooks', role: 'Administrative Assistant', progress: 1.0),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingRow extends StatelessWidget {
  final String name;
  final String role;
  final double progress;

  const _OnboardingRow({required this.name, required this.role, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.grey[200], child: const Icon(LucideIcons.user, color: Colors.black54)),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(role, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(child: LinearProgressIndicator(value: progress, minHeight: 8, backgroundColor: Colors.grey[200], color: const Color(0xFF4F46E5))),
                const SizedBox(width: 16),
                Text('${(progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
