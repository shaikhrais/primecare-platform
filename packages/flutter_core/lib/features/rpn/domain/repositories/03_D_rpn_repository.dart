// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../../../01_I_domain_service.dart';
import '../models/02_M_rpn_data.dart';

abstract class IRpnRepository {
  Future<Result<RpnData>> getRpnData();
}

class RpnRepository implements IRpnRepository {
  final DomainService _domainService;

  RpnRepository(this._domainService);

  @override
  Future<Result<RpnData>> getRpnData() async {
    final response = await _domainService.getDomainMetrics('RPN');
    return response.map((DomainResponse domainResponse) => RpnData.fromDomain(domainResponse.data));
  }
}
