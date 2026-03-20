import 'package:flutter/material.dart';
import '../../core/widgets/primecare_app_bar.dart';

class PswClinicalNotesScreen extends StatelessWidget {
  const PswClinicalNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const PrimeCareAppBar(title: 'Clinical Progress Note'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            // Focused Massive Body Composition Sheet
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 16, offset: Offset(0, 4))],
              ),
              child: TextField(
                maxLines: 15,
                style: const TextStyle(fontSize: 18, color: Color(0xFF334155), height: 1.5),
                decoration: InputDecoration(
                  hintText: 'Describe patient mood, physical changes, or any incidents occurring during this active shift...',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(24),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Native Attachment Tooling
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: (){},
                    icon: const Icon(Icons.camera_alt, color: Color(0xFF0F172A)),
                    label: const Text('Add Image', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: (){},
                    icon: const Icon(Icons.mic, color: Color(0xFF0F172A)),
                    label: const Text('Audio Memo', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 48), // Padding Before Anchor Bottom
            ElevatedButton(
              onPressed: () {
                // Return gracefully mimicking local state update
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: const Text('Progress Note Appended Securely'),
                     backgroundColor: const Color(0xFF0F172A),
                     behavior: SnackBarBehavior.floating,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                   )
                );
              },
              child: const Text('SAVE CLINICAL NOTE'),
            )
          ],
        ),
      )
        ),
      ),
    );
  }
}
