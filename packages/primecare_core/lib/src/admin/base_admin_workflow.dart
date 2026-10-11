import 'package:primecare_models/primecare_models.dart';
import '../auth/base_auth_workflow.dart';

typedef AuthorizedRequest = Future<Map<String, dynamic>> Function(String method, String path, {Map<String, dynamic>? body});

/// All account operations live here; UI adapters inherit state and commands.
abstract class BaseAdminWorkflow {
  final AuthorizedRequest request;
  BaseAdminWorkflow(this.request);
  List<AdminAuditEvent> events = const [];
  int auditTotal = 0;
  int auditOffset = 0;
  String auditUserId = '';
  bool get hasNextAudit => auditOffset + events.length < auditTotal;
  List<AdminTask> tasks = const [];
  List<AdminUser> users = const [];
  List<String> assignableRoles = const [];
  String organization = '';
  String search = '';
  String accountStatus = '';
  int total = 0;
  int active = 0;
  int offset = 0;
  bool busy = false;
  int stateRevision = 0;
  String? error;
  String? errorCode;
  bool get hasNext => offset + users.length < total;
  void changed() {}
  Future<void> execute(Future<void> Function() operation) async {
    if (busy) return;
    busy = true; error = null; errorCode = null; changed();
    try { await operation(); }
    catch (failure) { error = failure is AuthFailure ? failure.message : 'Admin service unavailable. Please retry.';
      errorCode = failure is AuthFailure ? (failure.code ?? switch(failure.status) {403 => 'error.forbidden', 401 => 'error.signInRequired', 404 => 'error.notFound', 409 => 'error.duplicateEmail', 400 || 413 => 'error.invalidRequest', 429 => 'error.rateLimit', _ => 'error.unavailable'}) : 'error.unavailable'; }
    finally { busy = false; stateRevision++; changed(); }
  }
  Future<void> _load(int pageOffset, {String? query, String? statusFilter}) async {
    final nextStatus = statusFilter ?? accountStatus;
    if (!['','active','inactive'].contains(nextStatus)) throw const AuthFailure('Invalid status filter',code:'error.invalidRequest');
    final nextSearch = (query ?? search).trim().toLowerCase();
    final path = '/admin/workspace?offset=$pageOffset${nextSearch.isEmpty ? '' : '&search=${Uri.encodeQueryComponent(nextSearch)}'}${nextStatus.isEmpty ? '' : '&status=$nextStatus'}';
    final data = await request('GET',path);
    final org = data['organization'];
    final rows = data['users'];
    final roles = data['assignableRoles'];
    final definitions = data['tasks'] ?? const <dynamic>[];
    if(definitions is! List || definitions.length > 50 || definitions.any((row)=>row is! Map)) throw const AuthFailure('Invalid task catalog',code:'error.invalidResponse');
    late final List<AdminTask> parsedTasks;
    try {parsedTasks = definitions.map((row)=>AdminTask.fromJson(Map<String,dynamic>.from(row as Map))).toList();}
    on FormatException {throw const AuthFailure('Invalid task catalog',code:'error.invalidResponse');}
    if(parsedTasks.map((task)=>task.id).toSet().length != parsedTasks.length) throw const AuthFailure('Duplicate task definitions',code:'error.invalidResponse');
    if ((data['status'] ?? '') != nextStatus || (data['search'] ?? '') != nextSearch || org is! Map || org['name'] is! String || rows is! List || roles is! List || roles.any((r) => r is! String) || data['total'] is! int || data['active'] is! int || data['offset'] != pageOffset || data['limit'] != 25 || rows.length > 25 || (data['total'] as int) < 0 || (data['active'] as int) < 0 || (data['active'] as int) > (data['total'] as int)) {
      throw const AuthFailure('Invalid admin response', code: 'error.invalidResponse');
    }
    final parsed = rows.map((row) => AdminUser.fromJson(Map<String,dynamic>.from(row as Map))).toList();
    if (nextStatus.isNotEmpty && parsed.any((user) => user.status != nextStatus) || nextStatus == 'active' && data['active'] != data['total'] || nextStatus == 'inactive' && data['active'] != 0) throw const AuthFailure('Invalid filtered response',code:'error.invalidResponse');
    tasks = List<AdminTask>.unmodifiable(parsedTasks); users = parsed; assignableRoles = List<String>.from(roles); organization = org['name'] as String;
    total = data['total'] as int; active = data['active'] as int; offset = pageOffset; search = nextSearch; accountStatus = nextStatus;
  }
  Future<void> loadAudit({int pageOffset = 0, String? userId}) => execute(() async {
    final nextUserId = (userId ?? auditUserId).toLowerCase();
    final path = '/admin/workspace/audit?offset=$pageOffset${nextUserId.isEmpty ? '' : '&userId=${Uri.encodeQueryComponent(nextUserId)}'}';
    final data = await request('GET',path);
    final rows = data['events'];
    if((data['userId'] ?? '') != nextUserId || rows is! List || rows.length > 25 || data['total'] is! int || (data['total'] as int) < 0 || data['offset'] != pageOffset || data['limit'] != 25) throw const AuthFailure('Invalid audit response',code:'error.invalidResponse');
    final parsed = rows.map((row) => AdminAuditEvent.fromJson(Map<String,dynamic>.from(row as Map))).toList();
    if(nextUserId.isNotEmpty && parsed.any((event) => event.target != nextUserId)) throw const AuthFailure('Invalid audit target',code:'error.invalidResponse');
    events = parsed; auditTotal = data['total'] as int; auditOffset = pageOffset; auditUserId = nextUserId;
  });
  Future<void> load({int pageOffset = 0, String? query, String? statusFilter}) => execute(() => _load(pageOffset,query:query,statusFilter:statusFilter));
  Future<void> create(String email, String role, String password) => execute(() async {
    await request('POST','/admin/workspace/users',body: {'email':email,'role':role,'password':password});
    await _load(0);
  });
  Future<void> update(AdminUser user, String email, String role, String status) => execute(() async {
    await request('PUT','/admin/workspace/users/${Uri.encodeComponent(user.id)}',body: {'email':email,'role':role,'status':status});
    await _load(offset);
  });
}
