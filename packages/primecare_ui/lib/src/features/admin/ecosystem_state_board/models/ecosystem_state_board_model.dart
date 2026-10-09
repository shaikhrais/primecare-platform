import 'package:primecare_models/primecare_models.dart';

class EcosystemStateBoardModel extends BaseScreenState<EcosystemStateBoardModel> {
  const EcosystemStateBoardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EcosystemStateBoardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EcosystemStateBoardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
