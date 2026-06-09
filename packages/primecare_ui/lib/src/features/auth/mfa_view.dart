// Governance - Category: view | Purpose: Core implementation file for the Mfa View platform logic.
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:ui';

class MfaView extends GovernedScreen {
  @override
  String get screenDescription =>
      'The screen requires a code input field for a 6-digit code, a submit button, and components to display verification status, error messages, and loading indicators.';

  @override
  List<String> get requiredComponents => const [
        'CodeInputField',
        'VerificationStatusDisplay',
        'ErrorMessageDisplay',
        'LoadingIndicator',
        'VerificationHistory',
      ];

  @override
  List<String> get requiredFunctions => const [
        'validateCode',
        'submitCodeForVerification',
        'displayVerificationResult',
        'showErrorMessage',
        'indicateLoadingStatus',
      ];

  const MfaView({super.key});

  @override
  String get featureId => 'auth.mfa';

  @override
  String get requiredRole => 'Public';

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(mfaControllerProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: theme.spacing.xl),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [_MfaCard(state: state)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MfaCard extends ConsumerStatefulWidget {
  final MfaState state;
  const _MfaCard({required this.state});

  @override
  ConsumerState<_MfaCard> createState() => _MfaCardState();
}

class _MfaCardState extends ConsumerState<_MfaCard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = ref.read(mfaControllerProvider.notifier);

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: EdgeInsets.all(theme.spacing.xxl),
          decoration: BoxDecoration(
            color: theme.colors.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: theme.colors.border.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Two-Factor Authentication',
                  style: theme.typography.h3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the 6-digit code from your authenticator app',
                  style: theme.typography.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (widget.state.isVerified) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Identity verified successfully.',
                      style: theme.typography.bodyMedium.copyWith(
                        color: theme.colors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ] else ...[
                  _InputField(
                    label: 'AUTHENTICATION CODE',
                    placeholder: '000000',
                    icon: Icons.lock_outline,
                    initialValue: widget.state.code,
                    onChanged: controller.onCodeChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Authentication code is required';
                      if (value.length != 6) return 'Code must be exactly 6 digits';
                      return null;
                    },
                  ),
                  if (widget.state.errorMessage != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      widget.state.errorMessage!,
                      style: theme.typography.labelMedium.copyWith(
                        color: theme.colors.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  if (widget.state.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    ElevatedButton(key: const Key('mfa_view_elevatedbutton_button_1'), 
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.verify();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('VERIFY CODE'),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;

  const _InputField({
    required this.label,
    required this.placeholder,
    required this.icon,
    required this.initialValue,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: theme.typography.labelMedium.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: theme.colors.onSurfaceVariant,
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          maxLength: 6,
          keyboardType: TextInputType.number,
          style: theme.typography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 8,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            counterText: '',
            prefixIcon: Icon(
              icon,
              size: 20,
              color: theme.colors.primary.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: theme.colors.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colors.primary, width: 2),
            ),
            hintStyle: theme.typography.labelMedium.copyWith(
              color: theme.colors.onSurfaceVariant.withValues(alpha: 0.4),
              letterSpacing: 8,
            ),
          ),
        ),
      ],
    );
  }
}
