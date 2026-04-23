// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class LogClinicalIncidentFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  LogClinicalIncidentFormViewModel({this.isLoading = false, this.data});
}

class LogClinicalIncidentFormAdapter
    extends Notifier<LogClinicalIncidentFormViewModel> {
  @override
  LogClinicalIncidentFormViewModel build() {
    return LogClinicalIncidentFormViewModel();
  }

  Future<void> loadData() async {
        state = LogClinicalIncidentFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/log-clinical-incident-form-adapter');
      state = LogClinicalIncidentFormViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = LogClinicalIncidentFormViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final logClinicalIncidentFormAdapterProvider =
    NotifierProvider<
      LogClinicalIncidentFormAdapter,
      LogClinicalIncidentFormViewModel
    >(() {
      return LogClinicalIncidentFormAdapter();
    });
