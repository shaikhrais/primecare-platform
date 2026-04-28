class FamilyMemberViewModel {
  final String patientName;
  final List<String> updates;

  const FamilyMemberViewModel({
    required this.patientName,
    required this.updates,
  });

  factory FamilyMemberViewModel.initial() {
    return const FamilyMemberViewModel(
      patientName: 'John Doe',
      updates: ['Medication administered at 8:00 AM', 'Vitals checked: Normal'],
    );
  }
}
