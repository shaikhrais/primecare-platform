import 'base_entity.dart';
// Governance - Category: model | Purpose: Layer: 00_MODELS
// Layer: 00_MODELS

class PswDashboardData {
  final Map<String, dynamic> stats;
  final double shiftProgress;
  final String shiftDurationRemaining;
  final List<PswClient> clients;
  final List<PswTask> tasks;
  final int monthlyCompletedTasks;
  final String nextReviewDate;

  const PswDashboardData({
    required this.stats,
    required this.shiftProgress,
    required this.shiftDurationRemaining,
    required this.clients,
    required this.tasks,
    required this.monthlyCompletedTasks,
    required this.nextReviewDate,
  });

  factory PswDashboardData.fromJson(Map<String, dynamic> json) {
    return PswDashboardData(
      stats: (json['stats'] as Map<String, dynamic>?) ?? {},
      shiftProgress: (json['shiftProgress'] as num?)?.toDouble() ?? 0.0,
      shiftDurationRemaining:
          (json['shiftDurationRemaining'] as String?) ?? '0h 0m',
      clients: (json['clients'] as List? ?? [])
          .map((c) => PswClient.fromJson(c as Map<String, dynamic>))
          .toList(),
      tasks: (json['tasks'] as List? ?? [])
          .map((t) => PswTask.fromJson(t as Map<String, dynamic>))
          .toList(),
      monthlyCompletedTasks: (json['monthlyCompletedTasks'] as int?) ?? 0,
      nextReviewDate: (json['nextReviewDate'] as String?) ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() => {
    'stats': stats,
    'shiftProgress': shiftProgress,
    'shiftDurationRemaining': shiftDurationRemaining,
    'clients': clients.map((c) => c.toJson()).toList(),
    'tasks': tasks.map((t) => t.toJson()).toList(),
    'monthlyCompletedTasks': monthlyCompletedTasks,
    'nextReviewDate': nextReviewDate,
  };
}

class PswClient extends BaseEntity<String> {
  final String name;
  final String location;
  final String nextVisitTime;
  final String condition;
  final String status;

  const PswClient({
    required super.id,
    required this.name,
    required this.location,
    required this.nextVisitTime,
    required this.condition,
    required this.status,
  });

  factory PswClient.fromJson(Map<String, dynamic> json) {
    return PswClient(
      id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      location: (json['location'] as String?) ?? '',
      nextVisitTime: (json['nextVisitTime'] as String?) ?? '',
      condition: (json['condition'] as String?) ?? '',
      status: (json['status'] as String?) ?? 'Stable',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'nextVisitTime': nextVisitTime,
    'condition': condition,
    'status': status,
  };
}

class PswTask extends BaseEntity<String> {
  final String title;
  final String description;
  final bool isHighPriority;
  final bool isCompleted;

  const PswTask({
    required super.id,
    required this.title,
    required this.description,
    this.isHighPriority = false,
    this.isCompleted = false,
  });

  factory PswTask.fromJson(Map<String, dynamic> json) {
    return PswTask(
      id: (json['id'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      isHighPriority: json['isHighPriority'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isHighPriority': isHighPriority,
    'isCompleted': isCompleted,
  };
}
