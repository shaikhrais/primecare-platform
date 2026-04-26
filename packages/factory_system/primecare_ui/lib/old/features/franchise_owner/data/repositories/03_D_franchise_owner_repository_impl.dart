import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/repositories/03_D_franchise_owner_repository.dart';

class FranchiseOwnerRepositoryImpl implements IFranchiseOwnerRepository {
  final DomainService _domainService;

  FranchiseOwnerRepositoryImpl(this._domainService);

  @override
  Future<Result<DomainResponse>> getFranchiseOwnerData() async {
    return _domainService.getDomainMetrics('FranchiseOwner');
  }
}
