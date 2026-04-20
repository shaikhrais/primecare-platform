import '../../../../flutter_core.dart';
import '../../domain/repositories/patient_repository.dart';
import '../view_models/patient_notifier.dart';

final patientRepositoryProvider = Provider<IPatientRepository>((ref) {
  return PatientRepository(ref.watch(dashboardServiceProvider));
});

final patientNotifierProvider =
    NotifierProvider<PatientNotifier, AsyncValue<PatientDashboardViewModel>>(
      PatientNotifier.new,
    );
