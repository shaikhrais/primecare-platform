import 'package:primecare_core/primecare_core.dart';

class AdminController extends BaseAdminWorkflow {
  final void Function() onChanged;
  AdminController(super.request, this.onChanged);
  @override
  void changed() => onChanged();
}
