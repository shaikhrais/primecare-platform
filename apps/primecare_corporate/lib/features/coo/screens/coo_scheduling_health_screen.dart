// Governance - Category: view | Purpose: UI Screen component rendering the Coo Scheduling Health Screen workspace interface.
import 'package:flutter/material.dart';

class CooSchedulingHealthScreen extends StatelessWidget {
  const CooSchedulingHealthScreen({Key? key}) : super(key: key);

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
                Icon(Icons.event_available, size: 40, color: Colors.teal.shade900),
                const SizedBox(width: 16),
                Text("Scheduling Health", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal.shade900)),
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
                      Icon(Icons.event_available, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Scheduling Health actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
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
