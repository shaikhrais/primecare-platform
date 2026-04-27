import 'package:primecare_ui/primecare_ui.dart';

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
  SignUpIntent() : super(title: "SignUp");

  @override
  Widget build(BuildContext context) => const SignUpView();
}


