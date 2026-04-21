// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../01_I_domain_service.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

abstract class IChiropractorRepository {
  Future<Result<DomainResponse>> getChiropractorData();
}

class ChiropractorRepository implements IChiropractorRepository {
  ChiropractorRepository(this._domainService);
  final DomainService _domainService;

  @override
  Future<Result<DomainResponse>> getChiropractorData() async {
    return _domainService.getDomainMetrics('Chiropractor');
  }
}
