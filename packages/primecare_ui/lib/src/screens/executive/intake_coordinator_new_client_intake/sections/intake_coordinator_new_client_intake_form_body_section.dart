import 'package:flutter/material.dart';

class IntakeCoordinatorNewClientIntakeFormBodySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const IntakeCoordinatorNewClientIntakeFormBodySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'intake_coordinator_new_client_intake_form_body_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Form Body Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
