import 'dart:io';

void main(List<String> arguments) async {
  // Spawn Python SQL-backed feature generation script
  final ProcessResult result = await Process.run(
    'python',
    ['.agents/governance/feature_cli.py', ...arguments],
    runInShell: true,
  );

  // Print outputs
  if (result.stdout.toString().isNotEmpty) {
    stdout.write(result.stdout);
  }
  if (result.stderr.toString().isNotEmpty) {
    stderr.write(result.stderr);
  }

  // Forward exit code
  exit(result.exitCode);
}
