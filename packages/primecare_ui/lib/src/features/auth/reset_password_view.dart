// Governance - Category: view | Purpose: Core implementation file for the Reset Password View platform logic.
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:ui';

class ResetPasswordView extends GovernedScreen {
  const ResetPasswordView({super.key});

  @override
  String get featureId => 'auth.reset_password';

  @override
  String get requiredRole => 'Public';

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(resetPasswordControllerProvider);

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
                        children: [_ResetPasswordCard(state: state)],
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

class _ResetPasswordCard extends ConsumerWidget {
  final ResetPasswordState state;
  const _ResetPasswordCard({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final controller = ref.read(resetPasswordControllerProvider.notifier);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Set New Password',
                style: theme.typography.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter and confirm your new password',
                style: theme.typography.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (state.isSuccess) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Password updated successfully. You can now login.',
                    style: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ] else ...[
                _InputField(
                  label: 'NEW PASSWORD',
                  placeholder: '••••••••',
                  icon: Icons.key_outlined,
                  initialValue: state.newPassword,
                  onChanged: controller.onNewPasswordChanged,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                _InputField(
                  label: 'CONFIRM PASSWORD',
                  placeholder: '••••••••',
                  icon: Icons.key_outlined,
                  initialValue: state.confirmPassword,
                  onChanged: controller.onConfirmPasswordChanged,
                  obscureText: true,
                ),
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    state.errorMessage!,
                    style: theme.typography.labelMedium.copyWith(
                      color: theme.colors.error,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(key: const Key('reset_password_view_elevatedbutton_button_1'), 
                    onPressed: controller.submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('UPDATE PASSWORD'),
                  ),
              ],
            ],
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
  final bool obscureText;

  const _InputField({
    required this.label,
    required this.placeholder,
    required this.icon,
    required this.initialValue,
    required this.onChanged,
    this.obscureText = false,
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
          obscureText: obscureText,
          style: theme.typography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
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
            ),
          ),
        ),
      ],
    );
  }
}
