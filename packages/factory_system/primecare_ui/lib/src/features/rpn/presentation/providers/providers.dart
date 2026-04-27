import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_core/flutter_core.dart';
import '../../domain/repositories/rpn_repository.dart';
import '../../domain/models/rpn_state.dart';
import '../view_models/rpn_notifier.dart';

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
