import '../../../../core/config/feature_flags.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/models/visit_details_models.dart';

class VisitDetailsMapper {
  static VisitDetailsViewModel fromMock(Map<String, dynamic> mock) {
    return VisitDetailsViewModel(
      visitId: mock['id'] ?? 'MOCK-VISIT',
      providerName: mock['doc'] ?? 'Dr. Mock',
      date: mock['date'] ?? '2026-04-04',
      time: mock['time'] ?? '09:00 AM',
      summary: mock['summary'] ?? 'Routine Checkup',
      isCompleted: mock['done'] ?? false,
    );
  }

  static VisitDetailsViewModel fromApi(VisitDetailsDto dto) {
    return VisitDetailsViewModel(
      visitId: dto.id,
      providerName: dto.doctorName,
      date: dto.scheduledDate,
      time: dto.scheduledTime,
      summary: dto.notes,
      isCompleted: dto.statusCompleted,
    );
  }
}

class VisitDetailsMockProvider {
  Future<VisitDetailsViewModel> getData(String visitId) async {
    return VisitDetailsMapper.fromMock({
      'id': visitId,
      'doc': 'Dr. Mockington',
      'date': '2026-04-04',
      'time': '10:00 AM',
      'summary': 'Annual Physical Exam',
      'done': false,
    });
  }
}

class VisitDetailsApiProvider {
  final ApiClient apiClient;
  VisitDetailsApiProvider(this.apiClient);

  Future<VisitDetailsViewModel> getData(String visitId) async {
    try {
      final response = await apiClient.get('/v1/primecare/visits/details');
      final dto = VisitDetailsDto(
        id: response.data['visitId'] ?? visitId,
        doctorName: response.data['clientName'] ?? 'Unknown API',
        scheduledDate: '2026-04-05',
        scheduledTime: response.data['time'] ?? '11:00 AM',
        notes: response.data['notes'] ?? 'Follow-up appointment.',
        statusCompleted: true,
      );
      return VisitDetailsMapper.fromApi(dto);
    } catch (error) {
      final message = ErrorMapper.mapApiErrorToUiMessage(error);
      return VisitDetailsViewModel(
        visitId: visitId,
        providerName: 'Error Recovered',
        date: 'N/A',
        time: 'N/A',
        summary: message,
        isCompleted: false,
      );
    }
  }
}

class VisitDetailsAdapter {
  final VisitDetailsMockProvider mockProvider;
  final VisitDetailsApiProvider apiProvider;

  VisitDetailsAdapter({required this.mockProvider, required this.apiProvider});

  Future<VisitDetailsViewModel> getData(String visitId) async {
    if (FeatureFlags.useApiForVisitDetails) {
      return apiProvider.getData(visitId);
    }
    return mockProvider.getData(visitId);
  }
}
