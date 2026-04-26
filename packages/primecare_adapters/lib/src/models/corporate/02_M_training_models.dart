// Layer: 02_MODELS_FOUNDATION
import 'package:equatable/equatable.dart';

class CurriculumModel extends Equatable {
  final String id;
  final String programName;
  final String department;
  final String status;
  final int completionPct;

  const CurriculumModel({
    required this.id,
    required this.programName,
    required this.department,
    required this.status,
    required this.completionPct,
  });

  factory CurriculumModel.fromJson(Map<String, dynamic> json) {
    return CurriculumModel(
      id: json['id'] as String,
      programName: json['programName'] as String,
      department: json['department'] as String,
      status: json['status'] as String,
      completionPct: json['completionPct'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'programName': programName,
    'department': department,
    'status': status,
    'completionPct': completionPct,
  };

  @override
  List<Object?> get props => [
    id,
    programName,
    department,
    status,
    completionPct,
  ];
}

class CertificationModel extends Equatable {
  final String id;
  final String staffName;
  final String clinicalRole;
  final String certName;
  final DateTime expiresAt;
  final String status;

  const CertificationModel({
    required this.id,
    required this.staffName,
    required this.clinicalRole,
    required this.certName,
    required this.expiresAt,
    required this.status,
  });

  factory CertificationModel.fromJson(Map<String, dynamic> json) {
    return CertificationModel(
      id: json['id'] as String,
      staffName: json['staffName'] as String,
      clinicalRole: json['clinicalRole'] as String,
      certName: json['certName'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'staffName': staffName,
    'clinicalRole': clinicalRole,
    'certName': certName,
    'expiresAt': expiresAt.toIso8601String(),
    'status': status,
  };

  @override
  List<Object?> get props => [
    id,
    staffName,
    clinicalRole,
    certName,
    expiresAt,
    status,
  ];
}

class TrainingModuleModel extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? category;
  final String? videoUrl;

  const TrainingModuleModel({
    required this.id,
    required this.title,
    this.description,
    this.category,
    this.videoUrl,
  });

  factory TrainingModuleModel.fromJson(Map<String, dynamic> json) {
    return TrainingModuleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      videoUrl: json['videoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'videoUrl': videoUrl,
  };

  @override
  List<Object?> get props => [id, title, description, category, videoUrl];
}
