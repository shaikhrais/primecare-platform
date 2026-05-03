import 'package:json_annotation/json_annotation.dart';

part 'correction_ticket.g.dart';

@JsonSerializable()
class CorrectionTicket {
  final String id;
  final String screenId;
  final String reportedBy;
  final String description;
  final String severity; // critical, major, minor, suggestion
  final String status; // open, in_progress, verified, closed
  final String createdAt;
  final String? resolvedAt;
  final String? developerNotes;

  CorrectionTicket({
    required this.id,
    required this.screenId,
    required this.reportedBy,
    required this.description,
    required this.severity,
    required this.status,
    required this.createdAt,
    this.resolvedAt,
    this.developerNotes,
  });

  factory CorrectionTicket.fromJson(Map<String, dynamic> json) => _$CorrectionTicketFromJson(json);
  Map<String, dynamic> toJson() => _$CorrectionTicketToJson(this);
}
