/// A named architecture owner. This is code ownership, never an access grant.
class ClassManagerDeclaration {
  final String id;
  final String? parentId;
  final String purpose;
  const ClassManagerDeclaration(this.id, this.parentId, this.purpose);
}

/// Central manager hierarchy; real application inheritance remains unchanged.
class MasterClassManager {
  final Map<String, ClassManagerDeclaration> managers;
  final List<({String prefix, String manager})> rules;
  MasterClassManager(
    List<ClassManagerDeclaration> entries,
    List<({String prefix, String manager})> scopes,
  ) : managers = Map.unmodifiable({
        for (final entry in entries) entry.id: entry,
      }),
      rules = List.unmodifiable(scopes) {
    if (managers.length != entries.length || managers.isEmpty) {
      throw FormatException('Duplicate or empty manager declarations');
    }
    final roots = entries.where((entry) => entry.parentId == null).toList();
    if (roots.length != 1)
      throw FormatException('Exactly one master manager required');
    for (final entry in entries) {
      if (entry.id.isEmpty || entry.purpose.trim().isEmpty) {
        throw FormatException('Manager identity and purpose required');
      }
      final visited = <String>{};
      ClassManagerDeclaration? current = entry;
      while (current != null) {
        if (!visited.add(current.id)) throw FormatException('Manager cycle');
        final parent = current.parentId;
        if (parent != null && !managers.containsKey(parent)) {
          throw FormatException('Unknown parent manager');
        }
        current = parent == null ? null : managers[parent];
      }
    }
    for (final rule in rules) {
      if (!managers.containsKey(rule.manager) || rule.prefix.contains('..')) {
        throw FormatException('Invalid manager scope');
      }
    }
    final prefixes = rules.map((rule) => rule.prefix).toSet();
    if (prefixes.length != rules.length)
      throw FormatException('Ambiguous manager scopes');
  }

  String? managerFor(String path) {
    final matches = rules.where((rule) => path.startsWith(rule.prefix)).toList()
      ..sort((a, b) => b.prefix.length.compareTo(a.prefix.length));
    return matches.isEmpty ? null : matches.first.manager;
  }

  factory MasterClassManager.fromJson(Map<String, dynamic> value) {
    if (value['version'] != 1)
      throw FormatException('Unsupported master registry');
    return MasterClassManager(
      [
        for (final entry
            in (value['managers'] as List).cast<Map<String, dynamic>>())
          ClassManagerDeclaration(
            entry['id'] as String,
            entry['parentId'] as String?,
            entry['purpose'] as String,
          ),
      ],
      [
        for (final rule
            in (value['scopes'] as List).cast<Map<String, dynamic>>())
          (
            prefix: rule['prefix'] as String,
            manager: rule['manager'] as String,
          ),
      ],
    );
  }
}

/// One actual inheritance target; unresolved names remain unresolved.
class BaseClassDeclaration {
  final String id;
  final String sourceName;
  final String? sourceClassId;
  final String? managerId;
  final String resolution;
  const BaseClassDeclaration(
    this.id,
    this.sourceName,
    this.sourceClassId,
    this.managerId,
    this.resolution,
  );
}

/// Master index of base classes, including explicit external SDK targets.
class MasterBaseClassManager {
  final Map<String, BaseClassDeclaration> declarations = {};
  void declare(BaseClassDeclaration value) {
    if (declarations.containsKey(value.id))
      throw FormatException('Duplicate base declaration');
    declarations[value.id] = value;
  }
}
