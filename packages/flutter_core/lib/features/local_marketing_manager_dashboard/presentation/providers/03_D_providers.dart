// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_local_marketing_manager_repository.dart';
import '../view_models/04_V_local_marketing_manager_notifier.dart';

final localMarketingManagerRepositoryProvider =
    Provider<ILocalMarketingManagerRepository>((ref) {
      return LocalMarketingManagerRepository(ref.watch(domainServiceProvider));
    });

final localMarketingManagerDashboardProvider =
    NotifierProvider<
      LocalMarketingManagerNotifier,
      AsyncValue<LocalMarketingManagerDashboardViewModel>
    >(LocalMarketingManagerNotifier.new);
