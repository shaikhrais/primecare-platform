import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RoleInductionWizardScreen extends StatefulWidget {
  final String roleName; 

  const RoleInductionWizardScreen({super.key, required this.roleName});

  @override
  State<RoleInductionWizardScreen> createState() => _RoleInductionWizardScreenState();
}

class _RoleInductionWizardScreenState extends State<RoleInductionWizardScreen> {
  bool _hasAcknowledged = false;

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      
      body: PrimeCareWizardFlow(
        title: AppLocalizations.of(context)!.mandatoryInduction,
        subtitle: AppLocalizations.of(context)!.beforeYouAreGrantedAccessTo,
        actionLabel: 'ACKNOWLEDGE & UNLOCK APP',
        onAction: _hasAcknowledged ? () {
           // Mutable trigger payload
        } : null,
        steps: [
          PrimeCareWizardStep(
            icon: Icons.school,
            title: 'ROLE DETECTED: ${widget.roleName.toUpperCase()}',
            description: widget.roleName == 'Caregiver' 
                ? '1. You are the physical backbone of this company.\n2. You must clock in EXACTLY on time via GPS EVV mapping.\n3. Failing to verify your location mathematically diminishes your TrustScore and locks you out of premium shifts.\n4. You must treat patients with absolute clinical respect.'
                : '1. Your sole objective is keeping Unfilled Shifts at absolute zero.\n2. You manage the physical dispatch maps and Haversine targeting.\n3. Do not abuse Surge Pricing; it bleeds our corporate margin.',
          )
        ],
        footerWidget: PrimeCareRow(
          children: [
            Checkbox(
              value: _hasAcknowledged,
              activeColor: Colors.blueAccent,
              onChanged: (val) => setState(() => _hasAcknowledged = val ?? false),
            ),
            PrimeCareExpanded(
              child: PrimeCareText(
                'I understand my responsibilities and the consequences of mathematical behavioral failure.', 
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(150), fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }
}
