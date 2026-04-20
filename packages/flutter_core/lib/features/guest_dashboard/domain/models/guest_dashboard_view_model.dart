import '../../../common/domain/models/primecare_dashboard_view_model.dart';

extension GuestDashboardViewModelExtension on PrimeCareDashboardViewModel {
  static PrimeCareDashboardViewModel empty() =>
      PrimeCareDashboardViewModel.assemble(isOffline: true);
}

typedef GuestDashboardViewModel = PrimeCareDashboardViewModel;
