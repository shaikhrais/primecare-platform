import 'package:local_auth/local_auth.dart';

void main() {
  final auth = LocalAuthentication();
  // await auth.authenticate(localizedReason: 'test', biometricOnly: true, stickyAuth: true);
  print('Checking parameters via code completion/analysis...');
  // AuthenticationOptions opt; // This would cause a compile error if not found
}
