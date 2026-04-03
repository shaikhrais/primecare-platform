import 'package:flutter/material.dart';

class CfoTopbar extends StatelessWidget {
  const CfoTopbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.blueGrey.withValues(alpha: 0.1)))),
      child: const Row(
        children: [
          Text('PRIMECARE CFO PORTAL', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
          Spacer(),
          Icon(Icons.account_balance),
        ],
      ),
    );
  }
}
