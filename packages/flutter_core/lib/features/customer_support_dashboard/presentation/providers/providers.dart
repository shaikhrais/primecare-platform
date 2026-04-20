import '../../../../flutter_core.dart';
import '../../domain/repositories/customer_support_repository.dart';
import '../view_models/customer_support_notifier.dart';

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
