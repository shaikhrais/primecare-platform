// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:primecare_adapters/primecare_adapters.dart';

abstract class IFranchiseOwnerRepository {
  Future<Result<DomainResponse>> getFranchiseOwnerData();
}
