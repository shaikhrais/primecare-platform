// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_clinic_repository.dart';
import '../view_models/04_V_clinic_notifier.dart';

final clinicRepositoryProvider = Provider<IClinicRepository>((ref) {
  return ClinicRepository(ref.watch(dashboardServiceProvider));
});

final clinicNotifierProvider =
    NotifierProvider<ClinicNotifier, AsyncValue<ClinicDashboardViewModel>>(
      ClinicNotifier.new,
    );
