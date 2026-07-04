class ResourceAllocationMapModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ResourceAllocationMapModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ResourceAllocationMapModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ResourceAllocationMapModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
