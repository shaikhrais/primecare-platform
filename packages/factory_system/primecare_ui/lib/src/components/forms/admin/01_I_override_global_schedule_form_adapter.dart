// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class OverrideGlobalScheduleFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  OverrideGlobalScheduleFormViewModel({this.isLoading = false, this.data});
}

class OverrideGlobalScheduleFormAdapter
    extends Notifier<OverrideGlobalScheduleFormViewModel> {
  @override
  OverrideGlobalScheduleFormViewModel build() {
    return OverrideGlobalScheduleFormViewModel();
  }

  Future<void> loadData() async {
    state = OverrideGlobalScheduleFormViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/override-global-schedule-form-adapter',
      );
      state = OverrideGlobalScheduleFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = OverrideGlobalScheduleFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
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
