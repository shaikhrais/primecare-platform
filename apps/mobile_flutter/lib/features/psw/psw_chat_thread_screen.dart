import 'package:primecare_mobile/l10n/app_localizations.dart';
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
                padding: EdgeInsets.all(24),
                children: [
                  _buildReceivedBubble(
                    'Hey! We have an urgent shift coverage needed for Eliza Thornberry today due to a cancellation.', 
                    '10:42 AM'
                  ),
                  SizedBox(height: 24),
                  _buildPhysicalShiftWidget(context),
                ],
              ),
            ),
            
            PrimeCareCard(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              
              child: PrimeCareSafeArea(
                child: PrimeCareRow(
                  children: [
                    PrimeCareExpanded(
                      child: PrimeCareCard(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.typeYourMessage,
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: PrimeCareColors.slate400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    PrimeCareCard(
                      padding: EdgeInsets.all(12),
                      
                      child: PrimeCareIcon(Icons.send_rounded, color: Colors.white, size: 24),
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
          padding: EdgeInsets.all(16),
          
          child: PrimeCareText(text, style: TextStyle(fontSize: 16, color: PrimeCareColors.radarDark, height: 1.4)),
        ),
        SizedBox(height: 4),
        PrimeCareText(time, style: TextStyle(color: PrimeCareColors.slate400, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPhysicalShiftWidget(BuildContext context) {
    return PrimeCareColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimeCareCard(
          padding: EdgeInsets.all(24),
          
          child: PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimeCareCard(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    
                    child: PrimeCareText('URGENT DISPATCH', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                  PrimeCareText('Surge +1.5x active', style: TextStyle(color: PrimeCareColors.emerald, fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              SizedBox(height: 20),
              PrimeCareText('4:00 PM - 8:00 PM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
              SizedBox(height: 8),
              PrimeCareText('Eliza Thornberry • 99 Safari Rd, Etobicoke', style: TextStyle(color: PrimeCareColors.slate300, fontSize: 14)),
              SizedBox(height: 24),
              PrimeCareRow(
                children: [
                  PrimeCareExpanded(
                    child: PrimeCareButton(type: PrimeCareButtonType.primary, 
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: PrimeCareText(AppLocalizations.of(context)!.shiftAcceptedAddedToDashboard)));
                      },
                      
                      child: PrimeCareText('ACCEPT SHIFT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),
                  SizedBox(width: 12),
                  PrimeCareExpanded(
                    child: PrimeCareButton(type: PrimeCareButtonType.secondary, 
                      onPressed: () {},
                      
                      child: PrimeCareText('DECLINE', style: TextStyle(color: PrimeCareColors.slate300)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        PrimeCareText('10:45 AM', style: TextStyle(color: PrimeCareColors.slate400, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
