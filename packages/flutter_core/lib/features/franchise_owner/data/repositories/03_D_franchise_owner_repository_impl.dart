// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../01_I_domain_service.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../domain/repositories/03_D_franchise_owner_repository.dart';

class FranchiseOwnerRepositoryImpl implements IFranchiseOwnerRepository {
  final DomainService _domainService;

  FranchiseOwnerRepositoryImpl(this._domainService);

  @override
  Future<Result<DomainResponse>> getFranchiseOwnerData() async {
    return _domainService.getDomainMetrics('FranchiseOwner');
  }
}
