// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_scheduler_repository.dart';
import '../view_models/04_V_scheduler_notifier.dart';

final Provider<ISchedulerRepository> schedulerRepositoryProvider =
    Provider<ISchedulerRepository>((Ref ref) {
      return SchedulerRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  SchedulerNotifier,
  AsyncValue<SchedulerDashboardViewModel>
>
schedulerDashboardProvider =
    NotifierProvider<
      SchedulerNotifier,
      AsyncValue<SchedulerDashboardViewModel>
    >(SchedulerNotifier.new);
