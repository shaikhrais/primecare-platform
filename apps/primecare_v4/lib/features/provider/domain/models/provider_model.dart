class ProviderModel {
  final String id;
  final String name;
  final String? nextVisit;
  final String specialty;

  ProviderModel({
    required this.id,
    required this.name,
    this.nextVisit,
    required this.specialty,
  });
}
