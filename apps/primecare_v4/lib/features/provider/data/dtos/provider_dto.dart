class ProviderDto {
  final String id;
  final String? fullName;
  final String? providerName;
  final String? nextVisit;
  final String? specialty;

  ProviderDto({
    required this.id,
    this.fullName,
    this.providerName,
    this.nextVisit,
    this.specialty,
  });

  /// The raw conversion from arbitrary backend JSON schemas
  factory ProviderDto.fromJson(Map<String, dynamic> json) {
    return ProviderDto(
      id: json['id'] ?? '',
      // Backend might use fullName, full_name, or provider_name depending on the endpoint payload!
      fullName: json['fullName'] ?? json['full_name'],
      providerName: json['provider_name'],
      nextVisit: json['next_visit'],
      specialty: json['specialty'],
    );
  }
}
