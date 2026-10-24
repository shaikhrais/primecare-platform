import 'dart:math';
import 'package:flutter_core/platform/platform_master_repository.dart';
import 'package:primecare_models/primecare_models.dart';
import '../../application/base_workspace_controller.dart';

class PlatformMasterState extends BaseWorkspaceState<PlatformMasterState> {
  final PlatformAdministrationIndex? index;
  final String? tenant, notice;
  final List<PlatformMaster> records;
  final bool pending;
  final bool recordsLoaded;
  const PlatformMasterState({super.isLoading = false, super.error,
    this.index, this.tenant, this.notice, this.records = const [], this.pending = false, this.recordsLoaded = false})
      : super(title: '', logs: const [], hasData: index != null);
  @override
  PlatformMasterState rebuild({required bool isLoading, required String? error,
      required String title, required List<String> logs, required bool hasData}) =>
    PlatformMasterState(isLoading: isLoading, error: error, index: index, tenant: tenant,
      notice: notice, records: records, pending: pending, recordsLoaded: recordsLoaded);
}
class _MasterCommand {
  final String tenant, key;
  final Map<String, String> fields;
  bool uncertain = false;
  _MasterCommand(this.tenant, this.key, this.fields);
}

/// Shared workspace state lifecycle; all authorization remains in the API.
class PlatformMasterController extends BaseWorkspaceController<PlatformMasterState> {
  PlatformMasterController(this.repository, {required this.isCurrent, String Function()? key})
      : _key = key ?? _randomKey, super(const PlatformMasterState());
  final PlatformMasterRepository repository;
  final bool Function() isCurrent;
  final String Function() _key;
  _MasterCommand? _pending;
  int completedWrites = 0;
  PlatformMasterState get snapshot => state;
  Map<String, String> get pendingFields => _pending?.fields ?? const {};
  static String _randomKey() {
    final random = Random.secure();
    return List.generate(16, (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
  }
  bool get _active => mounted && isCurrent();
  bool get _available => _active && !state.isLoading;
  bool get canCreate => _available && _pending == null && state.index != null && state.tenant != null && state.recordsLoaded;
  void _fail(Object error, {bool readFailure = false}) {
    if (!_active) return;
    final status = error is PlatformAdministrationFailure ? error.status : 503;
    final pending = _pending;
    if (pending != null) {
      if (pending.uncertain || status >= 500 || status == 408) { pending.uncertain = true; }
      else { _pending = null; }
    }
    state = PlatformMasterState(index: status == 401 || status == 403 ? null : state.index,
      tenant: status == 401 || status == 403 ? null : state.tenant,
      recordsLoaded: !readFailure && status != 401 && status != 403 && state.recordsLoaded,
      records: readFailure || status == 401 || status == 403 ? const [] : state.records,
      error: status >= 500 ? 'unavailable' : 'request_failed', pending: _pending != null);
  }
  Future<void> load() async {
    if (!_available) return;
    final tenant = state.tenant;
    state = PlatformMasterState(index: state.index, tenant: tenant, records: state.records,
      recordsLoaded: state.recordsLoaded, isLoading: true, pending: _pending != null);
    try {
      final index = await repository.index();
      if (!_active) return;
      final selected = index.tenants.any((t) => t.id == tenant) ? tenant : null;
      final records = selected == null ? <PlatformMaster>[] : await repository.records(index, selected);
      if (!_active) return;
      state = PlatformMasterState(index: index, tenant: selected, records: records,
        recordsLoaded: selected != null, pending: _pending != null);
    } catch (error) { _fail(error, readFailure: true); }
  }
  Future<void> selectTenant(String tenant) async {
    if (!_available || _pending != null || state.index == null) return;
    final index = state.index!;
    if (!index.tenants.any((item) => item.id == tenant)) {
      _fail(const PlatformAdministrationFailure(403));
      return;
    }
    state = PlatformMasterState(index: index, tenant: tenant, isLoading: true);
    try {
      final records = await repository.records(index, tenant);
      if (!_active) return;
      state = PlatformMasterState(index: index, tenant: tenant, records: records, recordsLoaded: true);
    } catch (error) { _fail(error, readFailure: true); }
  }
  Future<bool> create(String type, String code, String label) async {
    if (!canCreate) return false;
    try {
      final fields = repository.command(state.index!, type, code, label);
      _pending = _MasterCommand(state.tenant!, _key(), fields);
      return _execute();
    } catch (error) { _fail(error); return false; }
  }
  Future<bool> retryPending() async {
    if (!_available || _pending == null || state.index == null) return false;
    return _execute();
  }
  Future<bool> _execute() async {
    final command = _pending!, index = state.index!;
    state = PlatformMasterState(index: index, tenant: command.tenant, records: state.records,
      recordsLoaded: state.recordsLoaded, isLoading: true, pending: true);
    try {
      final receipt = await repository.create(index, command.tenant, command.fields, command.key);
      if (!_active) return false;
      // The write may already have committed even if subsequent readback fails.
      command.uncertain = true;
      final records = await repository.records(index, command.tenant);
      if (!_active) return false;
      if (!records.any((record) => record.same(receipt))) throw const FormatException('Master readback mismatch');
      _pending = null;
      completedWrites++;
      state = PlatformMasterState(index: index, tenant: command.tenant, records: records,
        recordsLoaded: true, notice: 'master_created');
      return true;
    } catch (error) { _fail(error); return false; }
  }
  @override
  void dispose() {
    if (!mounted) return;
    _pending = null;
    state = const PlatformMasterState();
    super.dispose();
  }
}
