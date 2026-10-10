import 'package:primecare_models/primecare_models.dart';
import '../auth/base_auth_workflow.dart';

typedef AuthorizedRequest = Future<Map<String, dynamic>> Function(String method, String path, {Map<String, dynamic>? body});

/// All account operations live here; UI adapters inherit state and commands.
abstract class BaseAdminWorkflow {
  final AuthorizedRequest request;
  BaseAdminWorkflow(this.request);
  List<AdminUser> users = const [];
  List<String> assignableRoles = const [];
  String organization = '';
  int total = 0;
  int active = 0;
  int offset = 0;
  bool busy = false;
  String? error;
  bool get hasNext => offset + users.length < total;
  void changed() {}
  Future<void> _run(Future<void> Function() operation) async {
    if (busy) return;
    busy = true; error = null; changed();
    try { await operation(); }
    catch (failure) { error = failure is AuthFailure ? failure.message : 'Admin service unavailable. Please retry.'; }
    finally { busy = false; changed(); }
  }
  Future<void> _load(int pageOffset) async {
    final data = await request('GET','/admin/workspace?offset=$pageOffset');
    final org = data['organization'];
    final rows = data['users'];
    final roles = data['assignableRoles'];
    if (org is! Map || org['name'] is! String || rows is! List || roles is! List || roles.any((r) => r is! String) || data['total'] is! int || data['active'] is! int || data['offset'] != pageOffset || data['limit'] != 25 || rows.length > 25 || (data['total'] as int) < 0 || (data['active'] as int) < 0 || (data['active'] as int) > (data['total'] as int)) {
      throw const AuthFailure('Invalid admin response');
    }
    final parsed = rows.map((row) => AdminUser.fromJson(Map<String,dynamic>.from(row as Map))).toList();
    users = parsed; assignableRoles = List<String>.from(roles); organization = org['name'] as String;
    total = data['total'] as int; active = data['active'] as int; offset = pageOffset;
  }
  Future<void> load({int pageOffset = 0}) => _run(() => _load(pageOffset));
  Future<void> create(String email, String role, String password) => _run(() async {
    await request('POST','/admin/workspace/users',body: {'email':email,'role':role,'password':password});
    await _load(0);
  });
  Future<void> update(AdminUser user, String email, String role, String status) => _run(() async {
    await request('PUT','/admin/workspace/users/${Uri.encodeComponent(user.id)}',body: {'email':email,'role':role,'status':status});
    await _load(offset);
  });
}
