class AddFranchiseLeadFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String leadId;
  final String name;
  final String email;
  final String phone;
  final String territoryOfInterest;
  final String details;
  final String status;

  AddFranchiseLeadFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.leadId = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.territoryOfInterest = '',
    this.details = '',
    this.status = 'New',
  });

  AddFranchiseLeadFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? leadId,
    String? name,
    String? email,
    String? phone,
    String? territoryOfInterest,
    String? details,
    String? status,
  }) {
    return AddFranchiseLeadFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      leadId: leadId ?? this.leadId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      territoryOfInterest: territoryOfInterest ?? this.territoryOfInterest,
      details: details ?? this.details,
      status: status ?? this.status,
    );
  }
}
