import '../../../../flutter_core.dart';
import '../../domain/repositories/scheduler_repository.dart';
import '../view_models/scheduler_notifier.dart';

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
