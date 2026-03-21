import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GmExpansionWizardScreen extends StatelessWidget {
  const GmExpansionWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareAppBar(title: AppLocalizations.of(context)!.franchiseExpansion),
      body: PrimeCareWizardFlow(
        title: AppLocalizations.of(context)!.franchiseExpansion,
        subtitle: AppLocalizations.of(context)!.howToStartANewLocation,
        actionLabel: 'INITIATE NEW LOCATION LAUNCH',
        onAction: () {},
        steps: [
          PrimeCareWizardStep(title: AppLocalizations.of(context)!.identifyUnderservedZipCodes, description: 'Run algorithm against Medicare demographics to target aging populations with low PrimeCare Node density.', icon: Icons.map_rounded),
          PrimeCareWizardStep(title: AppLocalizations.of(context)!.incorporateGhostNode, description: 'Digitally register a new LLC and Cloudflare Tenant DB instantly.', icon: Icons.domain_add_rounded),
          PrimeCareWizardStep(title: AppLocalizations.of(context)!.aggressivePswRecruiting, description: 'Deploy localized Zip-Recruiter & Indeed API bursts to hire 15+ Core Providers in the target zone.', icon: Icons.people_alt_rounded),
          PrimeCareWizardStep(title: AppLocalizations.of(context)!.b2bReferralInitialization, description: 'Auto-Generate marketing packets to local hospitals and Geriatric specialists within 10 miles.', icon: Icons.handshake_rounded),
          PrimeCareWizardStep(title: AppLocalizations.of(context)!.launchGeofencedAdCampaign, description: 'Allocate \$5k starting budget to Facebook/Google Ads hitting a strict 15-mile radius of the new Node.', icon: Icons.campaign_rounded),
        ],
      )
    );
  }
}
