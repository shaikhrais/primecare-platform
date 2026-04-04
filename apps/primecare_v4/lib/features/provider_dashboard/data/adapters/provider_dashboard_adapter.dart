import '../../../../core/config/feature_flags.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/models/provider_dashboard_models.dart';

class ProviderDashboardMapper {
  static ProviderDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return ProviderDashboardViewModel(
      providerName: mock['name'] ?? '',
      todayVisits: mock['visitsCount'] ?? 0,
      alerts: List<String>.from(mock['alerts'] ?? []),
      nextVisitTime: mock['nextVisit'],
    );
  }

  static ProviderDashboardViewModel fromApi(ProviderDashboardDto dto) {
    return ProviderDashboardViewModel(
      providerName: dto.fullName,
      todayVisits: dto.todayVisits,
      alerts: dto.alerts,
      nextVisitTime: dto.nextVisitTime,
    );
  }
}

class ProviderDashboardMockProvider {
  Future<ProviderDashboardViewModel> getData() async {
    return ProviderDashboardMapper.fromMock({
      'name': 'Dr. Sarah Mock',
      'visitsCount': 14,
      'alerts': ['Lab Results Pending (MOCK)', 'Sync Error'],
      'nextVisit': '10:30 AM',
    });
  }
}

class ProviderDashboardApiProvider {
  final ApiClient apiClient;
  ProviderDashboardApiProvider(this.apiClient);

  Future<ProviderDashboardViewModel> getData() async {
    try {
      final response = await apiClient.get('/v1/providers/profile/me');
      final dto = ProviderDashboardDto.fromJson(response.data);
      
      return ProviderDashboardMapper.fromApi(dto);
    } catch (error) {
      final message = ErrorMapper.mapApiErrorToUiMessage(error);
      return ProviderDashboardViewModel(
        providerName: 'Error Recovered Mode',
        todayVisits: 0,
        alerts: [message],
        nextVisitTime: null,
      );
    }
  }
}

class ProviderDashboardAdapter {
  final ProviderDashboardMockProvider mockProvider;
  final ProviderDashboardApiProvider apiProvider;

  ProviderDashboardAdapter({
    required this.mockProvider,
    required this.apiProvider,
  });

  Future<ProviderDashboardViewModel> getData() async {
    if (FeatureFlags.useApiForProviderDashboard) {
      return apiProvider.getData();
    }
    return mockProvider.getData();
  }
}
