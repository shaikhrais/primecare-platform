// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/src/shared/src/api_client.dart';
// Prisma Load Adapter

class CommonUiPrimecareResponsiveShellViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  CommonUiPrimecareResponsiveShellViewModel({
    this.isLoading = false,
    this.data,
  });
}

class PrimecareResponsiveShellAdapter
    extends Notifier<CommonUiPrimecareResponsiveShellViewModel> {
  @override
  CommonUiPrimecareResponsiveShellViewModel build() {
    return CommonUiPrimecareResponsiveShellViewModel();
  }

  Future<void> loadData() async {
    state = CommonUiPrimecareResponsiveShellViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/primecare-responsive-shell-adapter',
      );
      state = CommonUiPrimecareResponsiveShellViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = CommonUiPrimecareResponsiveShellViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final primecareResponsiveShellAdapterProvider =
    NotifierProvider<
      PrimecareResponsiveShellAdapter,
      CommonUiPrimecareResponsiveShellViewModel
    >(() {
      return PrimecareResponsiveShellAdapter();
    });
