import 'package:primecare_models/primecare_models.dart';

class ChemotherapyProtocolBuilderModel extends BaseScreenState<ChemotherapyProtocolBuilderModel> {
  const ChemotherapyProtocolBuilderModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChemotherapyProtocolBuilderModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChemotherapyProtocolBuilderModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
