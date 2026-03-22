import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswEvvCheckoutScreen extends StatelessWidget {
  const PswEvvCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: PrimeCareAppBar(title: AppLocalizations.of(context)!.shiftCheckoutProtocol),
      body: PrimeCareSafeArea(
        child: PrimeCarePadding(
          padding: EdgeInsets.all(24.0),
          child: PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // High Fidelity Validation Badge
              PrimeCareIcon(Icons.verified_user_rounded, size: 80, color: PrimeCareColors.emerald),
              SizedBox(height: 24),
              PrimeCareText(
                'Verification Complete', 
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: PrimeCareColors.emerald), 
                textAlign: TextAlign.center
              ),
              SizedBox(height: 12),
              PrimeCareText(
                'All mandatory Schedule Tasks have been intercepted. Please provide client signature verification to officially break the EVV lock.', 
                textAlign: TextAlign.center, 
                style: TextStyle(color: PrimeCareColors.slate500, fontSize: 16, height: 1.5)
              ),
              
              SizedBox(height: 40),
              
              PrimeCareText(
                'CLIENT CONSENT SIGNATURE',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: PrimeCareColors.slate500, letterSpacing: 1.2),
              ),
              SizedBox(height: 12),
              
              // Signature Pad Native Frame (Placeholder layout for tactile interaction)
              PrimeCareExpanded(
                child: PrimeCareCard(
                  
                  child: PrimeCareCenter(
                    child: PrimeCareColumn(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimeCareIcon(Icons.draw_rounded, color: PrimeCareColors.slate300, size: 48),
                        SizedBox(height: 12),
                        PrimeCareText('Client must sign here using their finger', style: TextStyle(color: PrimeCareColors.slate400, fontSize: 16)),
                      ],
                    ),
                  )
                ),
              ),
              
              SizedBox(height: 40),
              
              // Termination Interaction
              PrimeCareButton(type: PrimeCareButtonType.primary, 
                onPressed: () {
                   HapticFeedback.heavyImpact();
                   // Pop multiple stacks representing completion of flow natively
                   Navigator.of(context).pop(); 
                },
                
                child: PrimeCareText('SECURE CHECKOUT & END SHIFT', style: TextStyle(letterSpacing: 0.5)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
