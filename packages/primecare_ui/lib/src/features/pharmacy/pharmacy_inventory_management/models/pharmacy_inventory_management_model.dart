import 'package:primecare_models/primecare_models.dart';

class PharmacyInventoryManagementModel extends BaseScreenState<PharmacyInventoryManagementModel> {
  const PharmacyInventoryManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PharmacyInventoryManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PharmacyInventoryManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
