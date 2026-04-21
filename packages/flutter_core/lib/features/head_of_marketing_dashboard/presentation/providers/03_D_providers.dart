// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_head_of_marketing_repository.dart';
import '../view_models/04_V_head_of_marketing_notifier.dart';

final Provider<IHeadOfMarketingRepository> headOfMarketingRepositoryProvider =
    Provider<IHeadOfMarketingRepository>((Ref ref) {
      return HeadOfMarketingRepository(ref.watch(domainServiceProvider));
    });

final headOfMarketingDashboardProvider =
    NotifierProvider<
      HeadOfMarketingNotifier,
      AsyncValue<HeadOfMarketingDashboardViewModel>
    >(HeadOfMarketingNotifier.new);
