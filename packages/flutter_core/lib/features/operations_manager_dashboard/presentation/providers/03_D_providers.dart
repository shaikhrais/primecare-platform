// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_operations_manager_repository.dart';
import '../view_models/04_V_operations_manager_notifier.dart';

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
