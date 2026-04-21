// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../01_I_domain_service.dart';
import '../models/02_M_psw_data.dart';

abstract class IPswRepository {
  Future<Result<PswData>> getPswData();
}

class PswRepository implements IPswRepository {
  final DomainService _domainService;

  PswRepository(this._domainService);

  @override
  Future<Result<PswData>> getPswData() async {
    final response = await _domainService.getDomainMetrics('PSW');
    return response.map((DomainResponse domainResponse) => PswData.fromDomain(domainResponse.data));
  }
}
