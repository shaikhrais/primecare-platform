import 'package:flutter/material.dart';

class ConsentConsentContentSection extends StatelessWidget {
  const ConsentConsentContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('consent_consent_content-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Consent Content Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
