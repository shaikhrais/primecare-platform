import '../../../../flutter_core.dart';
import '../../domain/repositories/local_marketing_manager_repository.dart';
import '../view_models/local_marketing_manager_notifier.dart';

final localMarketingManagerRepositoryProvider =
    Provider<ILocalMarketingManagerRepository>((ref) {
      return LocalMarketingManagerRepository(ref.watch(domainServiceProvider));
    });

final localMarketingManagerDashboardProvider =
    NotifierProvider<
      LocalMarketingManagerNotifier,
      AsyncValue<LocalMarketingManagerDashboardViewModel>
    >(LocalMarketingManagerNotifier.new);
