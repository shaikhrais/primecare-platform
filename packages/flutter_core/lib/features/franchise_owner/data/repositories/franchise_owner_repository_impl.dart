import '../../../../domain_service.dart';
import '../../../../network/result.dart';
import '../../domain/repositories/franchise_owner_repository.dart';

class FranchiseOwnerRepositoryImpl implements IFranchiseOwnerRepository {
  final DomainService _domainService;

  FranchiseOwnerRepositoryImpl(this._domainService);

  @override
  Future<Result<DomainResponse>> getFranchiseOwnerData() async {
    return _domainService.getDomainMetrics('FranchiseOwner');
  }
}
