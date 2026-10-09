import 'package:primecare_models/primecare_models.dart';

class PrimeCareModel extends BaseScreenState<PrimeCareModel> {
  const PrimeCareModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PrimeCareModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PrimeCareModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
