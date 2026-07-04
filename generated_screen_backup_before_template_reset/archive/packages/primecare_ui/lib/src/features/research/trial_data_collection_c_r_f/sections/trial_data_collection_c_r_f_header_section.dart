import 'package:flutter/material.dart';

class TrialDataCollectionCRFHeaderSection extends StatelessWidget {
  const TrialDataCollectionCRFHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('trial_data_collection_c_r_f_header-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Header Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
