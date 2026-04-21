// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_head_of_bus_dev_repository.dart';
import '../view_models/04_V_head_of_bus_dev_notifier.dart';

final headOfBusDevRepositoryProvider = Provider<IHeadOfBusDevRepository>((ref) {
  return HeadOfBusDevRepository(ref.watch(domainServiceProvider));
});

final headOfBusDevDashboardProvider =
    NotifierProvider<
      HeadOfBusDevNotifier,
      AsyncValue<HeadOfBusDevDashboardViewModel>
    >(HeadOfBusDevNotifier.new);
