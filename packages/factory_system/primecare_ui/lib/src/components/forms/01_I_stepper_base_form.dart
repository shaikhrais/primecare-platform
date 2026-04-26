// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

/// Represents a single step in the StepperBaseForm.
class FormStep {
  final String title;
  final String? subtitle;
  final Widget content;

  /// Called right before advancing to the next step.
  /// If it returns false, the stepper will stay on the current step.
  final bool Function() validate;

  FormStep({
    required this.title,
    this.subtitle,
    required this.content,
    required this.validate,
  });
}

/// A standardized wrapper for complex multi-step data entry forms.
class StepperBaseForm extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<FormStep> steps;
  final Future<void> Function() onSubmit;
  final VoidCallback? onCancel;
  final bool isLoading;
  final String? errorMessage;
  final String submitText;

  const StepperBaseForm({
    super.key,
    required this.title,
    this.subtitle,
    required this.steps,
    required this.onSubmit,
    this.onCancel,
    this.isLoading = false,
    this.errorMessage,
    this.submitText = 'Submit',
  });

  @override
  State<StepperBaseForm> createState() => _StepperBaseFormState();
}

class _StepperBaseFormState extends State<StepperBaseForm> {
  int _currentStep = 0;

  void _onStepContinue() {
    // If we're loading, swallow the action
    if (widget.isLoading) return;

    // Run the local step validation
    final isValid = widget.steps[_currentStep].validate();
    if (!isValid) return;

    if (_currentStep < widget.steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Reached the end, trigger submit
      widget.onSubmit();
    }
  }

  void _onStepCancel() {
    if (widget.isLoading) return;

    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      widget.onCancel?.call();
    }
  }

  void _onStepTapped(int stepIndex) {
    if (widget.isLoading) return;

    // Optional: We can allow tapping previous steps, but block jumping ahead
    // unless the current step is valid. For strictness, we only allow jumping back.
    if (stepIndex < _currentStep) {
      setState(() {
        _currentStep = stepIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                widget.subtitle!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (widget.errorMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: theme.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.errorMessage!,
                        style: TextStyle(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            AbsorbPointer(
              absorbing: widget.isLoading,
              child: Opacity(
                opacity: widget.isLoading ? 0.6 : 1.0,
                child: Stepper(
                  currentStep: _currentStep,
                  onStepContinue: _onStepContinue,
                  onStepCancel: _onStepCancel,
                  onStepTapped: _onStepTapped,
                  type: isDesktop
                      ? StepperType.horizontal
                      : StepperType.vertical,
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                        final isLastStep =
                            _currentStep == widget.steps.length - 1;

                        return Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: details.onStepContinue,
                                child: widget.isLoading && isLastStep
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        isLastStep ? widget.submitText : 'Next',
                                      ),
                              ),
                              const SizedBox(width: 16),
                              if (_currentStep > 0 || widget.onCancel != null)
                                TextButton(
                                  onPressed: details.onStepCancel,
                                  child: Text(
                                    _currentStep > 0 ? 'Back' : 'Cancel',
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                  steps: widget.steps.map((step) {
                    final index = widget.steps.indexOf(step);
                    return Step(
                      title: Text(step.title),
                      subtitle: step.subtitle != null
                          ? Text(step.subtitle!)
                          : null,
                      content: step.content,
                      isActive: _currentStep >= index,
                      state: _currentStep > index
                          ? StepState.complete
                          : (_currentStep == index
                                ? StepState.editing
                                : StepState.indexed),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
