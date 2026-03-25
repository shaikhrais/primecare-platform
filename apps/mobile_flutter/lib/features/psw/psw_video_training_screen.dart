import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PswVideoTrainingScreen extends StatelessWidget {
  final String videoId;
  final String title;

  const PswVideoTrainingScreen({
    super.key,
    required this.videoId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: SingleChildScrollView(
            child: PrimeCareColumn(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Simulated Pip Video Canvas
                PrimeCareContainer(
                  height: 250,
                  width: double.infinity,
                  color: PrimeCareColors.radarDark,
                  child: PrimeCareStack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.1,
                        child: PrimeCareIcon(
                          Icons.videocam_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                      PrimeCareCard(
                        padding: EdgeInsets.all(16),

                        child: PrimeCareIcon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: PrimeCareCard(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),

                          child: PrimeCareText(
                            '14:22',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                PrimeCarePadding(
                  padding: EdgeInsets.all(24.0),
                  child: PrimeCareColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimeCareText(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 8),
                      PrimeCareText(
                        'Mandatory Video Module • Cannot be skipped',
                        style: TextStyle(
                          color: PrimeCareColors.slate500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 32),

                      PrimeCareText(
                        'KNOWLEDGE VERIFICATION QUIZ',
                        style: TextStyle(
                          color: PrimeCareColors.radarDark,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Mandatory Quiz Matrix
                      PrimeCareCard(
                        padding: EdgeInsets.all(24),

                        child: PrimeCareColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimeCareText(
                              'Question 1: What is the recommended compression depth for adult CPR?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: PrimeCareColors.radarDark,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 24),
                            _buildQuizOption('1 inch', false),
                            _buildQuizOption('2 inches (Min)', true),
                            _buildQuizOption('3 inches', false),
                          ],
                        ),
                      ),

                      SizedBox(height: 32),
                      PrimeCareButton(
                        type: PrimeCareButtonType.primary,
                        onPressed:
                            () {}, // Blocked until right answer is clicked and video parsed

                        child: PrimeCareText(
                          'SUBMIT MODULE & CERTIFY',
                          style: TextStyle(color: PrimeCareColors.slate400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizOption(String label, bool isSelectedFakeState) {
    return PrimeCareCard(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),

      child: PrimeCareRow(
        children: [
          PrimeCareIcon(
            isSelectedFakeState
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: isSelectedFakeState
                ? PrimeCareColors.emerald
                : PrimeCareColors.slate300,
          ),
          SizedBox(width: 12),
          PrimeCareText(
            label,
            style: TextStyle(
              fontWeight: isSelectedFakeState
                  ? FontWeight.bold
                  : FontWeight.w600,
              color: PrimeCareColors.radarDark,
            ),
          ),
        ],
      ),
    );
  }
}
