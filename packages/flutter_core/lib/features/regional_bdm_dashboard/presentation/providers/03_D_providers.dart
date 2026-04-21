// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_regional_bdm_repository.dart';

final regionalBdmRepositoryProvider = Provider<IRegionalBdmRepository>((ref) {
  return RegionalBdmRepository(ref.watch(domainServiceProvider));
});
