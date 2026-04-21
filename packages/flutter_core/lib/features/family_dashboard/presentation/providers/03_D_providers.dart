// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_family_repository.dart';
import '../view_models/04_V_family_notifier.dart';

final familyRepositoryProvider = Provider<IFamilyRepository>((ref) {
  return FamilyRepository(ref.watch(dashboardServiceProvider));
});

final familyNotifierProvider =
    NotifierProvider<FamilyNotifier, AsyncValue<FamilyDashboardViewModel>>(
      FamilyNotifier.new,
    );
