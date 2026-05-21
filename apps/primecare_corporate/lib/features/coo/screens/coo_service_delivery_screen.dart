import 'package:flutter/material.dart';

class CooServiceDeliveryScreen extends StatelessWidget {
  const CooServiceDeliveryScreen({Key? key}) : super(key: key);

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
                Icon(Icons.local_shipping, size: 40, color: Colors.teal.shade900),
                const SizedBox(width: 16),
                Text("Service Delivery", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal.shade900)),
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
                      Icon(Icons.local_shipping, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Service Delivery actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
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
