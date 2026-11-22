/// Host composition only. Existing server authentication and grants remain required.
library;

enum PackageKind { library, ui, service, source }

class PackageDescriptor {
  final String id;
  final PackageKind kind;
  final int contractVersion;
  final List<String> dependencies;
  PackageDescriptor({
    required this.id,
    required this.kind,
    this.contractVersion = 1,
    Iterable<String> dependencies = const [],
  }) : dependencies = List.unmodifiable(dependencies) {
    if (!RegExp(r'^[a-z][a-z0-9_-]*$').hasMatch(id) ||
        contractVersion < 1 ||
        this.dependencies.toSet().length != this.dependencies.length) {
      throw ArgumentError('Invalid package descriptor');
    }
  }
  factory PackageDescriptor.fromJson(Map<String, dynamic> json) =>
      PackageDescriptor(
        id: json['id'] as String,
        kind: PackageKind.values.byName(json['kind'] as String),
        contractVersion: json['contractVersion'] as int,
        dependencies: (json['dependencies'] as List).cast<String>(),
      );
}

class PackageCatalog {
  final Map<String, PackageDescriptor> _entries = {};
  PackageCatalog(Iterable<PackageDescriptor> entries) {
    for (final entry in entries) {
      if (_entries.containsKey(entry.id))
        throw StateError('Duplicate package: ${entry.id}');
      _entries[entry.id] = entry;
    }
    order();
  }
  PackageDescriptor get(String id) =>
      _entries[id] ?? (throw StateError('Unknown package: $id'));
  List<String> order() {
    final done = <String>{}, active = <String>{}, result = <String>[];
    void visit(String id) {
      if (active.contains(id))
        throw StateError('Package dependency cycle: $id');
      if (done.contains(id)) return;
      active.add(id);
      for (final dependency in (get(id).dependencies.toList()..sort())) {
        visit(dependency);
      }
      active.remove(id);
      done.add(id);
      result.add(id);
    }

    for (final id in (_entries.keys.toList()..sort())) {
      visit(id);
    }
    return List.unmodifiable(result);
  }
}

class RemoteBinding {
  final Uri endpoint;
  final int contractVersion;
  RemoteBinding(String endpoint, this.contractVersion)
    : endpoint = Uri.parse(endpoint) {
    final uri = this.endpoint;
    if (uri.scheme != 'https' ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        uri.hasQuery ||
        uri.hasFragment ||
        contractVersion < 1) {
      throw ArgumentError(
        'Remote endpoint requires HTTPS without credentials, query or fragment',
      );
    }
  }
}

class _Provider {
  final Object Function() local;
  final Object Function(RemoteBinding)? remote;
  _Provider(this.local, this.remote);
}

class PackageMaster {
  final PackageCatalog catalog;
  final Map<String, RemoteBinding> _bindings;
  final _providers = <String, _Provider>{};
  final _instances = <String, Object>{};
  final _active = <String>{};
  PackageMaster(this.catalog, {Map<String, RemoteBinding> bindings = const {}})
    : _bindings = Map.unmodifiable(bindings) {
    for (final entry in _bindings.entries) {
      final descriptor = catalog.get(entry.key);
      if (descriptor.kind != PackageKind.service ||
          descriptor.contractVersion != entry.value.contractVersion) {
        throw StateError('Remote binding is not compatible: ${entry.key}');
      }
    }
  }
  void register<T extends Object>(
    String id, {
    required int contractVersion,
    required T Function() local,
    T Function(RemoteBinding)? remote,
  }) {
    if (catalog.get(id).contractVersion != contractVersion ||
        _providers.containsKey(id)) {
      throw StateError('Duplicate or incompatible provider: $id');
    }
    _providers[id] = _Provider(local, remote);
  }

  T resolve<T extends Object>(String id) {
    catalog.get(id);
    if (_instances.containsKey(id)) return _instances[id] as T;
    if (!_active.add(id)) throw StateError('Provider resolution cycle: $id');
    try {
      final provider =
          _providers[id] ??
          (throw StateError('Package has no registered provider: $id'));
      final binding = _bindings[id];
      if (binding != null && provider.remote == null)
        throw StateError('Remote adapter unavailable: $id');
      final instance = binding == null
          ? provider.local()
          : provider.remote!(binding);
      if (instance is Future)
        throw StateError('Provider must return a synchronous adapter: $id');
      final typed = instance as T;
      _instances[id] = typed;
      return typed;
    } finally {
      _active.remove(id);
    }
  }
}
