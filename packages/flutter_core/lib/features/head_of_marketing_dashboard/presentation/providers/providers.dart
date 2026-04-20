import '../../../../flutter_core.dart';
import '../../domain/repositories/head_of_marketing_repository.dart';
import '../view_models/head_of_marketing_notifier.dart';

final Provider<IHeadOfMarketingRepository> headOfMarketingRepositoryProvider =
    Provider<IHeadOfMarketingRepository>((Ref ref) {
      return HeadOfMarketingRepository(ref.watch(domainServiceProvider));
    });

final headOfMarketingDashboardProvider =
    NotifierProvider<
      HeadOfMarketingNotifier,
      AsyncValue<HeadOfMarketingDashboardViewModel>
    >(HeadOfMarketingNotifier.new);
