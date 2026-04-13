import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class PrimecareResponsiveShellViewModel {
  final bool isLoading;
  final dynamic data;
  PrimecareResponsiveShellViewModel({this.isLoading = false, this.data});
}

class PrimecareResponsiveShellAdapter extends Notifier<PrimecareResponsiveShellViewModel> {
  @override
  PrimecareResponsiveShellViewModel build() {
    return PrimecareResponsiveShellViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = PrimecareResponsiveShellViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = PrimecareResponsiveShellViewModel(isLoading: false, data: {});
  }
}

final primecareResponsiveShellAdapterProvider = NotifierProvider<PrimecareResponsiveShellAdapter, PrimecareResponsiveShellViewModel>(() {
  return PrimecareResponsiveShellAdapter();
});
