import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class LogClinicalIncidentFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = LogClinicalIncidentFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = LogClinicalIncidentFormViewModel(isLoading: false, data: {});
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
