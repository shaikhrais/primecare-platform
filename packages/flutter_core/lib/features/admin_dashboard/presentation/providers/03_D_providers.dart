// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_admin_repository.dart';
import '../view_models/04_V_admin_notifier.dart';

final adminRepositoryProvider = Provider<IAdminRepository>((ref) {
  return AdminRepository(ref.watch(dashboardServiceProvider));
});

final adminNotifierProvider =
    NotifierProvider<AdminNotifier, AsyncValue<AdminDashboardViewModel>>(
      AdminNotifier.new,
    );
