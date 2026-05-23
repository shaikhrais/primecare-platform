// Governance - Category: service | Purpose: GENERATED CODE - DO NOT MODIFY BY HAND ************************************************************************** Jso...
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorrectionTicket _$CorrectionTicketFromJson(Map<String, dynamic> json) =>
    CorrectionTicket(
      id: json['id'] as String,
      screenId: json['screenId'] as String,
      reportedBy: json['reportedBy'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      resolvedAt: json['resolvedAt'] as String?,
      developerNotes: json['developerNotes'] as String?,
    );

Map<String, dynamic> _$CorrectionTicketToJson(CorrectionTicket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'screenId': instance.screenId,
      'reportedBy': instance.reportedBy,
      'description': instance.description,
      'severity': instance.severity,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'resolvedAt': instance.resolvedAt,
      'developerNotes': instance.developerNotes,
    };
