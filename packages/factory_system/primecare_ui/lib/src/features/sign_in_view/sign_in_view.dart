// PRIMECARE CONSOLIDATED FILE
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: currentFlowStep=Completed
import 'package:primecare_ui/src/design_system/clinical_glass.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: lifecycleStatus=completed
// @governance: component=Standard Actions

    hide isOnlineProvider, ProviderTTL;

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await ref.read(authProvider.notifier).login(
          _emailController.text,
          _passwordController.text,
        );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (!success) {
      setState(() {
        _errorMessage = 'Invalid credentials or connection error.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_sign_in_page_view.tr(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocaleKeys
                      .dashboards_common_labels_operational_sector__sign_in_page_view
                      .tr(),
                  style: theme.typography.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: theme.spacing.xl),
                PrimeCareTextField(
                  label: 'Email Address',
                  placeholder: 'e.g. governance@primecare.com',
                  controller: _emailController,
                ),
                SizedBox(height: theme.spacing.md),
                PrimeCareTextField(
                  label: 'Secure Password',
                  placeholder: '••••••••',
                  controller: _passwordController,
                  obscureText: true,
                ),
                if (_errorMessage != null) ...[
                  SizedBox(height: theme.spacing.md),
                  Text(
                    _errorMessage!,
                    style: theme.typography.labelSmall.copyWith(
                      color: theme.colors.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: theme.spacing.xl),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  PrimeCareButton(
                    onPressed: _handleLogin,
                    label: 'Authenticate Access',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInIntent extends PrimeCareScreen {
  SignInIntent() : super(title: 'SignIn',
          componentLabels: const ['Aura HUD (Auth Velocity)', 'Identity Field', 'Password Field', 'MFA Module'],
        );

  @override
  Widget build(BuildContext context) => const SignInView();
}
