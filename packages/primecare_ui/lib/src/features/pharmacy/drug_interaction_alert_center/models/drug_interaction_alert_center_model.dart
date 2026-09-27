class DrugInteractionAlertCenterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DrugInteractionAlertCenterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DrugInteractionAlertCenterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DrugInteractionAlertCenterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
