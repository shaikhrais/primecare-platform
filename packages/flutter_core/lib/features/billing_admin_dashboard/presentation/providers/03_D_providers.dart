// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_billing_admin_repository.dart';
import '../view_models/04_V_billing_admin_notifier.dart';

final billingAdminRepositoryProvider = Provider<IBillingAdminRepository>((ref) {
  return BillingAdminRepository(ref.watch(domainServiceProvider));
});

final billingAdminDashboardProvider =
    NotifierProvider<
      BillingAdminNotifier,
      AsyncValue<BillingAdminDashboardViewModel>
    >(BillingAdminNotifier.new);
