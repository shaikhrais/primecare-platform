import '../../../../flutter_core.dart';
import '../../domain/repositories/operations_manager_repository.dart';
import '../view_models/operations_manager_notifier.dart';

final Provider<IOperationsManagerRepository>
operationsManagerRepositoryProvider = Provider<IOperationsManagerRepository>((
  Ref ref,
) {
  return OperationsManagerRepository(ref.watch(domainServiceProvider));
});

final NotifierProvider<
  OperationsManagerNotifier,
  AsyncValue<OperationsManagerDashboardViewModel>
>
operationsManagerDashboardProvider =
    NotifierProvider<
      OperationsManagerNotifier,
      AsyncValue<OperationsManagerDashboardViewModel>
    >(OperationsManagerNotifier.new);
