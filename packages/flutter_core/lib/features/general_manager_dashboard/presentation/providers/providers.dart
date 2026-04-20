import '../../../../flutter_core.dart';
import '../../domain/repositories/general_manager_repository.dart';
import '../view_models/general_manager_notifier.dart';

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
