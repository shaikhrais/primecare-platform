class ClinicalFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;
  final bool isSubmitting;

  const ClinicalFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
    this.isSubmitting = false,
  });

  factory ClinicalFormsViewModel.initial() {
    return const ClinicalFormsViewModel(
      availableForms: [
        'Medication Refill',
        'Daily Vitals',
        'Clinical Incident',
        'Infection Control',
        'Care Plan Review',
        'Clinical Audit',
        'ADL Checklist',
        'Daily Census',
      ],
      selectedForm: 'Medication Refill',
    );
  }

  ClinicalFormsViewModel copyWith({
    List<String>? availableForms,
    String? selectedForm,
    bool? isSubmitting,
  }) {
    return ClinicalFormsViewModel(
      availableForms: availableForms ?? this.availableForms,
      selectedForm: selectedForm ?? this.selectedForm,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
