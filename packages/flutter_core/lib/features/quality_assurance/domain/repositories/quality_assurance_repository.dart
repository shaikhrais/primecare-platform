import '../../../../flutter_core.dart';
import '../models/quality_assurance_data.dart';

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
      (response) => QualityAssuranceData.fromDomain(response.data),
    );
  }
}
