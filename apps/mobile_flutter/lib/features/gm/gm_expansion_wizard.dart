import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GmExpansionWizardScreen extends StatelessWidget {
  const GmExpansionWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: const PrimeCareAppBar(title: 'FRANCHISE EXPANSION'),
      body: PrimeCareWizardFlow(
        title: 'FRANCHISE EXPANSION',
        subtitle: 'HOW TO START A NEW LOCATION',
        actionLabel: 'INITIATE NEW LOCATION LAUNCH',
        onAction: () {},
        steps: const [
          PrimeCareWizardStep(title: 'Identify Underserved Zip Codes', description: 'Run algorithm against Medicare demographics to target aging populations with low PrimeCare Node density.', icon: Icons.map_rounded),
          PrimeCareWizardStep(title: 'Incorporate Ghost Node', description: 'Digitally register a new LLC and Cloudflare Tenant DB instantly.', icon: Icons.domain_add_rounded),
          PrimeCareWizardStep(title: 'Aggressive PSW Recruiting', description: 'Deploy localized Zip-Recruiter & Indeed API bursts to hire 15+ Core Providers in the target zone.', icon: Icons.people_alt_rounded),
          PrimeCareWizardStep(title: 'B2B Referral Initialization', description: 'Auto-Generate marketing packets to local hospitals and Geriatric specialists within 10 miles.', icon: Icons.handshake_rounded),
          PrimeCareWizardStep(title: 'Launch Geofenced Ad Campaign', description: 'Allocate \$5k starting budget to Facebook/Google Ads hitting a strict 15-mile radius of the new Node.', icon: Icons.campaign_rounded),
        ],
      )
    );
  }
}
