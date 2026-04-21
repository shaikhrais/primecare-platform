// Layer: 02_MODELS_FOUNDATION
class AssignLeadFormDto {
  final String? id;
  final String? leadId;
  final String? assignedToId;
  final String? priority;
  final String? notes;

  AssignLeadFormDto({
    this.id,
    this.leadId,
    this.assignedToId,
    this.priority,
    this.notes,
  });

  factory AssignLeadFormDto.fromJson(Map<String, dynamic> json) {
    return AssignLeadFormDto(
      id: json['id'] as String?,
      leadId: json['leadId'] as String?,
      assignedToId: json['assignedToId'] as String?,
      priority: json['priority'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leadId': leadId,
      'assignedToId': assignedToId,
      'priority': priority,
      'notes': notes,
    };
  }
}
