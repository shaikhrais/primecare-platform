import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/custom_app_bar.dart';

class TerritoryAssignmentsScreen extends StatefulWidget {
  const TerritoryAssignmentsScreen({super.key});

  @override
  State<TerritoryAssignmentsScreen> createState() => _TerritoryAssignmentsScreenState();
}

class _TerritoryAssignmentsScreenState extends State<TerritoryAssignmentsScreen> {
  final List<Map<String, dynamic>> _territories = [
    {
      'name': 'North District (Downtown)',
      'manager': 'Alex Johnson',
      'activeStaff': 24,
      'activeClients': 156,
      'status': 'Optimal',
    },
    {
      'name': 'South District (Suburbs)',
      'manager': 'Sam Smith',
      'activeStaff': 18,
      'activeClients': 180,
      'status': 'High Demand',
    },
    {
      'name': 'East District (Riverside)',
      'manager': 'Jordan Lee',
      'activeStaff': 12,
      'activeClients': 85,
      'status': 'Optimal',
    },
    {
      'name': 'West District (Hilllands)',
      'manager': 'Taylor Swift',
      'activeStaff': 8,
      'activeClients': 42,
      'status': 'Low Coverage',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Territory Assignments',
        subtitle: 'Manage regional service areas and capacity',
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          // Add new territory
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _territories.length,
        itemBuilder: (context, index) {
          final territory = _territories[index];
          final isHighDemand = territory['status'] == 'High Demand';
          final isLowCoverage = territory['status'] == 'Low Coverage';

          Color statusColor = AppColors.success;
          if (isHighDemand) statusColor = AppColors.warning;
          if (isLowCoverage) statusColor = AppColors.error;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          territory['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          territory['status'],
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Managed by: ${territory['manager']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetric('Active Staff', '${territory['activeStaff']}', Icons.groups),
                      _buildMetric('Active Clients', '${territory['activeClients']}', Icons.person_pin),
                      _buildMetric('Ratio', '${(territory['activeClients'] / territory['activeStaff']).toStringAsFixed(1)}', Icons.calculate),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            // Reassign staff
                          },
                          child: const Text('Reassign Staff'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            // View Details
                          },
                          child: const Text('View Mapping'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
