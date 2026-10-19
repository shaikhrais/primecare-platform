/// Shared application metadata; role resolution stays in the consumer.
abstract class BasePlatformApplication<TTenant, TRoleDefinition> {
  String get appId;
  String get name;
  TTenant get tenant;
  List<TRoleDefinition> get roleDefinitions;
}
