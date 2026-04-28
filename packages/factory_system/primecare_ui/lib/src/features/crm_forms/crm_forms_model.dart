class CrmFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;

  const CrmFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
  });

  factory CrmFormsViewModel.initial() {
    return const CrmFormsViewModel(
      availableForms: [
        'Franchise Lead',
        'Disclosure Approval',
        'Lead Assignment',
        'Ad Placement',
        'Vetting Call',
        'Market Share',
        'Marketing Budget',
      ],
      selectedForm: 'Franchise Lead',
    );
  }
}
