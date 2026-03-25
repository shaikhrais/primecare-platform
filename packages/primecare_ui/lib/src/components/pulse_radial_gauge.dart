import 'package:flutter/material.dart';

class PulseRadialGauge extends StatelessWidget {
  const PulseRadialGauge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue.shade100, width: 12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '88',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              'Health Score',
              style: TextStyle(fontSize: 10, color: Colors.blue.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
