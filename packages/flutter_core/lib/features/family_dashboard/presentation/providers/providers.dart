import '../../../../flutter_core.dart';
import '../../domain/repositories/family_repository.dart';
import '../view_models/family_notifier.dart';

final familyRepositoryProvider = Provider<IFamilyRepository>((ref) {
  return FamilyRepository(ref.watch(dashboardServiceProvider));
});

final familyNotifierProvider =
    NotifierProvider<FamilyNotifier, AsyncValue<FamilyDashboardViewModel>>(
      FamilyNotifier.new,
    );
