import 'package:flutter/material.dart';

class AdminOutstandingBalancesScreen extends StatelessWidget {
  const AdminOutstandingBalancesScreen({Key? key}) : super(key: key);

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
                Icon(Icons.account_balance_wallet, size: 40, color: Colors.grey.shade800),
                const SizedBox(width: 16),
                Text("Outstanding Balances", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
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
                      Icon(Icons.account_balance_wallet, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Outstanding Balances actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
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
