// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class RegisterCorporateRiskFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      state = RegisterCorporateRiskFormViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = RegisterCorporateRiskFormViewModel(isLoading: false, data: <String, dynamic>{});
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
