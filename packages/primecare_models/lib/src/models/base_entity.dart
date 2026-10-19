/// Shared identity storage. Parsing, equality and validation remain domain-specific.
abstract class BaseEntity<T> {
  final T id;
  const BaseEntity({required this.id});
}
