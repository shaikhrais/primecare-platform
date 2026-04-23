// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class BaseFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  BaseFormViewModel({this.isLoading = false, this.data});
}

class BaseFormAdapter extends Notifier<BaseFormViewModel> {
  @override
  BaseFormViewModel build() {
    return BaseFormViewModel();
  }

  Future<void> loadData() async {
        state = BaseFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/base-form-adapter');
      state = BaseFormViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = BaseFormViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final baseFormAdapterProvider =
    NotifierProvider<BaseFormAdapter, BaseFormViewModel>(() {
      return BaseFormAdapter();
    });
