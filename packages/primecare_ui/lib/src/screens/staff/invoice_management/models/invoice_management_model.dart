import 'package:primecare_models/primecare_models.dart';

class InvoiceManagementModel extends BaseScreenState<InvoiceManagementModel> {
  const InvoiceManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InvoiceManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InvoiceManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
