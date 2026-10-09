import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachEventsModel extends BaseScreenState<CommunityOutreachEventsModel> {
  const CommunityOutreachEventsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachEventsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachEventsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
