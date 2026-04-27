import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_core/flutter_core.dart';
import '../../domain/repositories/rn_repository.dart';
import '../../domain/models/rn_state.dart';
import '../view_models/rn_notifier.dart';

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
