// Governance - Category: view | Purpose: UI Screen component rendering the Cfo Tax And Remittance Screen workspace interface.
import 'package:flutter/material.dart';

class CfoTaxAndRemittanceScreen extends StatelessWidget {
  const CfoTaxAndRemittanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calculate, size: 40, color: Colors.green.shade800),
                const SizedBox(width: 16),
                Text("Tax And Remittance", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green.shade800)),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calculate, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Tax And Remittance actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
