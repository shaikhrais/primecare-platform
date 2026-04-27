import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'rn_data.dart';

abstract class IRnRepository {
  Future<Result<RnData>> getRnData();
}

class RnRepository implements IRnRepository {
  final DomainService _domainService;

  RnRepository(this._domainService);

  @override
  Future<Result<RnData>> getRnData() async {
    final response = await _domainService.getDomainMetrics('RN');
    return response.map(
      (DomainResponse domainResponse) => RnData.fromDomain(domainResponse.data),
    );
  }
}
