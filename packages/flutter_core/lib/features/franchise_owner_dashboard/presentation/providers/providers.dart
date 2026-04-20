import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_owner_repository.dart';
import '../view_models/franchise_owner_notifier.dart';

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
