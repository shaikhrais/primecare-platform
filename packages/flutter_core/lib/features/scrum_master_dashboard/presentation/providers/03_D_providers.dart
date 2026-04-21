// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_scrum_master_repository.dart';
import '../view_models/04_V_scrum_master_notifier.dart';

final Provider<IScrumMasterRepository> scrumMasterRepositoryProvider =
    Provider<IScrumMasterRepository>((Ref ref) {
      return ScrumMasterRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  ScrumMasterNotifier,
  AsyncValue<ScrumMasterDashboardViewModel>
>
scrumMasterDashboardProvider =
    NotifierProvider<
      ScrumMasterNotifier,
      AsyncValue<ScrumMasterDashboardViewModel>
    >(ScrumMasterNotifier.new);
