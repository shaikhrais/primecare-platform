import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubmitIntent extends Intent {
  const SubmitIntent();
}

/// A standardized form wrapper that provides consistent padding,
/// validation state handling, and normalized submit/cancel buttons.
class BaseForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final VoidCallback onSubmit;
  final VoidCallback? onCancel;
  final String submitText;
  final bool isLoading;
  final bool isEnabled;

  const BaseForm({
    super.key,
    required this.formKey,
    required this.title,
    this.subtitle,
    required this.children,
    required this.onSubmit,
    this.onCancel,
    this.submitText = 'Submit',
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        LogicalKeySet(LogicalKeyboardKey.enter): const SubmitIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          SubmitIntent: CallbackAction<SubmitIntent>(
            onInvoke: (SubmitIntent intent) {
              if (!isLoading && isEnabled && (formKey.currentState?.validate() ?? false)) {
                onSubmit();
              }
              return null;
            },
          ),
        },
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              AbsorbPointer(
                absorbing: isLoading,
                child: Opacity(
                  opacity: isLoading ? 0.6 : 1.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onCancel != null)
                    TextButton(
                      onPressed: isLoading ? null : onCancel,
                      child: const Text('Cancel'),
                    ),
                  if (onCancel != null) const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: (isLoading || !isEnabled)
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              onSubmit();
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(submitText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.
