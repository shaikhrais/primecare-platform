import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_repository.dart';
import '../view_models/franchise_notifier.dart';

final franchiseRepositoryProvider = Provider<IFranchiseRepository>((ref) {
  return FranchiseRepository(ref.watch(dashboardServiceProvider));
});

final franchiseNotifierProvider =
    NotifierProvider<
      FranchiseNotifier,
      AsyncValue<FranchiseDashboardViewModel>
    >(() => FranchiseNotifier());
