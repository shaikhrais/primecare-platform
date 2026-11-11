/// Declaration parity only; this does not certify runtime acceptance.
class BlueprintComponentEvidence {
  static List<String> missingImplemented({
    required Iterable<String> requiredComponents,
    required Iterable<String> implementedComponents,
  }) {
    final implemented = implementedComponents.toSet();
    return List<String>.unmodifiable(
      requiredComponents.where((component) => !implemented.contains(component)),
    );
  }
}
