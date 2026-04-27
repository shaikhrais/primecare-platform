// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

// Prisma Load Adapter

class ScheduleClinicalAuditFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ScheduleClinicalAuditFormViewModel({this.isLoading = false, this.data});
}

class ScheduleClinicalAuditFormAdapter
    extends Notifier<ScheduleClinicalAuditFormViewModel> {
  @override
  ScheduleClinicalAuditFormViewModel build() {
    return ScheduleClinicalAuditFormViewModel();
  }

  Future<void> loadData() async {
    state = ScheduleClinicalAuditFormViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/schedule-clinical-audit-form-adapter',
      );
      state = ScheduleClinicalAuditFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = ScheduleClinicalAuditFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final scheduleClinicalAuditFormAdapterProvider =
    NotifierProvider<
      ScheduleClinicalAuditFormAdapter,
      ScheduleClinicalAuditFormViewModel
    >(() {
      return ScheduleClinicalAuditFormAdapter();
    });
