import '../../../../flutter_core.dart';
import '../../domain/repositories/cfo_repository.dart';
import '../view_models/cfo_notifier.dart';

final Provider<ICfoRepository> cfoRepositoryProvider = Provider<ICfoRepository>(
  (Ref ref) {
    return CfoRepository(ref.watch(domainServiceProvider));
  },
);

final NotifierProvider<CfoNotifier, AsyncValue<CfoDashboardViewModel>>
cfoDashboardProvider =
    NotifierProvider<CfoNotifier, AsyncValue<CfoDashboardViewModel>>(
      CfoNotifier.new,
    );
