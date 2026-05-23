// Governance - Category: service | Purpose: Core implementation file for the Security Event platform logic.
import 'package:equatable/equatable.dart';

enum SecurityEventSeverity { info, warning, critical }

class SecurityEvent extends Equatable {
  final String id;
  final DateTime timestamp;
  final String type;
  final String description;
  final SecurityEventSeverity severity;
  final Map<String, dynamic>? metadata;

  const SecurityEvent({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.description,
    required this.severity,
    this.metadata,
  });

  @override
  List<Object?> get props => [
    id,
    timestamp,
    type,
    description,
    severity,
    metadata,
  ];

  Map<String, dynamic> toJson() => {
    'id': id,
    'timestamp': timestamp.toIso8601String(),
    'type': type,
    'description': description,
    'severity': severity.name,
    'metadata': metadata,
  };
}
