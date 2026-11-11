import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';

class CooServiceDeliveryHeaderSection extends StatelessWidget {
  const CooServiceDeliveryHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('coo_service_delivery_header-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PrimeText('Header Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
