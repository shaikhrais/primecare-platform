import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class PhysiotherapistViewModel {
  final String title;
  final List<String> sessions;

  const PhysiotherapistViewModel({
    required this.title,
    required this.sessions,
  });

  factory PhysiotherapistViewModel.initial() {
    return const PhysiotherapistViewModel(
      title: 'Physiotherapy Rehabilitation Center',
      sessions: ['10:00 AM - Knee Rehab', '2:00 PM - Post-Op Assessment'],
    );
  }
}
