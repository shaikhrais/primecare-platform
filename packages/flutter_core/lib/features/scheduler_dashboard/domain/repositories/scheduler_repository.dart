import '../../../../flutter_core.dart';

abstract class ISchedulerRepository {
  Future<Result<SchedulerDashboardViewModel>> getSchedulerData();
}

class SchedulerRepository implements ISchedulerRepository {
  final DomainService _domainService;

  SchedulerRepository(this._domainService);

  @override
  Future<Result<SchedulerDashboardViewModel>> getSchedulerData() async {
    final response = await _domainService.getDomainMetrics('Scheduler');
    return response.map(
      (data) => SchedulerDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
