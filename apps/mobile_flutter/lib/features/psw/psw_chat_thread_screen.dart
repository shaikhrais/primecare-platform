import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PswChatThreadScreen extends StatelessWidget {
  final String threadId;
  final String title;

  const PswChatThreadScreen({super.key, required this.threadId, required this.title});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: PrimeCareAppBar(title: title),
      body: DesktopPaneWrapper(
        child: PrimeCareColumn(
          children: [
            PrimeCareExpanded(
              child: PrimeCareListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _buildReceivedBubble(
                    'Hey! We have an urgent shift coverage needed for Eliza Thornberry today due to a cancellation.', 
                    '10:42 AM'
                  ),
                  const PrimeCareSizedBox(height: 24),
                  _buildPhysicalShiftWidget(context),
                ],
              ),
            ),
            
            PrimeCareCard(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              
              child: PrimeCareSafeArea(
                child: PrimeCareRow(
                  children: [
                    PrimeCareExpanded(
                      child: PrimeCareCard(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: PrimeCareColors.slate400),
                          ),
                        ),
                      ),
                    ),
                    const PrimeCareSizedBox(width: 16),
                    PrimeCareCard(
                      padding: const EdgeInsets.all(12),
                      
                      child: const PrimeCareIcon(Icons.send_rounded, color: Colors.white, size: 24),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedBubble(String text, String time) {
    return PrimeCareColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimeCareCard(
          padding: const EdgeInsets.all(16),
          
          child: PrimeCareText(text, style: const TextStyle(fontSize: 16, color: PrimeCareColors.radarDark, height: 1.4)),
        ),
        const PrimeCareSizedBox(height: 4),
        PrimeCareText(time, style: const TextStyle(color: PrimeCareColors.slate400, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPhysicalShiftWidget(BuildContext context) {
    return PrimeCareColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimeCareCard(
          padding: const EdgeInsets.all(24),
          
          child: PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimeCareCard(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    
                    child: const PrimeCareText('URGENT DISPATCH', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                  const PrimeCareText('Surge +1.5x active', style: TextStyle(color: PrimeCareColors.emerald, fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              const PrimeCareSizedBox(height: 20),
              const PrimeCareText('4:00 PM - 8:00 PM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
              const PrimeCareSizedBox(height: 8),
              const PrimeCareText('Eliza Thornberry • 99 Safari Rd, Etobicoke', style: TextStyle(color: PrimeCareColors.slate300, fontSize: 14)),
              const PrimeCareSizedBox(height: 24),
              PrimeCareRow(
                children: [
                  PrimeCareExpanded(
                    child: PrimeCareButton(type: PrimeCareButtonType.primary, 
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: PrimeCareText('Shift Accepted. Added to Dashboard.')));
                      },
                      
                      child: const PrimeCareText('ACCEPT SHIFT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),
                  const PrimeCareSizedBox(width: 12),
                  PrimeCareExpanded(
                    child: PrimeCareButton(type: PrimeCareButtonType.secondary, 
                      onPressed: () {},
                      
                      child: const PrimeCareText('DECLINE', style: TextStyle(color: PrimeCareColors.slate300)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const PrimeCareSizedBox(height: 4),
        const PrimeCareText('10:45 AM', style: TextStyle(color: PrimeCareColors.slate400, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
