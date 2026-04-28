import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/shared/controller_infrastructure.dart';

class PatientDashboardController {
  final WidgetRef ref;

  PatientDashboardController(this.ref);

  void refresh() {
    ref.invalidate(patientDashboardAdapterProvider);
  }
}
