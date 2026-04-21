// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_owner_repository.dart';
import '../view_models/04_V_franchise_owner_notifier.dart';

final franchiseOwnerRepositoryProvider = Provider<IFranchiseOwnerRepository>((
  ref,
) {
  return FranchiseOwnerRepository(ref.watch(dashboardServiceProvider));
});

final franchiseOwnerNotifierProvider =
    NotifierProvider<
      FranchiseOwnerNotifier,
      AsyncValue<FranchiseOwnerDashboardViewModel>
    >(FranchiseOwnerNotifier.new);
