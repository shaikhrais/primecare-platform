import 'dart:io';

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

  print('🚀 Starting PrimeCare Platform Multi-App Deployment...');

  for (final app in apps) {
    print('\n📦 Processing $app...');
    final appPath = 'apps/$app';
    
    // 1. Pub get
    print('   - Running flutter pub get...');
    final getResult = await Process.run('flutter', ['pub', 'get'], workingDirectory: appPath, runInShell: true);
    if (getResult.exitCode != 0) {
      print('   ❌ Error: pub get failed for $app');
      print(getResult.stderr);
      continue;
    }

    // 2. Build web
    print('   - Building for web...');
    final buildResult = await Process.run('flutter', ['build', 'web', '--release'], workingDirectory: appPath, runInShell: true);
    if (buildResult.exitCode != 0) {
      print('   ❌ Error: build web failed for $app');
      print(buildResult.stderr);
      continue;
    }

    // 3. Deploy to Cloudflare
    final projectName = 'primecare-${app.replaceAll("_", "-")}';
    print('   - Deploying to Cloudflare Pages as $projectName...');
    final deployResult = await Process.run('npx', [
      'wrangler', 'pages', 'deploy', 'build/web',
      '--project-name=$projectName',
      '--branch=main',
      '--yes'
    ], workingDirectory: appPath, runInShell: true);

    if (deployResult.exitCode != 0) {
      print('   ❌ Error: deployment failed for $app');
      print(deployResult.stderr);
    } else {
      print('   ✅ Successfully deployed $app!');
    }
  }

  print('\n✨ Deployment sequence complete.');
}
