// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AuthSplitLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  AuthSplitLayoutViewModel({this.isLoading = false, this.data});
}

class AuthSplitLayoutAdapter extends Notifier<AuthSplitLayoutViewModel> {
  @override
  AuthSplitLayoutViewModel build() {
    return AuthSplitLayoutViewModel();
  }

  Future<void> loadData() async {
        state = AuthSplitLayoutViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/auth-split-layout-adapter');
      state = AuthSplitLayoutViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = AuthSplitLayoutViewModel(isLoading: false, data: {});
    }
  }
}

final authSplitLayoutAdapterProvider =
    NotifierProvider<AuthSplitLayoutAdapter, AuthSplitLayoutViewModel>(() {
      return AuthSplitLayoutAdapter();
    });
