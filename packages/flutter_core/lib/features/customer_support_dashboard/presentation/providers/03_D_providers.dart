// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_customer_support_repository.dart';
import '../view_models/04_V_customer_support_notifier.dart';

final Provider<ICustomerSupportRepository> customerSupportRepositoryProvider =
    Provider<ICustomerSupportRepository>((Ref ref) {
      return CustomerSupportRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  CustomerSupportNotifier,
  AsyncValue<CustomerSupportDashboardViewModel>
>
customerSupportDashboardProvider =
    NotifierProvider<
      CustomerSupportNotifier,
      AsyncValue<CustomerSupportDashboardViewModel>
    >(CustomerSupportNotifier.new);
