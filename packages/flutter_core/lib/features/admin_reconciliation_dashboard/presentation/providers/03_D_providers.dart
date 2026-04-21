// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_admin_reconciliation_repository.dart';
import '../view_models/04_V_admin_reconciliation_notifier.dart';

final adminReconciliationRepositoryProvider =
    Provider<IAdminReconciliationRepository>((ref) {
      return AdminReconciliationRepository(ref.watch(dashboardServiceProvider));
    });

final adminReconciliationNotifierProvider =
    NotifierProvider<
      AdminReconciliationNotifier,
      AsyncValue<AdminReconciliationDashboardViewModel>
    >(AdminReconciliationNotifier.new);
