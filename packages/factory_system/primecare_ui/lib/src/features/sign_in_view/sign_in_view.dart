import 'package:primecare_ui/primecare_ui.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_sign_in_page_view.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__sign_in_page_view
              .tr(),
        ),
      ),
    );
  }
}

class SignInIntent extends PrimeCareScreen {
  SignInIntent() : super(title: "SignIn");

  @override
  Widget build(BuildContext context) => const SignInView();
}


