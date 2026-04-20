import '../../../../flutter_core.dart';
import '../../domain/repositories/partnership_manager_repository.dart';
import '../view_models/partnership_manager_notifier.dart';

final Provider<IPartnershipManagerRepository>
partnershipManagerRepositoryProvider = Provider<IPartnershipManagerRepository>((
  Ref ref,
) {
  return PartnershipManagerRepository(ref.watch(domainServiceProvider));
});

final NotifierProvider<
  PartnershipManagerNotifier,
  AsyncValue<PartnershipManagerDashboardViewModel>
>
partnershipManagerDashboardProvider =
    NotifierProvider<
      PartnershipManagerNotifier,
      AsyncValue<PartnershipManagerDashboardViewModel>
    >(PartnershipManagerNotifier.new);
