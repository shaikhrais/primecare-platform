// Governance - Category: view | Purpose: UI Screen component rendering the Rn Medications Screen workspace interface.
import 'package:flutter/material.dart';

class RnMedicationsScreen extends StatefulWidget {
  const RnMedicationsScreen({Key? key}) : super(key: key);

  @override
  State<RnMedicationsScreen> createState() => _RnMedicationsScreenState();
}

class _RnMedicationsScreenState extends State<RnMedicationsScreen> {
  final List<Map<String, dynamic>> _meds = [
    {'patient': 'John Doe', 'med': 'Lisinopril 10mg', 'time': '12:00 PM', 'status': 'Pending'},
    {'patient': 'Mary Smith', 'med': 'Metformin 500mg', 'time': '1:00 PM', 'status': 'Pending'},
    {'patient': 'Alice Johnson', 'med': 'Atorvastatin 20mg', 'time': '8:00 AM', 'status': 'Administered'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Medication Administration (MAR)'), backgroundColor: Colors.indigo),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _meds.length,
          itemBuilder: (context, index) {
            final med = _meds[index];
            final isDone = med['status'] == 'Administered';
            return Card(
              color: isDone ? Colors.green.shade50 : Colors.white,
              child: ListTile(
                leading: Icon(Icons.medication, color: isDone ? Colors.green : Colors.red, size: 40),
                title: Text('${med['med']} - ${med['time']}', style: TextStyle(fontWeight: FontWeight.bold, decoration: isDone ? TextDecoration.lineThrough : null)),
                subtitle: Text('Patient: ${med['patient']}'),
                trailing: isDone
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                        onPressed: () {
                          setState(() {
                            _meds[index]['status'] = 'Administered';
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged administration of ${med['med']}')));
                        },
                        child: const Text('Administer'),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}