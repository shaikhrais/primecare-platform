import 'package:primecare_models/primecare_models.dart';

class ServiceMeshTopologyModel extends BaseScreenState<ServiceMeshTopologyModel> {
  const ServiceMeshTopologyModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ServiceMeshTopologyModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ServiceMeshTopologyModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
