// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class ApproveSystemAccessFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ApproveSystemAccessFormViewModel({this.isLoading = false, this.data});
}

class ApproveSystemAccessFormAdapter
    extends Notifier<ApproveSystemAccessFormViewModel> {
  @override
  ApproveSystemAccessFormViewModel build() {
    return ApproveSystemAccessFormViewModel();
  }

  Future<void> loadData() async {
    state = ApproveSystemAccessFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/approve-system-access-form-adapter',
      );
      state = ApproveSystemAccessFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = ApproveSystemAccessFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final approveSystemAccessFormAdapterProvider =
    NotifierProvider<
      ApproveSystemAccessFormAdapter,
      ApproveSystemAccessFormViewModel
    >(() {
      return ApproveSystemAccessFormAdapter();
    });
