import 'package:flutter/material.dart';

class DocumentVault extends StatelessWidget {
  const DocumentVault({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Vault')),
      body: const Center(
        child: Text('Secure Document Storage', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
