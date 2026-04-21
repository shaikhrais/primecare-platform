// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_partnership_manager_repository.dart';
import '../view_models/04_V_partnership_manager_notifier.dart';

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
