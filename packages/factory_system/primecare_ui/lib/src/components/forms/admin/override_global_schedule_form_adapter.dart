import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class OverrideGlobalScheduleFormViewModel {
  final bool isLoading;
  final dynamic data;
  OverrideGlobalScheduleFormViewModel({this.isLoading = false, this.data});
}

class OverrideGlobalScheduleFormAdapter
    extends Notifier<OverrideGlobalScheduleFormViewModel> {
  @override
  OverrideGlobalScheduleFormViewModel build() {
    return OverrideGlobalScheduleFormViewModel();
  }

  Future<void> loadData() async {
        state = OverrideGlobalScheduleFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/override-global-schedule-form-adapter');
      state = OverrideGlobalScheduleFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = OverrideGlobalScheduleFormViewModel(isLoading: false, data: {});
    }
  }
}

final overrideGlobalScheduleFormAdapterProvider =
    NotifierProvider<
      OverrideGlobalScheduleFormAdapter,
      OverrideGlobalScheduleFormViewModel
    >(() {
      return OverrideGlobalScheduleFormAdapter();
    });
