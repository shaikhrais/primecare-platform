import 'package:flutter/material.dart';

class SocialWorkerDashboardScreen extends StatefulWidget {
  const SocialWorkerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<SocialWorkerDashboardScreen> createState() => _SocialWorkerDashboardScreenState();
}

class _SocialWorkerDashboardScreenState extends State<SocialWorkerDashboardScreen> {
  final List<String> _cases = ['Family Outreach - Case #3912', 'Mental Health Eval - Patient #102', 'Housing Assistance - Case #204'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Social Worker Case Management'), backgroundColor: Colors.purple),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const Text('Active Cases', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple)),
            const SizedBox(height: 16),
            ..._cases.map((c) => Card(
              child: ListTile(
                leading: const Icon(Icons.folder_shared, color: Colors.purple),
                title: Text(c, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('High Priority - Needs Follow Up'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening \$c...')));
                  },
                ),
              ),
            )).toList(),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Open New Case File'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(56)),
            )
          ],
        ),
        ),
      ),
      ),
    );
  }
}