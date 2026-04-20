import '../../../../domain_service.dart';
import '../../../../network/result.dart';

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
