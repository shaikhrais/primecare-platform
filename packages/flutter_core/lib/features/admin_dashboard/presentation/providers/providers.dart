import '../../../../flutter_core.dart';
import '../../domain/repositories/admin_repository.dart';
import '../view_models/admin_notifier.dart';

final adminRepositoryProvider = Provider<IAdminRepository>((ref) {
  return AdminRepository(ref.watch(dashboardServiceProvider));
});

final adminNotifierProvider =
    NotifierProvider<AdminNotifier, AsyncValue<AdminDashboardViewModel>>(
      AdminNotifier.new,
    );
