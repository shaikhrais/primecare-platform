import '../../../../flutter_core.dart';

abstract class ICommunityOutreachRepository {
  Future<Result<CommunityOutreachDashboardViewModel>>
  getCommunityOutreachData();
}

class CommunityOutreachRepository implements ICommunityOutreachRepository {
  final DomainService _domainService;

  CommunityOutreachRepository(this._domainService);

  @override
  Future<Result<CommunityOutreachDashboardViewModel>>
  getCommunityOutreachData() async {
    final response = await _domainService.getDomainMetrics('CommunityOutreach');
    return response.map(
      (data) => CommunityOutreachDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
