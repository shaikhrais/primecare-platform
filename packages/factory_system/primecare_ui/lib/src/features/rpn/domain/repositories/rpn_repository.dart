import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'rpn_data.dart';

abstract class IRpnRepository {
  Future<Result<RpnData>> getRpnData();
}

class RpnRepository implements IRpnRepository {
  final DomainService _domainService;

  RpnRepository(this._domainService);

  @override
  Future<Result<RpnData>> getRpnData() async {
    final response = await _domainService.getDomainMetrics('RPN');
    return response.map(
      (DomainResponse domainResponse) =>
          RpnData.fromDomain(domainResponse.data),
    );
  }
}
