import 'package:flutter/material.dart';

class CaregiverClientProfileDetailsFormSection extends StatelessWidget {
  const CaregiverClientProfileDetailsFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('caregiver_client_profile_details_form-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Details Form Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
