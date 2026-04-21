// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_general_manager_repository.dart';
import '../view_models/04_V_general_manager_notifier.dart';

final generalManagerRepositoryProvider = Provider<IGeneralManagerRepository>((
  ref,
) {
  return GeneralManagerRepository(ref.watch(domainServiceProvider));
});

final generalManagerDashboardProvider =
    NotifierProvider<
      GeneralManagerNotifier,
      AsyncValue<GeneralManagerDashboardViewModel>
    >(GeneralManagerNotifier.new);
