// Governance - Category: view | Purpose: UI Screen component rendering the Clinic History Logs Screen workspace interface.
import 'package:flutter/material.dart';

class ClinicHistoryLogsScreen extends StatelessWidget {
  const ClinicHistoryLogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Clinical History Logs', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.history)),
                    title: Text('System Audit Event #${1000 - index}'),
                    subtitle: Text('Performed by System \n${DateTime.now().subtract(Duration(hours: index)).toString()}'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}