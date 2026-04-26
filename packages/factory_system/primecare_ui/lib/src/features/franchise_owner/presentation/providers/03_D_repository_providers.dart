import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_core/00_B_flutter_core.dart';
import '../../data/repositories/03_D_franchise_owner_repository_impl.dart';
import '../../domain/repositories/03_D_franchise_owner_repository.dart';

final Provider<IFranchiseOwnerRepository> franchiseOwnerRepositoryProvider =
    Provider<IFranchiseOwnerRepository>((Ref ref) {
      final DomainService service = ref.read(domainServiceProvider);
      return FranchiseOwnerRepositoryImpl(service);
    });
