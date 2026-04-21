// Layer: 02_MODELS_FOUNDATION
class AddFranchiseLeadFormDto {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? territoryOfInterest;
  final String? details;
  final String? status;

  AddFranchiseLeadFormDto({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.territoryOfInterest,
    this.details,
    this.status,
  });

  factory AddFranchiseLeadFormDto.fromJson(Map<String, dynamic> json) {
    return AddFranchiseLeadFormDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      territoryOfInterest: json['territoryOfInterest'] as String?,
      details: json['details'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'territoryOfInterest': territoryOfInterest,
      'details': details,
      'status': status,
    };
  }
}
