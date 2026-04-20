import '../../../../flutter_core.dart';
import '../../domain/repositories/admin_reconciliation_repository.dart';
import '../view_models/admin_reconciliation_notifier.dart';

final adminReconciliationRepositoryProvider =
    Provider<IAdminReconciliationRepository>((ref) {
      return AdminReconciliationRepository(ref.watch(dashboardServiceProvider));
    });

final adminReconciliationNotifierProvider =
    NotifierProvider<
      AdminReconciliationNotifier,
      AsyncValue<AdminReconciliationDashboardViewModel>
    >(AdminReconciliationNotifier.new);
