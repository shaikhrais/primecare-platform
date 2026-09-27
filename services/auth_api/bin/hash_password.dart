import 'dart:io';
import 'package:bcrypt/bcrypt.dart';

void main() {
  stdout.write('New password: ');
  final interactive = stdin.hasTerminal;
  final wasEchoing = interactive ? stdin.echoMode : false;
  if (interactive) stdin.echoMode = false;
  try {
    final password = stdin.readLineSync();
    stdout.writeln();
    if (password == null || password.length < 12) {
      stderr.writeln('Password must be at least 12 characters.');
      exitCode = 1;
      return;
    }
    stdout.writeln(BCrypt.hashpw(password, BCrypt.gensalt()));
  } finally {
    if (interactive) stdin.echoMode = wasEchoing;
  }
}
