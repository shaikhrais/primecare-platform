// Governance - Category: view | Purpose: UI Screen component rendering the Psw Care Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class PswCareDashboardScreen extends StatelessWidget {
  const PswCareDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1800),
            child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.home, size: 32, color: Colors.teal),
                const SizedBox(width: 12),
                Text('Care Dashboard', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal)),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.home, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('Care Dashboard module is natively active.', style: const TextStyle(fontSize: 18, color: Colors.black54)),
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