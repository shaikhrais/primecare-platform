// CI-only evidence reader. Uses the resolved hooks API, not guessed JSON nesting.
import 'dart:convert';
import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:crypto/crypto.dart';
import 'package:hooks/hooks.dart';

void require(bool condition) {
  if (!condition) throw StateError('Source mode evidence is incomplete or inconsistent.');
}

Map<String, dynamic> jsonFile(File file) {
  require(file.lengthSync() <= 4 * 1024 * 1024);
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

String digest(File file) {
  require(file.lengthSync() <= 32 * 1024 * 1024);
  return sha256.convert(file.readAsBytesSync()).toString();
}

void inspect() {
  final workspace = Platform.environment['GITHUB_WORKSPACE']!;
  final state = Platform.environment['PILOT_STATE']!;
  final app = Directory('$workspace/apps/primecare_clinic');
  final before = jsonFile(File('$state/before.json'));
  final source = jsonFile(File('$state/source.json'));
  final sourcePath = source['source_path'] as String;
  final hookRoot = Directory('${app.path}/.dart_tool/hooks_runner');
  final entities = hookRoot.listSync(recursive: true, followLinks: false);
  require(entities.length <= 10000);
  final inputs = <BuildInput>[];
  for (final entity in entities) {
    require(!entity.path.contains('/sqlite3/build/download-'));
    if (entity is File && entity.path.endsWith('/input.json')) {
      final inputJson = jsonFile(entity);
      if (inputJson['package_name'] == 'sqlite3') {
        inputs.add(BuildInput(inputJson));
      }
    }
  }
  require(inputs.length == 1);
  final input = inputs.single;
  require(input.userDefines['source'] == 'source');
  require(input.userDefines.path('path')?.toFilePath() == sourcePath);
  for (final key in ['defines', 'additional_includes', 'additional_flags',
      'additional_lib_directories', 'additional_libraries', 'url_pattern']) {
    require(input.userDefines[key] == null);
  }
  require(input.packageRoot.toFilePath().replaceFirst(RegExp(r'/$'), '') ==
      (before['packages']['sqlite3']['root'] as String));
  require(input.config.buildCodeAssets);
  final config = input.config.code;
  require(config.targetOS == OS.linux && config.targetArchitecture == Architecture.x64);
  final compiler = config.cCompiler;
  require(compiler != null);
  final configuredTools = {
    'compiler': compiler!.compiler,
    'archiver': compiler.archiver,
    'linker': compiler.linker,
  };
  for (final entry in configuredTools.entries) {
    require(File.fromUri(entry.value).resolveSymbolicLinksSync() == before['tools'][entry.key]);
  }
  for (final entry in (before['system_tools'] as Map<String, dynamic>).entries) {
    final target = File(entry.value as String);
    require(target.resolveSymbolicLinksSync() == before['system_tool_realpaths'][entry.key]);
    require(digest(target) == before['system_tool_sha256'][entry.key]);
  }
  for (final entry in (before['launcher_sha256'] as Map<String, dynamic>).entries) {
    require(FileSystemEntity.typeSync(entry.key, followLinks: false) == FileSystemEntityType.file);
    require(digest(File(entry.key)) == entry.value);
  }
  final output = BuildOutput(jsonFile(File.fromUri(input.outputFile)));
  final assets = output.assets.encodedAssets.where((asset) => asset.isCodeAsset)
      .map(CodeAsset.fromEncoded).toList();
  require(assets.length == 1);
  final asset = assets.single;
  const id = 'package:sqlite3/src/ffi/libsqlite3.g.dart';
  require(asset.id == id && asset.linkMode is DynamicLoadingBundled && asset.file != null);
  final built = File.fromUri(asset.file!);
  final outputDirectory = Directory.fromUri(input.outputDirectory).resolveSymbolicLinksSync();
  require(built.resolveSymbolicLinksSync().startsWith('$outputDirectory/'));
  require(!built.path.contains('/download-'));
  require(output.dependencies.contains(Uri.file(sourcePath)));
  final builtHash = digest(built);
  var mappings = 0;
  for (final root in [Directory('${app.path}/.dart_tool'), Directory('${app.path}/build')]) {
    final files = root.listSync(recursive: true, followLinks: false);
    require(files.length <= 30000);
    for (final file in files.whereType<File>()) {
      if (!file.path.endsWith('/native_assets.json')) continue;
      final document = jsonFile(file);
      final mapping = document['native-assets']?['linux_x64']?[id];
      if (mapping == null) continue;
      require(mapping is List && mapping.length == 2 && mapping[0] == 'absolute');
      final bundled = File(mapping[1] as String);
      require(bundled.resolveSymbolicLinksSync().startsWith('${app.path}/build/native_assets/linux/'));
      require(digest(bundled) == builtHash);
      mappings += 1;
    }
  }
  require(mappings > 0);
  final report = {
    'source_mode_confirmed': true,
    'source_sha3_256': source['source_sha3_256'],
    'compiled_asset_sha256': builtHash,
    'asset_id': id,
    'target': 'linux_x64',
    'matching_native_asset_manifests': mappings,
    'compiler_mapping_matches_preflight': true,
    'fixed_compiler_launchers_verified': true,
    'compiler_default_configs_disabled_for_all_invocations': true,
    'trust_limit': 'GitHub-hosted runner and installed package database; not immutable-image attestation',
  };
  final reportFile = File('$state/result.json');
  require(!reportFile.existsSync());
  reportFile.writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(report)}\n');
  stdout.writeln('Verified source-mode hook input, compiled output and Flutter native asset mapping.');
}

void main() {
  try {
    inspect();
  } catch (_) {
    stderr.writeln('SQLite source pilot rejected: source-mode-evidence');
    exitCode = 1;
  }
}
