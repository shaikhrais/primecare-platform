// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/design_system/clinical_glass.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

    hide isOnlineProvider, ProviderTTL;

class SignOutView extends ConsumerWidget {
  const SignOutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_sign_out_page_view.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__sign_out_page_view
              .tr(),
        ),
      ),
    );
  }
}

class SignOutIntent extends PrimeCareScreen {
  SignOutIntent() : super(title: 'SignOut',
          componentLabels: const ['Aura HUD (Session End)', 'Logout Confirmation', 'Telemetry Sync'],
        );

  @override
  Widget build(BuildContext context) => const SignOutView();
}
