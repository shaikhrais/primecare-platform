import 'package:primecare_models/primecare_models.dart';

class BiospecimenInventoryTrackerModel extends BaseScreenState<BiospecimenInventoryTrackerModel> {
  const BiospecimenInventoryTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BiospecimenInventoryTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BiospecimenInventoryTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
