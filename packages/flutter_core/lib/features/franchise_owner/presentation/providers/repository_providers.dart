import '../../../../flutter_core.dart';
import '../../data/repositories/franchise_owner_repository_impl.dart';
import '../../domain/repositories/franchise_owner_repository.dart';

final Provider<IFranchiseOwnerRepository> franchiseOwnerRepositoryProvider =
    Provider<IFranchiseOwnerRepository>((Ref ref) {
      final DomainService service = ref.read(domainServiceProvider);
      return FranchiseOwnerRepositoryImpl(service);
    });
