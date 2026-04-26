import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_core/00_B_flutter_core.dart';
import '../../domain/repositories/03_D_rpn_repository.dart';
import '../../domain/models/02_M_rpn_state.dart';
import '../view_models/04_V_rpn_notifier.dart';

final Provider<IRpnRepository> rpnRepositoryProvider = Provider<IRpnRepository>(
  (Ref ref) {
    final domainService = ref.watch(domainServiceProvider);
    return RpnRepository(domainService);
  },
);

final NotifierProvider<RpnNotifier, RpnState> rpnDashboardProvider =
    NotifierProvider<RpnNotifier, RpnState>(() {
      return RpnNotifier();
    });
