import '../../../../flutter_core.dart';
import '../../domain/repositories/billing_admin_repository.dart';
import '../view_models/billing_admin_notifier.dart';

final billingAdminRepositoryProvider = Provider<IBillingAdminRepository>((ref) {
  return BillingAdminRepository(ref.watch(domainServiceProvider));
});

final billingAdminDashboardProvider =
    NotifierProvider<
      BillingAdminNotifier,
      AsyncValue<BillingAdminDashboardViewModel>
    >(BillingAdminNotifier.new);
