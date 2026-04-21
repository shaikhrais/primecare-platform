// Layer: 02_MODELS_FOUNDATION
class RequestShiftAdjustmentFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  RequestShiftAdjustmentFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  RequestShiftAdjustmentFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return RequestShiftAdjustmentFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
