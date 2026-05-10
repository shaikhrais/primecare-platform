import 'package:equatable/equatable.dart';

enum TicketSeverity { low, medium, high, critical }

enum TicketStatus { open, inProgress, resolved, closed }

class CorrectionTicket extends Equatable {
  final String id;
  final String title;
  final String description;
  final TicketSeverity severity;
  final TicketStatus status;
  final DateTime createdAt;
  final String? assignedTo;
  final Map<String, dynamic>? metadata;

  const CorrectionTicket({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.status,
    required this.createdAt,
    this.assignedTo,
    this.metadata,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    severity,
    status,
    createdAt,
    assignedTo,
    metadata,
  ];

  CorrectionTicket copyWith({TicketStatus? status, String? assignedTo}) {
    return CorrectionTicket(
      id: id,
      title: title,
      description: description,
      severity: severity,
      status: status ?? this.status,
      createdAt: createdAt,
      assignedTo: assignedTo ?? this.assignedTo,
      metadata: metadata,
    );
  }
}
