import '../../../../flutter_core.dart';
import '../../domain/repositories/scrum_master_repository.dart';
import '../view_models/scrum_master_notifier.dart';

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
