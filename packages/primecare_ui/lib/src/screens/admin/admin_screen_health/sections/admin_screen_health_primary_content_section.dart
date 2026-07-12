import 'package:flutter/material.dart';

class AdminScreenHealthPrimaryContentSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const AdminScreenHealthPrimaryContentSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'admin_screen_health_primary_content_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Primary Content Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
