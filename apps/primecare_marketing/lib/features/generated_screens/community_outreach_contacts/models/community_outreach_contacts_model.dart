import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachContactsModel extends BaseScreenState<CommunityOutreachContactsModel> {
  const CommunityOutreachContactsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachContactsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachContactsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
