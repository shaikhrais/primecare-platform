import 'dart:io';

void main(List<String> arguments) async {
  print('=====================================================');
  print('PrimeCare Governance Entrypoint -> SQL-Backed Engine');
  print('=====================================================');

  // Spawn Python SQL-backed reconciliation script
  final ProcessResult result = await Process.run(
    'python',
    ['.agents/governance/reconcile_db.py', ...arguments],
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
