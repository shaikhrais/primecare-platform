import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class BaseFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = BaseFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = BaseFormViewModel(isLoading: false, data: {});
    }
  }
}

final baseFormAdapterProvider =
    NotifierProvider<BaseFormAdapter, BaseFormViewModel>(() {
      return BaseFormAdapter();
    });
