// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_owner_repository.dart';
import '../view_models/04_V_owner_notifier.dart';

final ownerRepositoryProvider = Provider<IOwnerRepository>((ref) {
  return OwnerRepository(ref.watch(dashboardServiceProvider));
});

final ownerNotifierProvider =
    NotifierProvider<OwnerNotifier, AsyncValue<OwnerDashboardViewModel>>(
      () => OwnerNotifier(),
    );
