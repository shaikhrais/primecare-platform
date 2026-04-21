// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';

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
      (DomainResponse domainResponse) => CommunityOutreachDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(domainResponse.data),
      ),
    );
  }
}
