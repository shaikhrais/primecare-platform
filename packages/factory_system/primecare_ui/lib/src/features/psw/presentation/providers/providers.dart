import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/repositories/psw_repository.dart';
import '../../domain/models/psw_state.dart';
import '../view_models/psw_notifier.dart';

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
