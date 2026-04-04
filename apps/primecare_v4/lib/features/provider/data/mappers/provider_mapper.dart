import '../dtos/provider_dto.dart';
import '../../domain/models/provider_model.dart';

class ProviderMapper {
  /// Isolates all backend API structural formatting changes from the core UI.
  /// If the API renames fields across microservices, ONLY fix this single function!
  static ProviderModel mapToModel(ProviderDto dto) {
    return ProviderModel(
      id: dto.id,
      // Cascading logic to absorb unpredictable API nomenclature 
      name: dto.fullName ?? dto.providerName ?? 'Unknown Provider',
      nextVisit: dto.nextVisit,
      specialty: dto.specialty ?? 'General Practice',
    );
  }
}
