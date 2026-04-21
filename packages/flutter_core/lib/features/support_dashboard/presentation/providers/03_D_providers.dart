// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_support_repository.dart';
import '../view_models/04_V_support_notifier.dart';

final supportRepositoryProvider = Provider<ISupportRepository>((ref) {
  return SupportRepository(ref.watch(dashboardServiceProvider));
});

final supportNotifierProvider =
    NotifierProvider<SupportNotifier, AsyncValue<SupportDashboardViewModel>>(
      SupportNotifier.new,
    );
