// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_cfo_repository.dart';
import '../view_models/04_V_cfo_notifier.dart';

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
