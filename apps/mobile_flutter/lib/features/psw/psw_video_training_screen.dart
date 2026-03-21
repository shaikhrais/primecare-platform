import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';
import '../../core/widgets/primecare_app_bar.dart';

class PswVideoTrainingScreen extends StatelessWidget {
  final String videoId;
  final String title;

  const PswVideoTrainingScreen({super.key, required this.videoId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareAppBar(title: 'Compliance Module'),
      body: Center(
        child: DesktopPaneWrapper(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Simulated Pip Video Canvas
            Container(
              height: 250,
              width: double.infinity,
              color: PrimeCareColors.radarDark,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Opacity(
                    opacity: 0.1,
                    child: Icon(Icons.videocam_rounded, color: Colors.white, size: 100),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0x33FFFFFF), shape: BoxShape.circle),
                    child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
                  ),
                  Positioned(
                    bottom: 16, right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
                      child: const Text('14:22', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  )
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  const Text('Mandatory Video Module • Cannot be skipped', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                  
                  const Text('KNOWLEDGE VERIFICATION QUIZ', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
                  const SizedBox(height: 16),
                  
                  // Mandatory Quiz Matrix
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: PrimeCareColors.slate200),
                      boxShadow: const [BoxShadow(color: const Color(0x0A000000) /* Soft Shadow */, blurRadius: 16, offset: Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Question 1: What is the recommended compression depth for adult CPR?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark, height: 1.5)),
                        const SizedBox(height: 24),
                        _buildQuizOption('1 inch', false),
                        _buildQuizOption('2 inches (Min)', true),
                        _buildQuizOption('3 inches', false),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {}, // Blocked until right answer is clicked and video parsed
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      minimumSize: const Size(double.infinity, 64),
                      backgroundColor: PrimeCareColors.slate200, // Disabled color state initially
                    ),
                    child: const Text('SUBMIT MODULE & CERTIFY', style: TextStyle(color: PrimeCareColors.slate400)),
                  )
                ],
              ),
            )
          ],
        ),
      )
        ),
      ),
    );
  }

  Widget _buildQuizOption(String label, bool isSelectedFakeState) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelectedFakeState ? const Color(0x1110B981) : Colors.transparent,
        border: Border.all(color: isSelectedFakeState ? PrimeCareColors.emerald : PrimeCareColors.slate200, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(isSelectedFakeState ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelectedFakeState ? PrimeCareColors.emerald : PrimeCareColors.slate300),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontWeight: isSelectedFakeState ? FontWeight.bold : FontWeight.w600, color: PrimeCareColors.radarDark)),
        ],
      ),
    );
  }
}
