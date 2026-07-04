class MobileClinicDispatchModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MobileClinicDispatchModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MobileClinicDispatchModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MobileClinicDispatchModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
