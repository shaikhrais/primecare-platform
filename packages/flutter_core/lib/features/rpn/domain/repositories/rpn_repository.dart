import '../../../../network/result.dart';
import '../../../../domain_service.dart';
import '../models/rpn_data.dart';

abstract class IRpnRepository {
  Future<Result<RpnData>> getRpnData();
}

class RpnRepository implements IRpnRepository {
  final DomainService _domainService;

  RpnRepository(this._domainService);

  @override
  Future<Result<RpnData>> getRpnData() async {
    final response = await _domainService.getDomainMetrics('RPN');
    return response.map((data) => RpnData.fromDomain(data.data));
  }
}
