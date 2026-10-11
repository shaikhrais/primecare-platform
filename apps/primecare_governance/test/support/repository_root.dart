import 'dart:io';

Directory repositoryRoot() {
  var directory = Directory.current.absolute;
  while (true) {
    if (File('${directory.path}/.agents/governance/blueprints.yaml').existsSync() &&
        Directory('${directory.path}/packages/primecare_models').existsSync()) {
      return directory;
    }
    final parent = directory.parent;
    if (parent.path == directory.path) {
      throw StateError('Cannot locate the PrimeCare repository from ${Directory.current.path}');
    }
    directory = parent;
  }
}
