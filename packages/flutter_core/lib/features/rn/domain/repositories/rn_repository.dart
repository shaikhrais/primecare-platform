import '../../../../network/result.dart';
import '../../../../domain_service.dart';
import '../models/rn_data.dart';

abstract class IRnRepository {
  Future<Result<RnData>> getRnData();
}

class RnRepository implements IRnRepository {
  final DomainService _domainService;

  RnRepository(this._domainService);

  @override
  Future<Result<RnData>> getRnData() async {
    final response = await _domainService.getDomainMetrics('RN');
    return response.map((data) => RnData.fromDomain(data.data));
  }
}
