import 'package:flutter/material.dart';

class RegionalBdmPartnersScreen extends StatelessWidget {
  const RegionalBdmPartnersScreen({Key? key}) : super(key: key);

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
                Icon(Icons.group_work, size: 40, color: Colors.indigo.shade600),
                const SizedBox(width: 16),
                Text("Partners", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo.shade600)),
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
                      Icon(Icons.group_work, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Partners actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
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