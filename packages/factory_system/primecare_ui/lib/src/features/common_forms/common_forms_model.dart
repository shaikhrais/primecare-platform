import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class CommonFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;

  const CommonFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
  });

  factory CommonFormsViewModel.initial() {
    return const CommonFormsViewModel(
      availableForms: [
        'Real Estate',
        'System Access',
        'Care Pod',
        'Training',
        'Compliance',
        'Supply Order',
        'Shift Adjustment',
        'Fleet Maintenance',
      ],
      selectedForm: 'Real Estate',
    );
  }
}
