// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_repository.dart';
import '../view_models/04_V_franchise_notifier.dart';

final franchiseRepositoryProvider = Provider<IFranchiseRepository>((ref) {
  return FranchiseRepository(ref.watch(dashboardServiceProvider));
});

final franchiseNotifierProvider =
    NotifierProvider<
      FranchiseNotifier,
      AsyncValue<FranchiseDashboardViewModel>
    >(() => FranchiseNotifier());
