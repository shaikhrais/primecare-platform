/// Compatibility base for empty generated DTOs, not a completed contract.
/// These templates intentionally carry no fields and retain empty serialization.
abstract class BaseEmptyModel {
  const BaseEmptyModel();
  Map<String, dynamic> toJson() => {};
}
