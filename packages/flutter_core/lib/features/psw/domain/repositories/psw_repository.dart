import '../../../../network/result.dart';
import '../../../../domain_service.dart';
import '../models/psw_data.dart';

abstract class IPswRepository {
  Future<Result<PswData>> getPswData();
}

class PswRepository implements IPswRepository {
  final DomainService _domainService;

  PswRepository(this._domainService);

  @override
  Future<Result<PswData>> getPswData() async {
    final response = await _domainService.getDomainMetrics('PSW');
    return response.map((data) => PswData.fromDomain(data.data));
  }
}
