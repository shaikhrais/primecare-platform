// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_chiropractor_repository.dart';
import '../view_models/04_V_chiropractor_notifier.dart';
import '../../domain/models/02_M_chiropractor_state.dart';

final chiropractorRepositoryProvider = Provider<IChiropractorRepository>((ref) {
  final domainService = ref.watch(domainServiceProvider);
  return ChiropractorRepository(domainService);
});

final chiropractorNotifierProvider =
    NotifierProvider<ChiropractorNotifier, ChiropractorState>(() {
      return ChiropractorNotifier();
    });
