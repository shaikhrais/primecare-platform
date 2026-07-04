class PhysiotherapistCommandCenterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PhysiotherapistCommandCenterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PhysiotherapistCommandCenterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PhysiotherapistCommandCenterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
