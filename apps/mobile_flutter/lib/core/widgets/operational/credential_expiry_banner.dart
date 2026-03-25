import 'package:flutter/material.dart';

/// Auto-Scaffolded Component: [CredentialExpiryBanner]
class CredentialExpiryBanner extends StatelessWidget {
  const CredentialExpiryBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.widgets_outlined, size: 24, color: Colors.blueGrey),
          SizedBox(height: 8),
          Text(
            'CredentialExpiryBanner',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Structural Node Ready',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
