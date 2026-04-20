import '../../../../flutter_core.dart';
import '../models/receptionist_dashboard_view_model.dart';

abstract class IReceptionistRepository {
  Future<Result<ReceptionistDashboardViewModel>> getReceptionistData();
}

class ReceptionistRepository implements IReceptionistRepository {
  final DomainService _domainService;

  ReceptionistRepository(this._domainService);

  @override
  Future<Result<ReceptionistDashboardViewModel>> getReceptionistData() async {
    final response = await _domainService.getDomainMetrics('Receptionist');
    return response.map(
      (data) => ReceptionistDashboardViewModel.fromDashboardMetrics(
        DashboardMetrics.fromJson(data.data),
      ),
    );
  }
}
