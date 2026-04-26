import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
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
    return response.map(
      (DomainResponse domainResponse) =>
          PswData.fromDomain(domainResponse.data),
    );
  }
}
