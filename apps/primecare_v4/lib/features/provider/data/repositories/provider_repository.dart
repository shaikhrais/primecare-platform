import '../../../../core/network/api_client.dart';
import '../../../../core/config/api_config.dart';
import '../../../../core/network/api_error.dart';
import '../dtos/provider_dto.dart';
import '../../domain/models/provider_model.dart';
import '../mappers/provider_mapper.dart';

class ProviderRepository {
  final ApiClient _apiClient;

  ProviderRepository(this._apiClient);

  /// Fetches the raw dashboard JSON from the API, converts it cleanly into a DTO, 
  /// and rigidly maps it into a stable UI Model, returning a pristine type-safe object.
  Future<ProviderModel> getDashboard() async {
    try {
      final endpoint = ApiConfig.endpoints['providerDashboard']!;
      final response = await _apiClient.get(endpoint);

      // JSON -> DTO
      final dto = ProviderDto.fromJson(response.data);
      
      // DTO -> Model
      return ProviderMapper.mapToModel(dto);
      
    } catch (e) {
      // Isolates low-level Dio Stack Traces from leaking into Flutter Widgets!
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }
}
