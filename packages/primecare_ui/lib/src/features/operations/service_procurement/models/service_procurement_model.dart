import 'package:primecare_models/primecare_models.dart';

class ServiceProcurementModel extends BaseScreenState<ServiceProcurementModel> {
  const ServiceProcurementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ServiceProcurementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ServiceProcurementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
