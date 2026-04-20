import '../../../../flutter_core.dart';
import '../../domain/repositories/clinic_repository.dart';
import '../view_models/clinic_notifier.dart';

final clinicRepositoryProvider = Provider<IClinicRepository>((ref) {
  return ClinicRepository(ref.watch(dashboardServiceProvider));
});

final clinicNotifierProvider =
    NotifierProvider<ClinicNotifier, AsyncValue<ClinicDashboardViewModel>>(
      ClinicNotifier.new,
    );
