import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class RegisterCorporateRiskFormViewModel {
  final bool isLoading;
  final dynamic data;
  RegisterCorporateRiskFormViewModel({this.isLoading = false, this.data});
}

class RegisterCorporateRiskFormAdapter
    extends Notifier<RegisterCorporateRiskFormViewModel> {
  @override
  RegisterCorporateRiskFormViewModel build() {
    return RegisterCorporateRiskFormViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = RegisterCorporateRiskFormViewModel(
      isLoading: true,
      data: state.data,
    );
    // Simulate fetch
    state = RegisterCorporateRiskFormViewModel(isLoading: false, data: {});
  }
}

final registerCorporateRiskFormAdapterProvider =
    NotifierProvider<
      RegisterCorporateRiskFormAdapter,
      RegisterCorporateRiskFormViewModel
    >(() {
      return RegisterCorporateRiskFormAdapter();
    });
