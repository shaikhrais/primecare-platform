class BiospecimenInventoryTrackerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BiospecimenInventoryTrackerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BiospecimenInventoryTrackerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BiospecimenInventoryTrackerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
