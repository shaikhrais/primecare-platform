import 'package:primecare_core/primecare_core.dart';
export 'package:primecare_core/primecare_core.dart' show HttpAuthTransport;

/// Flutter adapter inherits all business/session behavior from the shared core.
class AuthController extends BaseAuthWorkflow {
  final void Function() onChanged;
  AuthController(super.transport, this.onChanged);
  @override
  void changed() => onChanged();
}
