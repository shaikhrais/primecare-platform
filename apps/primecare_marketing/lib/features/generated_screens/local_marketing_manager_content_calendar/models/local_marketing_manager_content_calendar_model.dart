import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerContentCalendarModel extends BaseScreenState<LocalMarketingManagerContentCalendarModel> {
  const LocalMarketingManagerContentCalendarModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerContentCalendarModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerContentCalendarModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
