import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/governance/governance_route_access.dart';

void main() {
  const route = '/governance/audit';
  Map<String, dynamic> workspace() => {
    'identity': {'userId': 'fixture-user', 'role': 'fixture-role'},
    'landing': route,
    'screens': [{'route': route}],
  };
  Future<String?> check(dynamic data, {String path = route, bool landing = false,
      bool Function()? current, Set<String> available = const {route}}) =>
      authorizeGovernanceRoute(path: path, landing: landing,
        userId: 'fixture-user', role: 'fixture-role', availableRoutes: available,
        loadWorkspace: () async => data, isCurrent: current ?? () => true);

  test('exact visible route and server landing are accepted', () async {
    expect(await check(workspace()), route);
    expect(await check(workspace(), path: '/login', landing: true), route);
    expect(await check(workspace(), available: {}), isNull);
  });

  test('inventory, local roles and similar CEO paths never authorize a route', () async {
    final data = workspace();
    data['inventory'] = [{'route': '/admin/reality-check'}];
    expect(await check(data, path: '/admin/reality-check',
      available: {'/admin/reality-check'}), isNull);
    data['screens'] = [{'route': '/offices/corporate/roles/ceo/growth-pipeline'}];
    expect(await check(data, path: '/generated/corporate/ceo/growth-pipeline',
      available: {'/generated/corporate/ceo/growth-pipeline'}), isNull);
    data['landing'] = '/admin/reality-check';
    expect(await check(data, landing: true,
      available: {'/admin/reality-check'}), isNull);
  });

  test('malformed, duplicate, foreign-identity and missing projections deny', () async {
    for (final data in [null, {}, [],
      {...workspace(), 'identity': {'userId': 'other', 'role': 'fixture-role'}},
      {...workspace(), 'identity': {'userId': 'fixture-user', 'role': 'other'}},
      {...workspace(), 'screens': null},
      {...workspace(), 'screens': [null]},
      {...workspace(), 'screens': [{'route': route}, {'route': route}]},
      ...['//foreign/path', '/bad?query', '/bad#fragment', '/bad path', '/bad\\path']
          .map((path) => {...workspace(), 'screens': [{'route': path}]}),
    ]) {
      expect(await check(data), isNull, reason: 'Invalid projection must fail closed');
    }
  });

  test('session changes invalidate delayed responses and fresh navigation rechecks grants', () async {
    final pending = Completer<dynamic>();
    var current = true;
    final result = authorizeGovernanceRoute(path: route, landing: false,
      userId: 'fixture-user', role: 'fixture-role', availableRoutes: {route},
      loadWorkspace: () => pending.future, isCurrent: () => current);
    current = false;
    pending.complete(workspace());
    expect(await result, isNull);
    expect(await check(workspace()), route);
    expect(await check({...workspace(), 'screens': []}), isNull);
  });

  test('transport errors and retired requests deny without a fallback grant', () async {
    var calls = 0;
    for (final active in [false, true]) {
      expect(await authorizeGovernanceRoute(path: route, landing: false,
        userId: 'fixture-user', role: 'fixture-role', availableRoutes: {route},
        loadWorkspace: () async {calls++; throw StateError('fixture unavailable');},
        isCurrent: () => active), isNull);
    }
    expect(calls, 1);
  });
}
