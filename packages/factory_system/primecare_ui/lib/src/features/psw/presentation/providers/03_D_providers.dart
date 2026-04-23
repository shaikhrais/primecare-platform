import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/repositories/03_D_psw_repository.dart';
import '../../domain/models/02_M_psw_state.dart';
import '../view_models/04_V_psw_notifier.dart';

final Provider<IPswRepository> pswRepositoryProvider = Provider<IPswRepository>(
  (Ref ref) {
    final domainService = ref.watch(domainServiceProvider);
    return PswRepository(domainService);
  },
);

final NotifierProvider<PswNotifier, PswState> pswDashboardProvider =
    NotifierProvider<PswNotifier, PswState>(() {
      return PswNotifier();
    });
