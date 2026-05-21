import 'package:flutter/material.dart';

class ClinicalReferenceScreen extends StatelessWidget {
  const ClinicalReferenceScreen({Key? key}) : super(key: key);

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
                const Icon(Icons.menu_book, size: 40, color: Colors.brown),
                const SizedBox(width: 16),
                Text("Clinical Reference", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown)),
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
                      const Icon(Icons.menu_book, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Clinical Reference actively running.", style: const TextStyle(fontSize: 20, color: Colors.black54)),
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