// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_cto_repository.dart';
import '../view_models/04_V_cto_notifier.dart';

final Provider<ICtoRepository> ctoRepositoryProvider = Provider<ICtoRepository>(
  (Ref ref) {
    return CtoRepository(ref.watch(domainServiceProvider));
  },
);

final NotifierProvider<CtoNotifier, AsyncValue<CtoDashboardViewModel>>
ctoDashboardProvider =
    NotifierProvider<CtoNotifier, AsyncValue<CtoDashboardViewModel>>(
      CtoNotifier.new,
    );
