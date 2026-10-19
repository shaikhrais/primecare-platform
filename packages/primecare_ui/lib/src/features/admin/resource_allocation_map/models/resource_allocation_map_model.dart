import 'package:primecare_models/primecare_models.dart';

class ResourceAllocationMapModel extends BaseScreenState<ResourceAllocationMapModel> {
  const ResourceAllocationMapModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ResourceAllocationMapModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ResourceAllocationMapModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
