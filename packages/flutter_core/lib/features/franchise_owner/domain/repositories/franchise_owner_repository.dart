import '../../../../domain_service.dart';
import '../../../../network/result.dart';

abstract class IFranchiseOwnerRepository {
  Future<Result<DomainResponse>> getFranchiseOwnerData();
}
