import '../../../../flutter_core.dart';
import '../../domain/repositories/owner_repository.dart';
import '../view_models/owner_notifier.dart';

final ownerRepositoryProvider = Provider<IOwnerRepository>((ref) {
  return OwnerRepository(ref.watch(dashboardServiceProvider));
});

final ownerNotifierProvider =
    NotifierProvider<OwnerNotifier, AsyncValue<OwnerDashboardViewModel>>(
      () => OwnerNotifier(),
    );
