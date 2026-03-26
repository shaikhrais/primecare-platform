class ClientCaregiverData {
  final String id;
  final String name;
  final String role;
  final String specialty;
  final double rating;
  final int visits;
  final String bio;

  ClientCaregiverData({
    required this.id,
    required this.name,
    required this.role,
    required this.specialty,
    required this.rating,
    required this.visits,
    required this.bio,
  });

  factory ClientCaregiverData.fromJson(Map<String, dynamic> json) {
    return ClientCaregiverData(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown Caregiver',
      role: json['role'] as String? ?? 'Support Worker',
      specialty: json['specialty'] as String? ?? 'General Care',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      visits: (json['visits'] as num?)?.toInt() ?? 0,
      bio: json['bio'] as String? ?? 'Dedicated PrimeCare Agent',
    );
  }
}
