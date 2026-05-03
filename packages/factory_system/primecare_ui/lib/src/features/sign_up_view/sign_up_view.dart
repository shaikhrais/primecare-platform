// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/design_system/clinical_glass.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

    hide isOnlineProvider, ProviderTTL;

class SignUpView extends ConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_sign_up_page_view.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__sign_up_page_view
              .tr(),
        ),
      ),
    );
  }
}

class SignUpIntent extends PrimeCareScreen {
  SignUpIntent() : super(title: 'SignUp',
          componentLabels: const ['Aura HUD (Onboarding)', 'Registration Form', 'Identity Verification'],
        );

  @override
  Widget build(BuildContext context) => const SignUpView();
}
