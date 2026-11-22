import 'dart:convert';
import 'dart:io';
import '../lib/primecare_package_base.dart';

int checks = 0;
void check(bool value, String label) {
  checks++;
  if (!value) throw StateError('FAIL: $label');
}

void rejects(void Function() action, String label) {
  try {
    action();
  } catch (_) {
    checks++;
    return;
  }
  throw StateError('FAIL: expected rejection: $label');
}

abstract interface class Reader {
  String read();
}

class LocalReader implements Reader {
  @override
  String read() => 'local';
}

class RemoteReader implements Reader {
  final RemoteBinding binding;
  RemoteReader(this.binding);
  @override
  String read() => binding.endpoint.toString();
}

void main() {
  final source =
      jsonDecode(
            File.fromUri(
              Platform.script.resolve('../catalog.json'),
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final parsed = PackageCatalog(
    (source['packages'] as List).map(
      (entry) => PackageDescriptor.fromJson(entry as Map<String, dynamic>),
    ),
  );
  final generated = createPrimeCarePackageCatalog();
  check(
    jsonEncode(parsed.order()) == jsonEncode(generated.order()),
    'generated master matches JSON',
  );
  for (final entry
      in (source['packages'] as List).cast<Map<String, dynamic>>()) {
    final descriptor = generated.get(entry['id'] as String);
    check(
      descriptor.kind.name == entry['kind'] &&
          descriptor.contractVersion == entry['contractVersion'] &&
          jsonEncode(descriptor.dependencies) ==
              jsonEncode(entry['dependencies']),
      'descriptor parity',
    );
  }
  String consumer(PackageMaster master) =>
      master.resolve<Reader>('client_api').read();
  PackageMaster host({bool remote = false}) {
    final master = PackageMaster(
      generated,
      bindings: remote
          ? {'client_api': RemoteBinding('https://example.test/service', 1)}
          : {},
    );
    master.register<Reader>(
      'client_api',
      contractVersion: 1,
      local: LocalReader.new,
      remote: RemoteReader.new,
    );
    return master;
  }

  check(consumer(host()) == 'local', 'local integration');
  final remote = host(remote: true);
  check(
    consumer(remote) == 'https://example.test/service',
    'same consumer, remote integration',
  );
  check(
    identical(
      remote.resolve<Reader>('client_api'),
      remote.resolve<Reader>('client_api'),
    ),
    'cached adapter',
  );
  rejects(
    () => remote.register<Reader>(
      'client_api',
      contractVersion: 1,
      local: LocalReader.new,
    ),
    'duplicate provider',
  );
  rejects(
    () => PackageMaster(
      generated,
      bindings: {
        'primecare_ui': RemoteBinding('https://example.test', 1),
      },
    ),
    'UI cannot be remote service',
  );
  rejects(
    () => PackageMaster(
      generated,
      bindings: {'client_api': RemoteBinding('https://example.test', 2)},
    ),
    'version mismatch',
  );
  rejects(() => generated.get('missing'), 'unknown package');
  rejects(
    () => PackageMaster(generated).resolve<Reader>('client_api'),
    'missing provider',
  );
  for (final endpoint in [
    'http://example.test',
    'https://user:pass@example.test',
    'https://example.test?token=secret',
    'https://example.test/#secret',
    '/service',
  ]) {
    rejects(() => RemoteBinding(endpoint, 1), 'invalid remote endpoint');
  }
  final noFallback = PackageMaster(
    generated,
    bindings: {'client_api': RemoteBinding('https://example.test', 1)},
  );
  var localCalls = 0, remoteCalls = 0;
  noFallback.register<Reader>(
    'client_api',
    contractVersion: 1,
    local: () {
      localCalls++;
      return LocalReader();
    },
    remote: (_) {
      remoteCalls++;
      throw StateError('unavailable');
    },
  );
  rejects(() => consumer(noFallback), 'remote failure');
  rejects(() => consumer(noFallback), 'remote retry');
  check(localCalls == 0 && remoteCalls == 2, 'no fallback, no failed cache');
  rejects(
    () => PackageCatalog([
      PackageDescriptor(
        id: 'cycle',
        kind: PackageKind.library,
        dependencies: ['cycle'],
      ),
    ]),
    'graph cycle',
  );
  final recursive = PackageMaster(generated);
  recursive.register<Reader>(
    'client_api',
    contractVersion: 1,
    local: () => recursive.resolve<Reader>('client_api'),
  );
  rejects(() => consumer(recursive), 'provider cycle');
  final wrongType = host();
  rejects(() => wrongType.resolve<String>('client_api'), 'wrong consumer type');
  check(
    consumer(wrongType) == 'local',
    'type failure does not poison registry',
  );
  print('Package master: $checks checks passed');
}
