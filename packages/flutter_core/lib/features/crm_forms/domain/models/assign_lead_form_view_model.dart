class AssignLeadFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String assignmentId;
  final String leadId;
  final String assignedToId;
  final String priority;
  final String notes;

  AssignLeadFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.assignmentId = '',
    this.leadId = '',
    this.assignedToId = '',
    this.priority = 'Medium',
    this.notes = '',
  });

  AssignLeadFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? assignmentId,
    String? leadId,
    String? assignedToId,
    String? priority,
    String? notes,
  }) {
    return AssignLeadFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      assignmentId: assignmentId ?? this.assignmentId,
      leadId: leadId ?? this.leadId,
      assignedToId: assignedToId ?? this.assignedToId,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
    );
  }
}
