// Governance - Category: view | Purpose: UI Screen component rendering the Territory Expansion Manager Expansion Plans Screen workspace interface.
import 'package:flutter/material.dart';

class TerritoryExpansionManagerExpansionPlansScreen extends StatelessWidget {
  const TerritoryExpansionManagerExpansionPlansScreen({Key? key}) : super(key: key);

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
                Icon(Icons.next_plan, size: 40, color: Colors.orange.shade700),
                const SizedBox(width: 16),
                Text("Expansion Plans", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
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
                      Icon(Icons.next_plan, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Expansion Plans actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
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