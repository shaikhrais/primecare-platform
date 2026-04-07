import '../../../../core/config/feature_flags.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/models/client_profile_models.dart';

class ClientProfileMapper {
  static ClientProfileViewModel fromMock(Map<String, dynamic> mock) {
    return ClientProfileViewModel(
      clientId: mock['id'] ?? 'MOCK-ID',
      fullName: mock['name'] ?? 'Mock Client',
      age: mock['clientAge'] ?? 0,
      status: mock['status'] ?? 'Draft',
      recentDiagnoses: List<String>.from(mock['diagnoses'] ?? []),
    );
  }

  static ClientProfileViewModel fromApi(ClientProfileDto dto) {
    return ClientProfileViewModel(
      clientId: dto.id,
      fullName: dto.patientName,
      age: dto.age,
      status: dto.currentStatus,
      recentDiagnoses: dto.diagnosesList ?? [],
    );
  }
}

class ClientProfileMockProvider {
  Future<ClientProfileViewModel> getData(String profileId) async {
    return ClientProfileMapper.fromMock({
      'id': profileId,
      'name': 'Jane Doe',
      'clientAge': 32,
      'status': 'Active Treatment',
      'diagnoses': ['Hypertension', 'Asthma'],
    });
  }
}

class ClientProfileApiProvider {
  final ApiClient apiClient;
  ClientProfileApiProvider(this.apiClient);

  Future<ClientProfileViewModel> getData(String profileId) async {
    try {
      final response = await apiClient.get('/v1/primecare/client/profile');
      final dto = ClientProfileDto(
        id: response.data['id'] ?? profileId,
        patientName: response.data['name'] ?? 'Unknown',
        age: response.data['clientAge'] ?? 0,
        currentStatus: response.data['status'] ?? 'Unknown',
        diagnosesList: List<String>.from(response.data['diagnoses'] ?? []),
      );
      return ClientProfileMapper.fromApi(dto);
    } catch (error) {
      final message = ErrorMapper.mapApiErrorToUiMessage(error);
      return ClientProfileViewModel(
        clientId: profileId,
        fullName: 'Error Recovered Mode',
        age: 0,
        status: 'Offline',
        recentDiagnoses: [message],
      );
    }
  }
}

class ClientProfileAdapter {
  final ClientProfileMockProvider mockProvider;
  final ClientProfileApiProvider apiProvider;

  ClientProfileAdapter({required this.mockProvider, required this.apiProvider});

  Future<ClientProfileViewModel> getData(String profileId) async {
    if (FeatureFlags.useApiForClientProfile) {
      return apiProvider.getData(profileId);
    }
    return mockProvider.getData(profileId);
  }
}
