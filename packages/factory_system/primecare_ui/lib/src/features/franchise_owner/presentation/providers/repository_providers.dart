import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_core/flutter_core.dart';
import '../../data/repositories/franchise_owner_repository_impl.dart';
import '../../domain/repositories/franchise_owner_repository.dart';

final Provider<IFranchiseOwnerRepository> franchiseOwnerRepositoryProvider =
    Provider<IFranchiseOwnerRepository>((Ref ref) {
      final DomainService service = ref.read(domainServiceProvider);
      return FranchiseOwnerRepositoryImpl(service);
    });
