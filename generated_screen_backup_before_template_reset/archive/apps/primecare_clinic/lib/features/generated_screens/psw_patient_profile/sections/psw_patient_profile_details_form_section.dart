import 'package:flutter/material.dart';

class PswPatientProfileDetailsFormSection extends StatelessWidget {
  const PswPatientProfileDetailsFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('psw_patient_profile_details_form-section'),
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
