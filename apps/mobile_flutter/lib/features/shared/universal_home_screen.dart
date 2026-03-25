import 'package:flutter/material.dart';

class UniversalHomeScreen extends StatelessWidget {
  final String rolePrefix;

  const UniversalHomeScreen({super.key, required this.rolePrefix});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${rolePrefix.toUpperCase()} Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard, size: 64, color: Colors.blue.shade200),
            const SizedBox(height: 16),
            Text(
              'Welcome, $rolePrefix',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your metrics are fully optimized and integrated organically.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
