import 'dart:io';
import 'dart:convert';

DateTime getLatestModifiedTime(String appPath) {
  DateTime latest = DateTime.fromMillisecondsSinceEpoch(0);

  final directoriesToScan = [
    Directory('$appPath/lib'),
    Directory('$appPath/web'),
  ];

  for (final dir in directoriesToScan) {
    if (dir.existsSync()) {
      for (final entity in dir.listSync(recursive: true)) {
        if (entity is File) {
          final modified = entity.statSync().modified;
          if (modified.isAfter(latest)) {
            latest = modified;
          }
        }
      }
    }
  }

  final pubspec = File('$appPath/pubspec.yaml');
  if (pubspec.existsSync()) {
    final modified = pubspec.statSync().modified;
    if (modified.isAfter(latest)) {
      latest = modified;
    }
  }

  return latest;
}

void main() async {
  final apps = [
    'primecare_governance',
    'primecare_client',
    'primecare_clinic',
    'primecare_corporate',
    'primecare_marketing',
    'primecare_support',
    'primecare_franchise',
    'primecare_business_development',
    'primecare_enterprise_blueprint',
  ];

  print('🚀 Starting Smart PrimeCare Platform Multi-App Deployment...');

  final registryFile = File('scripts/deployment_registry.json');
  Map<String, dynamic> registry = {};

  if (registryFile.existsSync()) {
    try {
      registry =
          jsonDecode(registryFile.readAsStringSync()) as Map<String, dynamic>;
    } catch (e) {
      print('⚠️ Failed to parse deployment_registry.json. Starting fresh.');
    }
  }

  for (final app in apps) {
    print('\n📦 Processing $app...');
    final appPath = 'apps/$app';

    final latestModified = getLatestModifiedTime(appPath);
    final appRegistry = registry[app] as Map<String, dynamic>?;
    final lastDeployedStr = appRegistry?['lastDeployedAt'] as String?;

    if (lastDeployedStr != null) {
      final lastDeployed = DateTime.parse(lastDeployedStr);
      // Check if the latest modified file is older than our last deployment
      if (latestModified.isBefore(
        lastDeployed.add(const Duration(seconds: 1)),
      )) {
        print(
          '   ⏭️  Skipping $app: No changes detected since last deployment ($lastDeployedStr).',
        );
        continue;
      }
    }

    print('   ✨ Changes detected. Beginning deployment sequence...');

    // 1. Pub get
    print('   - Running flutter pub get...');
    final getResult = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: appPath,
      runInShell: true,
    );
    if (getResult.exitCode != 0) {
      print('   ❌ Error: pub get failed for $app');
      print(getResult.stderr);
      continue;
    }

    // 2. Build web
    print('   - Building for web...');
    final buildResult = await Process.run(
      'flutter',
      ['build', 'web', '--release'],
      workingDirectory: appPath,
      runInShell: true,
    );
    if (buildResult.exitCode != 0) {
      print('   ❌ Error: build web failed for $app');
      print(buildResult.stderr);
      continue;
    }

    // 3. Deploy to Cloudflare
    final projectName = 'primecare-${app.replaceAll("_", "-")}';
    print('   - Deploying to Cloudflare Pages as $projectName...');
    final deployResult = await Process.run(
      'npx',
      [
        'wrangler',
        'pages',
        'deploy',
        'build/web',
        '--project-name=$projectName',
        '--branch=main',
        '--commit-dirty=true',
      ],
      workingDirectory: appPath,
      runInShell: true,
    );

    if (deployResult.exitCode != 0) {
      print('   ❌ Error: deployment failed for $app');
      print(deployResult.stderr);
    } else {
      print('   ✅ Successfully deployed $app!');

      // Update Registry
      registry[app] = {
        'lastDeployedAt': DateTime.now().toUtc().toIso8601String(),
      };
      registryFile.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(registry),
      );
      print('   💾 Deployment registry updated.');
    }
  }

  print('\n✨ Deployment sequence complete.');
}
