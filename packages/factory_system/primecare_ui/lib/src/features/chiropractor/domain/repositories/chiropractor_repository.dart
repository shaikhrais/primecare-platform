import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC

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
