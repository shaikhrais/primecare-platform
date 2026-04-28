class ChiropractorViewModel {
  final String title;
  final List<String> appointments;

  const ChiropractorViewModel({
    required this.title,
    required this.appointments,
  });

  factory ChiropractorViewModel.initial() {
    return const ChiropractorViewModel(
      title: 'Chiropractic Care Portal',
      appointments: [
        '9:00 AM - Spinal Adjustment',
        '11:30 AM - Initial Assessment',
      ],
    );
  }
}
