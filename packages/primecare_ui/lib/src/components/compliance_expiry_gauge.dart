import 'package:flutter/material.dart';

class ComplianceExpiryGauge extends StatelessWidget {
  const ComplianceExpiryGauge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CPR Expiry Density',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: const LinearGradient(
              colors: [Colors.green, Colors.yellow, Colors.red],
            ),
          ),
        ),
      ],
    );
  }
}
