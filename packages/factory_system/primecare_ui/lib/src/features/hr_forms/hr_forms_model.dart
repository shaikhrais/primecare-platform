import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class HrFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;
  final bool isSubmitting;

  const HrFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
    this.isSubmitting = false,
  });

  factory HrFormsViewModel.initial() {
    return const HrFormsViewModel(
      availableForms: [
        'Leave Request',
        'Grievance',
        'Onboarding',
        'Interview',
        'Exit Interview',
      ],
      selectedForm: 'Leave Request',
    );
  }

  HrFormsViewModel copyWith({
    List<String>? availableForms,
    String? selectedForm,
    bool? isSubmitting,
  }) {
    return HrFormsViewModel(
      availableForms: availableForms ?? this.availableForms,
      selectedForm: selectedForm ?? this.selectedForm,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
