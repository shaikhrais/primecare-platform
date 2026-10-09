import 'package:primecare_models/primecare_models.dart';

class ProposalsModel extends BaseScreenState<ProposalsModel> {
  const ProposalsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ProposalsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ProposalsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
