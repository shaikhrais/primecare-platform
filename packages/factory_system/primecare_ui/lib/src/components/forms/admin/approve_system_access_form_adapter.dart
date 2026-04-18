import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class ApproveSystemAccessFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      final response = await client.get('/api/v1/approve-system-access-form-adapter');
      state = ApproveSystemAccessFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = ApproveSystemAccessFormViewModel(isLoading: false, data: {});
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
