import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class QualityAssuranceDashboardScreen extends StatefulWidget {
  const QualityAssuranceDashboardScreen({super.key});

  @override
  State<QualityAssuranceDashboardScreen> createState() => _QualityAssuranceDashboardScreenState();
}

class _QualityAssuranceDashboardScreenState extends State<QualityAssuranceDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quality Assurance Dashboard'),
        backgroundColor: const Color(0xFF0F766E),
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
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: const [
                              Icon(LucideIcons.checkCircle, size: 48, color: Colors.green),
                              SizedBox(height: 16),
                              Text('94%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                              Text('Audit Completion Rate', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: const [
                              Icon(LucideIcons.alertOctagon, size: 48, color: Colors.orange),
                              SizedBox(height: 16),
                              Text('12', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                              Text('Incidents Pending Review', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: const [
                              Icon(LucideIcons.activity, size: 48, color: Colors.blue),
                              SizedBox(height: 16),
                              Text('98%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                              Text('Clinical Outcome Target', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Recent Incident Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Location')),
                            DataColumn(label: Text('Category')),
                            DataColumn(label: Text('Severity')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: [
                            _incidentRow('Oct 15', 'Toronto Clinic', 'Medication Error', 'Medium', 'Under Review'),
                            _incidentRow('Oct 14', 'Vancouver Hub', 'Slip and Fall', 'Low', 'Resolved'),
                            _incidentRow('Oct 12', 'Home Care (Region 4)', 'Protocol Breach', 'High', 'Investigation'),
                          ],
                        ),
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

  DataRow _incidentRow(String date, String location, String category, String severity, String status) {
    Color severityColor = Colors.orange;
    if (severity == 'High') severityColor = Colors.red;
    if (severity == 'Low') severityColor = Colors.yellow.shade800;

    return DataRow(cells: [
      DataCell(Text(date)),
      DataCell(Text(location)),
      DataCell(Text(category)),
      DataCell(Chip(label: Text(severity, style: const TextStyle(color: Colors.white)), backgroundColor: severityColor)),
      DataCell(Text(status, style: const TextStyle(fontWeight: FontWeight.bold))),
    ]);
  }
}
