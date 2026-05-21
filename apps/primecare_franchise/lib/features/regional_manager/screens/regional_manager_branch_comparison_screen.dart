import 'package:flutter/material.dart';

class RegionalManagerBranchComparisonScreen extends StatelessWidget {
  const RegionalManagerBranchComparisonScreen({Key? key}) : super(key: key);

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
                Icon(Icons.compare, size: 40, color: Colors.orange.shade700),
                const SizedBox(width: 16),
                Text("Branch Comparison", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
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
                      Icon(Icons.compare, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Branch Comparison actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
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
