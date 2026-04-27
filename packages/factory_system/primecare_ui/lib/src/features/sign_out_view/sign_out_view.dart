import 'package:primecare_ui/primecare_ui.dart';

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
  SignOutIntent() : super(title: "SignOut");

  @override
  Widget build(BuildContext context) => const SignOutView();
}


