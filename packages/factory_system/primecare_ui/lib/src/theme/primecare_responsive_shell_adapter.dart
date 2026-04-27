// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
// Prisma Load Adapter

class PrimecareResponsiveShellViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  PrimecareResponsiveShellViewModel({this.isLoading = false, this.data});
}

class PrimecareResponsiveShellAdapter
    extends Notifier<PrimecareResponsiveShellViewModel> {
  @override
  PrimecareResponsiveShellViewModel build() {
    return PrimecareResponsiveShellViewModel();
  }

  Future<void> loadData() async {
    state = PrimecareResponsiveShellViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/primecare-responsive-shell-adapter',
      );
      state = PrimecareResponsiveShellViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = PrimecareResponsiveShellViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final primecareResponsiveShellAdapterProvider =
    NotifierProvider<
      PrimecareResponsiveShellAdapter,
      PrimecareResponsiveShellViewModel
    >(() {
      return PrimecareResponsiveShellAdapter();
    });
