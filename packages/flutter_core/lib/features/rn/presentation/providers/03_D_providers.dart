// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_rn_repository.dart';
import '../../domain/models/02_M_rn_state.dart';
import '../view_models/04_V_rn_notifier.dart';

final Provider<IRnRepository> rnRepositoryProvider = Provider<IRnRepository>((
  Ref ref,
) {
  final domainService = ref.watch(domainServiceProvider);
  return RnRepository(domainService);
});

final NotifierProvider<RnNotifier, RnState> rnDashboardProvider =
    NotifierProvider<RnNotifier, RnState>(() {
      return RnNotifier();
    });
