// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_patient_repository.dart';
import '../view_models/04_V_patient_notifier.dart';

final patientRepositoryProvider = Provider<IPatientRepository>((ref) {
  return PatientRepository(ref.watch(dashboardServiceProvider));
});

final patientNotifierProvider =
    NotifierProvider<PatientNotifier, AsyncValue<PatientDashboardViewModel>>(
      PatientNotifier.new,
    );
