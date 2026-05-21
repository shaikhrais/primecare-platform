import 'package:flutter/material.dart';

class MarketingManagerDashboardScreen extends StatelessWidget {
  const MarketingManagerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1800),
            child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.campaign, size: 40, color: Colors.pink.shade700),
                const SizedBox(width: 16),
                Text("Marketing Dashboard", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink.shade700)),
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
                      Icon(Icons.campaign, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Marketing Dashboard actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          ),
        ),
    );
  }
}
