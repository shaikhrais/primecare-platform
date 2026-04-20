// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class MoodSliderWidgetViewModel {
  final bool isLoading;
  final dynamic data;
  MoodSliderWidgetViewModel({this.isLoading = false, this.data});
}

class MoodSliderWidgetAdapter extends Notifier<MoodSliderWidgetViewModel> {
  @override
  MoodSliderWidgetViewModel build() {
    return MoodSliderWidgetViewModel();
  }

  Future<void> loadData() async {
        state = MoodSliderWidgetViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/mood-slider-widget-adapter');
      state = MoodSliderWidgetViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = MoodSliderWidgetViewModel(isLoading: false, data: {});
    }
  }
}

final moodSliderWidgetAdapterProvider =
    NotifierProvider<MoodSliderWidgetAdapter, MoodSliderWidgetViewModel>(() {
      return MoodSliderWidgetAdapter();
    });
