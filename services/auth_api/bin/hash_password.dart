import 'dart:io';
import 'package:bcrypt/bcrypt.dart';

void main() {
  stdout.write('New password: ');
  final wasEchoing = stdin.echoMode;
  stdin.echoMode = false;
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
    stdin.echoMode = wasEchoing;
  }
}
