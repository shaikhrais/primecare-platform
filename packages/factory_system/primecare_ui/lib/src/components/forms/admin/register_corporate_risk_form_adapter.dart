import 'package:primecare_core/flutter_core.dart';
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
        state = RegisterCorporateRiskFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/register-corporate-risk-form-adapter');
      state = RegisterCorporateRiskFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = RegisterCorporateRiskFormViewModel(isLoading: false, data: {});
    }
  }
}

final registerCorporateRiskFormAdapterProvider =
    NotifierProvider<
      RegisterCorporateRiskFormAdapter,
      RegisterCorporateRiskFormViewModel
    >(() {
      return RegisterCorporateRiskFormAdapter();
    });
