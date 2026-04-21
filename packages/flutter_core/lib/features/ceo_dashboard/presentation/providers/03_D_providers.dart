// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_ceo_repository.dart';
import '../view_models/04_V_ceo_notifier.dart';

final Provider<ICeoRepository> ceoRepositoryProvider = Provider<ICeoRepository>(
  (Ref ref) {
    return CeoRepository(ref.watch(domainServiceProvider));
  },
);

final NotifierProvider<CeoNotifier, AsyncValue<CeoDashboardViewModel>>
ceoDashboardProvider =
    NotifierProvider<CeoNotifier, AsyncValue<CeoDashboardViewModel>>(
      CeoNotifier.new,
    );
