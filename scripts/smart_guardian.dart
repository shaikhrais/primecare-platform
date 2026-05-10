import 'dart:io';
import 'lib/hash_utils.dart';
import 'lib/cache_manager.dart';

void main(List<String> args) async {
  final force = args.contains('--force');
  final watch = args.contains('--watch');
  final gracePeriod = int.tryParse(
        args
            .firstWhere(
              (a) => a.startsWith('--grace='),
              orElse: () => '--grace=60',
            )
            .split('=')[1],
      ) ??
      60;
  final repeats = int.tryParse(
        args
            .firstWhere(
              (a) => a.startsWith('--repeats='),
              orElse: () => '--repeats=-1',
            )
            .split('=')[1],
      ) ??
      -1;

  final cache = CacheManager();
  int currentRepeat = 0;

  do {
    currentRepeat++;
    print('\n==========================================');
    print(' PRIMECARE SMART GUARDIAN: Initiating Incremental Sweep');
    print(' [Config: GracePeriod=${gracePeriod}s, Force=$force, Watch=$watch]');
    print('==========================================');

    final milestones = [
      Milestone(
        name: 'core',
        path: 'packages/flutter_core',
        command: 'dart analyze',
        description: 'Analyzing Core Infrastructure',
      ),
      Milestone(
        name: 'adapters',
        path: 'packages/primecare_adapters',
        command: 'dart analyze',
        description: 'Analyzing Data Adapters',
        dependencies: ['core'],
      ),
      Milestone(
        name: 'ui',
        path: 'packages/primecare_ui',
        command: 'dart analyze',
        description: 'Analyzing UI Design System',
        dependencies: ['core', 'adapters'],
      ),
      Milestone(
        name: 'corporate',
        path: 'apps/primecare_corporate',
        command: 'flutter test test/app_navigation_test.dart',
        description: 'Running Corporate Portal Tests',
        dependencies: ['core', 'adapters', 'ui'],
      ),
      Milestone(
        name: 'registry',
        path: 'packages/primecare_ui',
        command: 'flutter test scripts/health_sweep.dart',
        description: 'Running Global Registry Health Sweep',
        dependencies: ['ui'],
      ),
    ];

    bool anyFailure = false;
    Map<String, String> currentHashes = {};
    int skipCount = 0;
    Set<String> rerunInThisSession = {};

    for (final m in milestones) {
      // 1. Content Hash Check
      final hash = HashUtils.getDirectoryHash(m.path);
      currentHashes[m.name] = hash;

      bool needsRun = force || !cache.isHashMatch(m.name, hash);

      // 2. Cascading Dependency Check
      if (!needsRun) {
        for (final dep in m.dependencies) {
          if (rerunInThisSession.contains(dep)) {
            needsRun = true;
            break;
          }
        }
      }

      // 3. Fast Temporal Check (Grace Period)
      // Only skip if it was PASS recently AND doesn't need a run due to hash or dependencies
      if (!needsRun &&
          !force &&
          cache.wasRecentlyChecked(m.name, gracePeriod)) {
        print('[RECENT] ${m.description} (Checked < ${gracePeriod}s ago)');
        skipCount++;
        continue;
      }

      if (needsRun) {
        rerunInThisSession.add(m.name);
        print('\n[RUNNING] ${m.description}...');
        final stopwatch = Stopwatch()..start();
        final result = await _runCommand(m.command, m.path);
        stopwatch.stop();

        if (result.exitCode == 0) {
          print(' [PASS] ${m.name} (${stopwatch.elapsed.inSeconds}s)');
          cache.updateMilestone(m.name, hash, 'PASS');
        } else {
          print(' [FAIL] ${m.name}');
          print(result.stdout);
          print(result.stderr);
          cache.updateMilestone(m.name, hash, 'FAIL');
          anyFailure = true;
          break;
        }
      } else {
        print('[CACHED] ${m.description}');
        skipCount++;
      }
    }

    cache.save();

    if (!anyFailure) {
      print('\n==========================================');
      print(' SUCCESS: Platform Integrity Verified.');
      if (skipCount > 0)
        print(
          ' Saved significant time by skipping $skipCount redundant steps.',
        );
      print('==========================================');
    } else {
      print('\n==========================================');
      print(' FAILURE: Integrity Check Failed.');
      print('==========================================');
      if (!watch) exit(1);
    }

    if (watch && (repeats == -1 || currentRepeat < repeats)) {
      print(
        '\n[WATCH] Waiting 10 seconds for changes (Run $currentRepeat of ${repeats == -1 ? "∞" : repeats})...',
      );
      await Future<void>.delayed(const Duration(seconds: 10));
    } else {
      break;
    }
  } while (true);
}

class Milestone {
  final String name;
  final String path;
  final String command;
  final String description;
  final List<String> dependencies;

  Milestone({
    required this.name,
    required this.path,
    required this.command,
    required this.description,
    this.dependencies = const [],
  });
}

Future<ProcessResult> _runCommand(String command, String workingDir) async {
  final parts = command.split(' ');
  final executable = parts[0];
  final arguments = parts.sublist(1);

  return Process.run(
    executable,
    arguments,
    workingDirectory: workingDir,
    runInShell: true,
  );
}
