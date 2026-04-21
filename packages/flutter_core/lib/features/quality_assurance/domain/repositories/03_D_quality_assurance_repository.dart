// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../models/02_M_quality_assurance_data.dart';

abstract class IQualityAssuranceRepository {
  Future<Result<QualityAssuranceData>> getQualityAssuranceData();
}

class QualityAssuranceRepository implements IQualityAssuranceRepository {
  final DomainService _domainService;

  QualityAssuranceRepository(this._domainService);

  @override
  Future<Result<QualityAssuranceData>> getQualityAssuranceData() async {
    final result = await _domainService.getDomainMetrics('QualityAssurance');
    return result.map(
      (DomainResponse domainResponse) => QualityAssuranceData.fromDomain(domainResponse.data),
    );
  }
}
