import '../../domain/repositories/03_D_ceo_repository.dart';
import '../../../../00_B_flutter_core.dart';

final ceoRepositoryProvider = Provider<ICeoRepository>((ref) {
  return CeoRepository(ref.watch(domainServiceProvider));
});

final ceoDashboardProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) {
  return AsyncValue.data({'revenue': '\$1.2M', 'growth': '+12.5%'});
});
