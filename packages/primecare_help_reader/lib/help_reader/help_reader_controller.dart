import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:primecare_preferences/preference_sync/preference_protocol.dart' show PreferenceScope;
import 'help_reader_client.dart';

/// Presentation state for the registered reader; contains no permission grant.
class HelpReaderState {
  final String locale, query, phase;
  final int offset, limit, total;
  final List<Map<String, Object?>> items;
  final Map<String, Object?>? article;
  final HelpReaderFailure? failure;
  const HelpReaderState({this.locale = 'en', this.query = '', this.offset = 0,
    this.limit = 25, this.total = 0, this.items = const [], this.article,
    this.failure, this.phase = 'idle'});
  bool get loading => phase == 'loading';
  bool get canNext => phase == 'list' && offset + limit < total && offset + limit <= 100000;
  bool get canPrevious => (phase == 'list' || phase == 'empty') && offset > 0;
}

/// Unmounted controller. The registered host must call sessionChanged on its
/// authentication observer and retire on navigation/logout before unmounting.
/// The controller owns its reader; an injected HTTP client remains borrowed.
class HelpReaderController extends ChangeNotifier {
  final PreferenceScope scope;
  final String _token;
  final String? Function() _currentToken;
  final PreferenceScope? Function() _currentScope;
  final HelpReaderClient _reader;
  HelpReaderState _state;
  HelpReaderState get state => _state;
  bool get canRetry => !_disposed && !_retired && _state.phase == 'error' &&
      (_retryList || _retryArticle != null);
  int _generation = 0;
  bool _disposed = false, _retired = false;
  String? _retryArticle;
  bool _retryList = false;

  HelpReaderController({required Uri origin, required String token,
    required this.scope, required String? Function() currentToken,
    required PreferenceScope? Function() currentScope, String locale = 'en',
    int pageSize = 25, http.Client? client})
      : _token = token, _currentToken = currentToken, _currentScope = currentScope,
        _state = HelpReaderState(locale: _locale(locale), limit: _pageSize(pageSize)),
        _reader = HelpReaderClient(origin: origin, token: token, scope: scope,
          currentToken: currentToken, currentScope: currentScope, client: client);

  static String _locale(String value) {
    if (!const ['en', 'fr', 'es'].contains(value)) throw const HelpReaderFailure('invalid_request', 400);
    return value;
  }
  static int _pageSize(int value) {
    if (value < 1 || value > 100) throw const HelpReaderFailure('invalid_request', 400);
    return value;
  }
  bool _matchesSession() {
    if (_disposed || _retired) return false;
    try {
      final active = _currentScope();
      final matches = active != null && active.same(scope) && _currentToken() == _token;
      return !_disposed && !_retired && matches;
    } catch (_) { return false; }
  }
  bool _current(int generation) => !_disposed && !_retired && generation == _generation;
  void _set(HelpReaderState value) {
    if (_disposed) return;
    _state = value;
    notifyListeners();
  }

  Future<void> load() => _list(_state.locale, _state.query, _state.offset);
  Future<void> search(String query) => _list(_state.locale, query, 0);
  Future<void> changeLocale(String locale) => _list(locale, _state.query, 0);
  Future<void> nextPage() async {
    if (_state.canNext) await _list(_state.locale, _state.query, _state.offset + _state.limit);
  }
  Future<void> previousPage() async {
    if (_state.canPrevious) {
      final offset = _state.offset - _state.limit;
      await _list(_state.locale, _state.query, offset < 0 ? 0 : offset);
    }
  }
  Future<void> backToList() => _list(_state.locale, _state.query, _state.offset);
  Future<void> openArticle(String id) => _request(_state.locale, _state.query, _state.offset, articleId: id);
  Future<void> retry() async {
    if (_disposed || _retired || _state.loading || _state.phase != 'error') return;
    final article = _retryArticle;
    if (article != null) { await openArticle(article); }
    else if (_retryList) { await load(); }
  }
  Future<void> _list(String locale, String query, int offset) => _request(locale, query, offset);

  Future<void> _request(String locale, String query, int offset, {String? articleId}) async {
    if (_disposed || _retired) return;
    final beforeSessionCheck = _generation;
    final initialSessionMatches = _matchesSession();
    if (!_current(beforeSessionCheck)) return;
    if (!initialSessionMatches) { retire(); return; }
    // Reject unsupported locales before cancelling the current request or
    // publishing a loading state that cannot be fulfilled.
    _locale(locale);
    final previous = _state;
    final generation = ++_generation;
    // All private results are removed before notifying a new request's listeners.
    _retryArticle = null;
    _retryList = false;
    final loading = HelpReaderState(locale: locale, query: query,
      offset: offset, limit: previous.limit, phase: 'loading');
    _state = loading;
    _reader.cancelPending();
    _set(loading);
    if (!_current(generation)) return;
    try {
      final raw = articleId == null
        ? await _reader.list(locale: locale, query: query, offset: offset, limit: previous.limit)
        : await _reader.readArticle(locale: locale, articleId: articleId);
      if (!_current(generation)) return;
      final sessionMatches = _matchesSession();
      if (!_current(generation)) return;
      if (!sessionMatches) { retire(); return; }
      if (articleId != null) {
        _set(HelpReaderState(locale: locale, query: query, offset: offset, limit: previous.limit,
          article: raw['article'] as Map<String, Object?>, phase: 'detail'));
      } else {
        final items = List<Map<String, Object?>>.unmodifiable(
          (raw['items'] as List).cast<Map<String, Object?>>());
        _set(HelpReaderState(locale: locale, query: query, offset: offset, limit: previous.limit,
          total: raw['total'] as int, items: items, phase: items.isEmpty ? 'empty' : 'list'));
      }
    } catch (error) {
      if (!_current(generation)) return;
      final sessionMatches = _matchesSession();
      if (!_current(generation)) return;
      if (!sessionMatches) { retire(); return; }
      final failure = HelpReaderFailure.sanitize(error);
      if (!_current(generation)) return;
      if (failure.status == 401 || failure.status == 403 || failure.status == 409) {
        retire(failure: failure);
        return;
      }
      // Preserve a safe retry descriptor, never a private result or raw error.
      _retryArticle = failure.status == 400 ? null : articleId;
      _retryList = failure.status != 400 && articleId == null;
      _set(HelpReaderState(locale: failure.status == 400 ? previous.locale : locale,
        query: failure.status == 400 ? previous.query : query,
        offset: failure.status == 400 ? previous.offset : offset, limit: previous.limit,
        failure: failure, phase: 'error'));
    }
  }

  /// Called by the host's existing session observer; never polls credentials.
  void sessionChanged() {
    if (_disposed || _retired) return;
    final generation = _generation;
    final matches = _matchesSession();
    if (_current(generation) && !matches) retire();
  }
  void retire({HelpReaderFailure failure = const HelpReaderFailure('conflict', 409)}) {
    if (_disposed || _retired) return;
    _retired = true;
    final generation = ++_generation;
    _retryArticle = null;
    _retryList = false;
    final safeFailure = HelpReaderFailure.sanitize(failure);
    if (_disposed || generation != _generation) return;
    final retired = HelpReaderState(locale: _state.locale, limit: _state.limit,
      failure: safeFailure, phase: 'retired');
    _state = retired;
    _reader.cancelPending();
    _set(retired);
  }
  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _retired = true;
    _generation++;
    _retryArticle = null;
    _retryList = false;
    _state = HelpReaderState(locale: _state.locale, limit: _state.limit, phase: 'disposed');
    try { _reader.dispose(); } finally { super.dispose(); }
  }
}
