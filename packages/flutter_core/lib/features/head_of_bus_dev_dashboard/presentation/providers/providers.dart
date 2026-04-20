import '../../../../flutter_core.dart';
import '../../domain/repositories/head_of_bus_dev_repository.dart';
import '../view_models/head_of_bus_dev_notifier.dart';

final headOfBusDevRepositoryProvider = Provider<IHeadOfBusDevRepository>((ref) {
  return HeadOfBusDevRepository(ref.watch(domainServiceProvider));
});

final headOfBusDevDashboardProvider =
    NotifierProvider<
      HeadOfBusDevNotifier,
      AsyncValue<HeadOfBusDevDashboardViewModel>
    >(HeadOfBusDevNotifier.new);
