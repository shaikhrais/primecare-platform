// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_coo_repository.dart';
import '../view_models/04_V_coo_notifier.dart';

final Provider<ICooRepository> cooRepositoryProvider = Provider<ICooRepository>(
  (Ref ref) {
    return CooRepository(ref.watch(domainServiceProvider));
  },
);

final NotifierProvider<CooNotifier, AsyncValue<CooDashboardViewModel>>
cooDashboardProvider =
    NotifierProvider<CooNotifier, AsyncValue<CooDashboardViewModel>>(
      CooNotifier.new,
    );
