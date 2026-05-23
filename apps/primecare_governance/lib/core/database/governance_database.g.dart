// Governance - Category: service | Purpose: GENERATED CODE - DO NOT MODIFY BY HAND ignore_for_file: type=lint
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governance_database.dart';

// ignore_for_file: type=lint
class $GovernanceSnapshotsTable extends GovernanceSnapshots
    with TableInfo<$GovernanceSnapshotsTable, GovernanceSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GovernanceSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _healthScoreMeta = const VerificationMeta(
    'healthScore',
  );
  @override
  late final GeneratedColumn<double> healthScore = GeneratedColumn<double>(
    'health_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _criticalIssuesMeta = const VerificationMeta(
    'criticalIssues',
  );
  @override
  late final GeneratedColumn<int> criticalIssues = GeneratedColumn<int>(
    'critical_issues',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _highIssuesMeta = const VerificationMeta(
    'highIssues',
  );
  @override
  late final GeneratedColumn<int> highIssues = GeneratedColumn<int>(
    'high_issues',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediumIssuesMeta = const VerificationMeta(
    'mediumIssues',
  );
  @override
  late final GeneratedColumn<int> mediumIssues = GeneratedColumn<int>(
    'medium_issues',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lowIssuesMeta = const VerificationMeta(
    'lowIssues',
  );
  @override
  late final GeneratedColumn<int> lowIssues = GeneratedColumn<int>(
    'low_issues',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalScreensMeta = const VerificationMeta(
    'totalScreens',
  );
  @override
  late final GeneratedColumn<int> totalScreens = GeneratedColumn<int>(
    'total_screens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productionReadyScreensMeta =
      const VerificationMeta('productionReadyScreens');
  @override
  late final GeneratedColumn<int> productionReadyScreens = GeneratedColumn<int>(
    'production_ready_screens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    healthScore,
    criticalIssues,
    highIssues,
    mediumIssues,
    lowIssues,
    totalScreens,
    productionReadyScreens,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'governance_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<GovernanceSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('health_score')) {
      context.handle(
        _healthScoreMeta,
        healthScore.isAcceptableOrUnknown(
          data['health_score']!,
          _healthScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_healthScoreMeta);
    }
    if (data.containsKey('critical_issues')) {
      context.handle(
        _criticalIssuesMeta,
        criticalIssues.isAcceptableOrUnknown(
          data['critical_issues']!,
          _criticalIssuesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_criticalIssuesMeta);
    }
    if (data.containsKey('high_issues')) {
      context.handle(
        _highIssuesMeta,
        highIssues.isAcceptableOrUnknown(data['high_issues']!, _highIssuesMeta),
      );
    } else if (isInserting) {
      context.missing(_highIssuesMeta);
    }
    if (data.containsKey('medium_issues')) {
      context.handle(
        _mediumIssuesMeta,
        mediumIssues.isAcceptableOrUnknown(
          data['medium_issues']!,
          _mediumIssuesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediumIssuesMeta);
    }
    if (data.containsKey('low_issues')) {
      context.handle(
        _lowIssuesMeta,
        lowIssues.isAcceptableOrUnknown(data['low_issues']!, _lowIssuesMeta),
      );
    } else if (isInserting) {
      context.missing(_lowIssuesMeta);
    }
    if (data.containsKey('total_screens')) {
      context.handle(
        _totalScreensMeta,
        totalScreens.isAcceptableOrUnknown(
          data['total_screens']!,
          _totalScreensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalScreensMeta);
    }
    if (data.containsKey('production_ready_screens')) {
      context.handle(
        _productionReadyScreensMeta,
        productionReadyScreens.isAcceptableOrUnknown(
          data['production_ready_screens']!,
          _productionReadyScreensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productionReadyScreensMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GovernanceSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GovernanceSnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      healthScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}health_score'],
      )!,
      criticalIssues: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}critical_issues'],
      )!,
      highIssues: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}high_issues'],
      )!,
      mediumIssues: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}medium_issues'],
      )!,
      lowIssues: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}low_issues'],
      )!,
      totalScreens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_screens'],
      )!,
      productionReadyScreens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}production_ready_screens'],
      )!,
    );
  }

  @override
  $GovernanceSnapshotsTable createAlias(String alias) {
    return $GovernanceSnapshotsTable(attachedDatabase, alias);
  }
}

class GovernanceSnapshot extends DataClass
    implements Insertable<GovernanceSnapshot> {
  final int id;
  final DateTime timestamp;
  final double healthScore;
  final int criticalIssues;
  final int highIssues;
  final int mediumIssues;
  final int lowIssues;
  final int totalScreens;
  final int productionReadyScreens;
  const GovernanceSnapshot({
    required this.id,
    required this.timestamp,
    required this.healthScore,
    required this.criticalIssues,
    required this.highIssues,
    required this.mediumIssues,
    required this.lowIssues,
    required this.totalScreens,
    required this.productionReadyScreens,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['health_score'] = Variable<double>(healthScore);
    map['critical_issues'] = Variable<int>(criticalIssues);
    map['high_issues'] = Variable<int>(highIssues);
    map['medium_issues'] = Variable<int>(mediumIssues);
    map['low_issues'] = Variable<int>(lowIssues);
    map['total_screens'] = Variable<int>(totalScreens);
    map['production_ready_screens'] = Variable<int>(productionReadyScreens);
    return map;
  }

  GovernanceSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return GovernanceSnapshotsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      healthScore: Value(healthScore),
      criticalIssues: Value(criticalIssues),
      highIssues: Value(highIssues),
      mediumIssues: Value(mediumIssues),
      lowIssues: Value(lowIssues),
      totalScreens: Value(totalScreens),
      productionReadyScreens: Value(productionReadyScreens),
    );
  }

  factory GovernanceSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GovernanceSnapshot(
      id: serializer.fromJson<int>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      healthScore: serializer.fromJson<double>(json['healthScore']),
      criticalIssues: serializer.fromJson<int>(json['criticalIssues']),
      highIssues: serializer.fromJson<int>(json['highIssues']),
      mediumIssues: serializer.fromJson<int>(json['mediumIssues']),
      lowIssues: serializer.fromJson<int>(json['lowIssues']),
      totalScreens: serializer.fromJson<int>(json['totalScreens']),
      productionReadyScreens: serializer.fromJson<int>(
        json['productionReadyScreens'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'healthScore': serializer.toJson<double>(healthScore),
      'criticalIssues': serializer.toJson<int>(criticalIssues),
      'highIssues': serializer.toJson<int>(highIssues),
      'mediumIssues': serializer.toJson<int>(mediumIssues),
      'lowIssues': serializer.toJson<int>(lowIssues),
      'totalScreens': serializer.toJson<int>(totalScreens),
      'productionReadyScreens': serializer.toJson<int>(productionReadyScreens),
    };
  }

  GovernanceSnapshot copyWith({
    int? id,
    DateTime? timestamp,
    double? healthScore,
    int? criticalIssues,
    int? highIssues,
    int? mediumIssues,
    int? lowIssues,
    int? totalScreens,
    int? productionReadyScreens,
  }) => GovernanceSnapshot(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    healthScore: healthScore ?? this.healthScore,
    criticalIssues: criticalIssues ?? this.criticalIssues,
    highIssues: highIssues ?? this.highIssues,
    mediumIssues: mediumIssues ?? this.mediumIssues,
    lowIssues: lowIssues ?? this.lowIssues,
    totalScreens: totalScreens ?? this.totalScreens,
    productionReadyScreens:
        productionReadyScreens ?? this.productionReadyScreens,
  );
  GovernanceSnapshot copyWithCompanion(GovernanceSnapshotsCompanion data) {
    return GovernanceSnapshot(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      healthScore: data.healthScore.present
          ? data.healthScore.value
          : this.healthScore,
      criticalIssues: data.criticalIssues.present
          ? data.criticalIssues.value
          : this.criticalIssues,
      highIssues: data.highIssues.present
          ? data.highIssues.value
          : this.highIssues,
      mediumIssues: data.mediumIssues.present
          ? data.mediumIssues.value
          : this.mediumIssues,
      lowIssues: data.lowIssues.present ? data.lowIssues.value : this.lowIssues,
      totalScreens: data.totalScreens.present
          ? data.totalScreens.value
          : this.totalScreens,
      productionReadyScreens: data.productionReadyScreens.present
          ? data.productionReadyScreens.value
          : this.productionReadyScreens,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GovernanceSnapshot(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('healthScore: $healthScore, ')
          ..write('criticalIssues: $criticalIssues, ')
          ..write('highIssues: $highIssues, ')
          ..write('mediumIssues: $mediumIssues, ')
          ..write('lowIssues: $lowIssues, ')
          ..write('totalScreens: $totalScreens, ')
          ..write('productionReadyScreens: $productionReadyScreens')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    healthScore,
    criticalIssues,
    highIssues,
    mediumIssues,
    lowIssues,
    totalScreens,
    productionReadyScreens,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GovernanceSnapshot &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.healthScore == this.healthScore &&
          other.criticalIssues == this.criticalIssues &&
          other.highIssues == this.highIssues &&
          other.mediumIssues == this.mediumIssues &&
          other.lowIssues == this.lowIssues &&
          other.totalScreens == this.totalScreens &&
          other.productionReadyScreens == this.productionReadyScreens);
}

class GovernanceSnapshotsCompanion extends UpdateCompanion<GovernanceSnapshot> {
  final Value<int> id;
  final Value<DateTime> timestamp;
  final Value<double> healthScore;
  final Value<int> criticalIssues;
  final Value<int> highIssues;
  final Value<int> mediumIssues;
  final Value<int> lowIssues;
  final Value<int> totalScreens;
  final Value<int> productionReadyScreens;
  const GovernanceSnapshotsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.healthScore = const Value.absent(),
    this.criticalIssues = const Value.absent(),
    this.highIssues = const Value.absent(),
    this.mediumIssues = const Value.absent(),
    this.lowIssues = const Value.absent(),
    this.totalScreens = const Value.absent(),
    this.productionReadyScreens = const Value.absent(),
  });
  GovernanceSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    required double healthScore,
    required int criticalIssues,
    required int highIssues,
    required int mediumIssues,
    required int lowIssues,
    required int totalScreens,
    required int productionReadyScreens,
  }) : healthScore = Value(healthScore),
       criticalIssues = Value(criticalIssues),
       highIssues = Value(highIssues),
       mediumIssues = Value(mediumIssues),
       lowIssues = Value(lowIssues),
       totalScreens = Value(totalScreens),
       productionReadyScreens = Value(productionReadyScreens);
  static Insertable<GovernanceSnapshot> custom({
    Expression<int>? id,
    Expression<DateTime>? timestamp,
    Expression<double>? healthScore,
    Expression<int>? criticalIssues,
    Expression<int>? highIssues,
    Expression<int>? mediumIssues,
    Expression<int>? lowIssues,
    Expression<int>? totalScreens,
    Expression<int>? productionReadyScreens,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (healthScore != null) 'health_score': healthScore,
      if (criticalIssues != null) 'critical_issues': criticalIssues,
      if (highIssues != null) 'high_issues': highIssues,
      if (mediumIssues != null) 'medium_issues': mediumIssues,
      if (lowIssues != null) 'low_issues': lowIssues,
      if (totalScreens != null) 'total_screens': totalScreens,
      if (productionReadyScreens != null)
        'production_ready_screens': productionReadyScreens,
    });
  }

  GovernanceSnapshotsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? timestamp,
    Value<double>? healthScore,
    Value<int>? criticalIssues,
    Value<int>? highIssues,
    Value<int>? mediumIssues,
    Value<int>? lowIssues,
    Value<int>? totalScreens,
    Value<int>? productionReadyScreens,
  }) {
    return GovernanceSnapshotsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      healthScore: healthScore ?? this.healthScore,
      criticalIssues: criticalIssues ?? this.criticalIssues,
      highIssues: highIssues ?? this.highIssues,
      mediumIssues: mediumIssues ?? this.mediumIssues,
      lowIssues: lowIssues ?? this.lowIssues,
      totalScreens: totalScreens ?? this.totalScreens,
      productionReadyScreens:
          productionReadyScreens ?? this.productionReadyScreens,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (healthScore.present) {
      map['health_score'] = Variable<double>(healthScore.value);
    }
    if (criticalIssues.present) {
      map['critical_issues'] = Variable<int>(criticalIssues.value);
    }
    if (highIssues.present) {
      map['high_issues'] = Variable<int>(highIssues.value);
    }
    if (mediumIssues.present) {
      map['medium_issues'] = Variable<int>(mediumIssues.value);
    }
    if (lowIssues.present) {
      map['low_issues'] = Variable<int>(lowIssues.value);
    }
    if (totalScreens.present) {
      map['total_screens'] = Variable<int>(totalScreens.value);
    }
    if (productionReadyScreens.present) {
      map['production_ready_screens'] = Variable<int>(
        productionReadyScreens.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GovernanceSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('healthScore: $healthScore, ')
          ..write('criticalIssues: $criticalIssues, ')
          ..write('highIssues: $highIssues, ')
          ..write('mediumIssues: $mediumIssues, ')
          ..write('lowIssues: $lowIssues, ')
          ..write('totalScreens: $totalScreens, ')
          ..write('productionReadyScreens: $productionReadyScreens')
          ..write(')'))
        .toString();
  }
}

class $ProposalsTable extends Proposals
    with TableInfo<$ProposalsTable, Proposal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProposalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requestedByMeta = const VerificationMeta(
    'requestedBy',
  );
  @override
  late final GeneratedColumn<String> requestedBy = GeneratedColumn<String>(
    'requested_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _officeMeta = const VerificationMeta('office');
  @override
  late final GeneratedColumn<String> office = GeneratedColumn<String>(
    'office',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessGoalMeta = const VerificationMeta(
    'businessGoal',
  );
  @override
  late final GeneratedColumn<String> businessGoal = GeneratedColumn<String>(
    'business_goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _problemStatementMeta = const VerificationMeta(
    'problemStatement',
  );
  @override
  late final GeneratedColumn<String> problemStatement = GeneratedColumn<String>(
    'problem_statement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedOutcomeMeta = const VerificationMeta(
    'expectedOutcome',
  );
  @override
  late final GeneratedColumn<String> expectedOutcome = GeneratedColumn<String>(
    'expected_outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _screenIdMeta = const VerificationMeta(
    'screenId',
  );
  @override
  late final GeneratedColumn<String> screenId = GeneratedColumn<String>(
    'screen_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routePathMeta = const VerificationMeta(
    'routePath',
  );
  @override
  late final GeneratedColumn<String> routePath = GeneratedColumn<String>(
    'route_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allowedRolesMeta = const VerificationMeta(
    'allowedRoles',
  );
  @override
  late final GeneratedColumn<String> allowedRoles = GeneratedColumn<String>(
    'allowed_roles',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requiredApisMeta = const VerificationMeta(
    'requiredApis',
  );
  @override
  late final GeneratedColumn<String> requiredApis = GeneratedColumn<String>(
    'required_apis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requiredComponentsMeta =
      const VerificationMeta('requiredComponents');
  @override
  late final GeneratedColumn<String> requiredComponents =
      GeneratedColumn<String>(
        'required_components',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _requiredFormsMeta = const VerificationMeta(
    'requiredForms',
  );
  @override
  late final GeneratedColumn<String> requiredForms = GeneratedColumn<String>(
    'required_forms',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _designSourceMeta = const VerificationMeta(
    'designSource',
  );
  @override
  late final GeneratedColumn<String> designSource = GeneratedColumn<String>(
    'design_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _designUrlMeta = const VerificationMeta(
    'designUrl',
  );
  @override
  late final GeneratedColumn<String> designUrl = GeneratedColumn<String>(
    'design_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mockDataNotesMeta = const VerificationMeta(
    'mockDataNotes',
  );
  @override
  late final GeneratedColumn<String> mockDataNotes = GeneratedColumn<String>(
    'mock_data_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _needsPhiDataMeta = const VerificationMeta(
    'needsPhiData',
  );
  @override
  late final GeneratedColumn<bool> needsPhiData = GeneratedColumn<bool>(
    'needs_phi_data',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_phi_data" IN (0, 1))',
    ),
  );
  static const VerificationMeta _needsConsentMeta = const VerificationMeta(
    'needsConsent',
  );
  @override
  late final GeneratedColumn<bool> needsConsent = GeneratedColumn<bool>(
    'needs_consent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_consent" IN (0, 1))',
    ),
  );
  static const VerificationMeta _needsSignatureMeta = const VerificationMeta(
    'needsSignature',
  );
  @override
  late final GeneratedColumn<bool> needsSignature = GeneratedColumn<bool>(
    'needs_signature',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_signature" IN (0, 1))',
    ),
  );
  static const VerificationMeta _needsAuditLogMeta = const VerificationMeta(
    'needsAuditLog',
  );
  @override
  late final GeneratedColumn<bool> needsAuditLog = GeneratedColumn<bool>(
    'needs_audit_log',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_audit_log" IN (0, 1))',
    ),
  );
  static const VerificationMeta _acceptanceCriteriaMeta =
      const VerificationMeta('acceptanceCriteria');
  @override
  late final GeneratedColumn<String> acceptanceCriteria =
      GeneratedColumn<String>(
        'acceptance_criteria',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _testScenariosMeta = const VerificationMeta(
    'testScenarios',
  );
  @override
  late final GeneratedColumn<String> testScenarios = GeneratedColumn<String>(
    'test_scenarios',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    requestedBy,
    department,
    office,
    role,
    priority,
    businessGoal,
    problemStatement,
    expectedOutcome,
    screenId,
    routePath,
    allowedRoles,
    requiredApis,
    requiredComponents,
    requiredForms,
    designSource,
    designUrl,
    mockDataNotes,
    needsPhiData,
    needsConsent,
    needsSignature,
    needsAuditLog,
    acceptanceCriteria,
    testScenarios,
    createdAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proposals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Proposal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('requested_by')) {
      context.handle(
        _requestedByMeta,
        requestedBy.isAcceptableOrUnknown(
          data['requested_by']!,
          _requestedByMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requestedByMeta);
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    } else if (isInserting) {
      context.missing(_departmentMeta);
    }
    if (data.containsKey('office')) {
      context.handle(
        _officeMeta,
        office.isAcceptableOrUnknown(data['office']!, _officeMeta),
      );
    } else if (isInserting) {
      context.missing(_officeMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('business_goal')) {
      context.handle(
        _businessGoalMeta,
        businessGoal.isAcceptableOrUnknown(
          data['business_goal']!,
          _businessGoalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_businessGoalMeta);
    }
    if (data.containsKey('problem_statement')) {
      context.handle(
        _problemStatementMeta,
        problemStatement.isAcceptableOrUnknown(
          data['problem_statement']!,
          _problemStatementMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_problemStatementMeta);
    }
    if (data.containsKey('expected_outcome')) {
      context.handle(
        _expectedOutcomeMeta,
        expectedOutcome.isAcceptableOrUnknown(
          data['expected_outcome']!,
          _expectedOutcomeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedOutcomeMeta);
    }
    if (data.containsKey('screen_id')) {
      context.handle(
        _screenIdMeta,
        screenId.isAcceptableOrUnknown(data['screen_id']!, _screenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_screenIdMeta);
    }
    if (data.containsKey('route_path')) {
      context.handle(
        _routePathMeta,
        routePath.isAcceptableOrUnknown(data['route_path']!, _routePathMeta),
      );
    } else if (isInserting) {
      context.missing(_routePathMeta);
    }
    if (data.containsKey('allowed_roles')) {
      context.handle(
        _allowedRolesMeta,
        allowedRoles.isAcceptableOrUnknown(
          data['allowed_roles']!,
          _allowedRolesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allowedRolesMeta);
    }
    if (data.containsKey('required_apis')) {
      context.handle(
        _requiredApisMeta,
        requiredApis.isAcceptableOrUnknown(
          data['required_apis']!,
          _requiredApisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredApisMeta);
    }
    if (data.containsKey('required_components')) {
      context.handle(
        _requiredComponentsMeta,
        requiredComponents.isAcceptableOrUnknown(
          data['required_components']!,
          _requiredComponentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredComponentsMeta);
    }
    if (data.containsKey('required_forms')) {
      context.handle(
        _requiredFormsMeta,
        requiredForms.isAcceptableOrUnknown(
          data['required_forms']!,
          _requiredFormsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredFormsMeta);
    }
    if (data.containsKey('design_source')) {
      context.handle(
        _designSourceMeta,
        designSource.isAcceptableOrUnknown(
          data['design_source']!,
          _designSourceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_designSourceMeta);
    }
    if (data.containsKey('design_url')) {
      context.handle(
        _designUrlMeta,
        designUrl.isAcceptableOrUnknown(data['design_url']!, _designUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_designUrlMeta);
    }
    if (data.containsKey('mock_data_notes')) {
      context.handle(
        _mockDataNotesMeta,
        mockDataNotes.isAcceptableOrUnknown(
          data['mock_data_notes']!,
          _mockDataNotesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mockDataNotesMeta);
    }
    if (data.containsKey('needs_phi_data')) {
      context.handle(
        _needsPhiDataMeta,
        needsPhiData.isAcceptableOrUnknown(
          data['needs_phi_data']!,
          _needsPhiDataMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_needsPhiDataMeta);
    }
    if (data.containsKey('needs_consent')) {
      context.handle(
        _needsConsentMeta,
        needsConsent.isAcceptableOrUnknown(
          data['needs_consent']!,
          _needsConsentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_needsConsentMeta);
    }
    if (data.containsKey('needs_signature')) {
      context.handle(
        _needsSignatureMeta,
        needsSignature.isAcceptableOrUnknown(
          data['needs_signature']!,
          _needsSignatureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_needsSignatureMeta);
    }
    if (data.containsKey('needs_audit_log')) {
      context.handle(
        _needsAuditLogMeta,
        needsAuditLog.isAcceptableOrUnknown(
          data['needs_audit_log']!,
          _needsAuditLogMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_needsAuditLogMeta);
    }
    if (data.containsKey('acceptance_criteria')) {
      context.handle(
        _acceptanceCriteriaMeta,
        acceptanceCriteria.isAcceptableOrUnknown(
          data['acceptance_criteria']!,
          _acceptanceCriteriaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_acceptanceCriteriaMeta);
    }
    if (data.containsKey('test_scenarios')) {
      context.handle(
        _testScenariosMeta,
        testScenarios.isAcceptableOrUnknown(
          data['test_scenarios']!,
          _testScenariosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_testScenariosMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Proposal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Proposal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      requestedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requested_by'],
      )!,
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      )!,
      office: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}office'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      businessGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_goal'],
      )!,
      problemStatement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}problem_statement'],
      )!,
      expectedOutcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expected_outcome'],
      )!,
      screenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}screen_id'],
      )!,
      routePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route_path'],
      )!,
      allowedRoles: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allowed_roles'],
      )!,
      requiredApis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}required_apis'],
      )!,
      requiredComponents: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}required_components'],
      )!,
      requiredForms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}required_forms'],
      )!,
      designSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}design_source'],
      )!,
      designUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}design_url'],
      )!,
      mockDataNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mock_data_notes'],
      )!,
      needsPhiData: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_phi_data'],
      )!,
      needsConsent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_consent'],
      )!,
      needsSignature: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_signature'],
      )!,
      needsAuditLog: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_audit_log'],
      )!,
      acceptanceCriteria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}acceptance_criteria'],
      )!,
      testScenarios: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_scenarios'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ProposalsTable createAlias(String alias) {
    return $ProposalsTable(attachedDatabase, alias);
  }
}

class Proposal extends DataClass implements Insertable<Proposal> {
  final String id;
  final String title;
  final String description;
  final String requestedBy;
  final String department;
  final String office;
  final String role;
  final String priority;
  final String businessGoal;
  final String problemStatement;
  final String expectedOutcome;
  final String screenId;
  final String routePath;
  final String allowedRoles;
  final String requiredApis;
  final String requiredComponents;
  final String requiredForms;
  final String designSource;
  final String designUrl;
  final String mockDataNotes;
  final bool needsPhiData;
  final bool needsConsent;
  final bool needsSignature;
  final bool needsAuditLog;
  final String acceptanceCriteria;
  final String testScenarios;
  final DateTime createdAt;
  final String status;
  const Proposal({
    required this.id,
    required this.title,
    required this.description,
    required this.requestedBy,
    required this.department,
    required this.office,
    required this.role,
    required this.priority,
    required this.businessGoal,
    required this.problemStatement,
    required this.expectedOutcome,
    required this.screenId,
    required this.routePath,
    required this.allowedRoles,
    required this.requiredApis,
    required this.requiredComponents,
    required this.requiredForms,
    required this.designSource,
    required this.designUrl,
    required this.mockDataNotes,
    required this.needsPhiData,
    required this.needsConsent,
    required this.needsSignature,
    required this.needsAuditLog,
    required this.acceptanceCriteria,
    required this.testScenarios,
    required this.createdAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['requested_by'] = Variable<String>(requestedBy);
    map['department'] = Variable<String>(department);
    map['office'] = Variable<String>(office);
    map['role'] = Variable<String>(role);
    map['priority'] = Variable<String>(priority);
    map['business_goal'] = Variable<String>(businessGoal);
    map['problem_statement'] = Variable<String>(problemStatement);
    map['expected_outcome'] = Variable<String>(expectedOutcome);
    map['screen_id'] = Variable<String>(screenId);
    map['route_path'] = Variable<String>(routePath);
    map['allowed_roles'] = Variable<String>(allowedRoles);
    map['required_apis'] = Variable<String>(requiredApis);
    map['required_components'] = Variable<String>(requiredComponents);
    map['required_forms'] = Variable<String>(requiredForms);
    map['design_source'] = Variable<String>(designSource);
    map['design_url'] = Variable<String>(designUrl);
    map['mock_data_notes'] = Variable<String>(mockDataNotes);
    map['needs_phi_data'] = Variable<bool>(needsPhiData);
    map['needs_consent'] = Variable<bool>(needsConsent);
    map['needs_signature'] = Variable<bool>(needsSignature);
    map['needs_audit_log'] = Variable<bool>(needsAuditLog);
    map['acceptance_criteria'] = Variable<String>(acceptanceCriteria);
    map['test_scenarios'] = Variable<String>(testScenarios);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  ProposalsCompanion toCompanion(bool nullToAbsent) {
    return ProposalsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      requestedBy: Value(requestedBy),
      department: Value(department),
      office: Value(office),
      role: Value(role),
      priority: Value(priority),
      businessGoal: Value(businessGoal),
      problemStatement: Value(problemStatement),
      expectedOutcome: Value(expectedOutcome),
      screenId: Value(screenId),
      routePath: Value(routePath),
      allowedRoles: Value(allowedRoles),
      requiredApis: Value(requiredApis),
      requiredComponents: Value(requiredComponents),
      requiredForms: Value(requiredForms),
      designSource: Value(designSource),
      designUrl: Value(designUrl),
      mockDataNotes: Value(mockDataNotes),
      needsPhiData: Value(needsPhiData),
      needsConsent: Value(needsConsent),
      needsSignature: Value(needsSignature),
      needsAuditLog: Value(needsAuditLog),
      acceptanceCriteria: Value(acceptanceCriteria),
      testScenarios: Value(testScenarios),
      createdAt: Value(createdAt),
      status: Value(status),
    );
  }

  factory Proposal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Proposal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      requestedBy: serializer.fromJson<String>(json['requestedBy']),
      department: serializer.fromJson<String>(json['department']),
      office: serializer.fromJson<String>(json['office']),
      role: serializer.fromJson<String>(json['role']),
      priority: serializer.fromJson<String>(json['priority']),
      businessGoal: serializer.fromJson<String>(json['businessGoal']),
      problemStatement: serializer.fromJson<String>(json['problemStatement']),
      expectedOutcome: serializer.fromJson<String>(json['expectedOutcome']),
      screenId: serializer.fromJson<String>(json['screenId']),
      routePath: serializer.fromJson<String>(json['routePath']),
      allowedRoles: serializer.fromJson<String>(json['allowedRoles']),
      requiredApis: serializer.fromJson<String>(json['requiredApis']),
      requiredComponents: serializer.fromJson<String>(
        json['requiredComponents'],
      ),
      requiredForms: serializer.fromJson<String>(json['requiredForms']),
      designSource: serializer.fromJson<String>(json['designSource']),
      designUrl: serializer.fromJson<String>(json['designUrl']),
      mockDataNotes: serializer.fromJson<String>(json['mockDataNotes']),
      needsPhiData: serializer.fromJson<bool>(json['needsPhiData']),
      needsConsent: serializer.fromJson<bool>(json['needsConsent']),
      needsSignature: serializer.fromJson<bool>(json['needsSignature']),
      needsAuditLog: serializer.fromJson<bool>(json['needsAuditLog']),
      acceptanceCriteria: serializer.fromJson<String>(
        json['acceptanceCriteria'],
      ),
      testScenarios: serializer.fromJson<String>(json['testScenarios']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'requestedBy': serializer.toJson<String>(requestedBy),
      'department': serializer.toJson<String>(department),
      'office': serializer.toJson<String>(office),
      'role': serializer.toJson<String>(role),
      'priority': serializer.toJson<String>(priority),
      'businessGoal': serializer.toJson<String>(businessGoal),
      'problemStatement': serializer.toJson<String>(problemStatement),
      'expectedOutcome': serializer.toJson<String>(expectedOutcome),
      'screenId': serializer.toJson<String>(screenId),
      'routePath': serializer.toJson<String>(routePath),
      'allowedRoles': serializer.toJson<String>(allowedRoles),
      'requiredApis': serializer.toJson<String>(requiredApis),
      'requiredComponents': serializer.toJson<String>(requiredComponents),
      'requiredForms': serializer.toJson<String>(requiredForms),
      'designSource': serializer.toJson<String>(designSource),
      'designUrl': serializer.toJson<String>(designUrl),
      'mockDataNotes': serializer.toJson<String>(mockDataNotes),
      'needsPhiData': serializer.toJson<bool>(needsPhiData),
      'needsConsent': serializer.toJson<bool>(needsConsent),
      'needsSignature': serializer.toJson<bool>(needsSignature),
      'needsAuditLog': serializer.toJson<bool>(needsAuditLog),
      'acceptanceCriteria': serializer.toJson<String>(acceptanceCriteria),
      'testScenarios': serializer.toJson<String>(testScenarios),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
    };
  }

  Proposal copyWith({
    String? id,
    String? title,
    String? description,
    String? requestedBy,
    String? department,
    String? office,
    String? role,
    String? priority,
    String? businessGoal,
    String? problemStatement,
    String? expectedOutcome,
    String? screenId,
    String? routePath,
    String? allowedRoles,
    String? requiredApis,
    String? requiredComponents,
    String? requiredForms,
    String? designSource,
    String? designUrl,
    String? mockDataNotes,
    bool? needsPhiData,
    bool? needsConsent,
    bool? needsSignature,
    bool? needsAuditLog,
    String? acceptanceCriteria,
    String? testScenarios,
    DateTime? createdAt,
    String? status,
  }) => Proposal(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    requestedBy: requestedBy ?? this.requestedBy,
    department: department ?? this.department,
    office: office ?? this.office,
    role: role ?? this.role,
    priority: priority ?? this.priority,
    businessGoal: businessGoal ?? this.businessGoal,
    problemStatement: problemStatement ?? this.problemStatement,
    expectedOutcome: expectedOutcome ?? this.expectedOutcome,
    screenId: screenId ?? this.screenId,
    routePath: routePath ?? this.routePath,
    allowedRoles: allowedRoles ?? this.allowedRoles,
    requiredApis: requiredApis ?? this.requiredApis,
    requiredComponents: requiredComponents ?? this.requiredComponents,
    requiredForms: requiredForms ?? this.requiredForms,
    designSource: designSource ?? this.designSource,
    designUrl: designUrl ?? this.designUrl,
    mockDataNotes: mockDataNotes ?? this.mockDataNotes,
    needsPhiData: needsPhiData ?? this.needsPhiData,
    needsConsent: needsConsent ?? this.needsConsent,
    needsSignature: needsSignature ?? this.needsSignature,
    needsAuditLog: needsAuditLog ?? this.needsAuditLog,
    acceptanceCriteria: acceptanceCriteria ?? this.acceptanceCriteria,
    testScenarios: testScenarios ?? this.testScenarios,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
  );
  Proposal copyWithCompanion(ProposalsCompanion data) {
    return Proposal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      requestedBy: data.requestedBy.present
          ? data.requestedBy.value
          : this.requestedBy,
      department: data.department.present
          ? data.department.value
          : this.department,
      office: data.office.present ? data.office.value : this.office,
      role: data.role.present ? data.role.value : this.role,
      priority: data.priority.present ? data.priority.value : this.priority,
      businessGoal: data.businessGoal.present
          ? data.businessGoal.value
          : this.businessGoal,
      problemStatement: data.problemStatement.present
          ? data.problemStatement.value
          : this.problemStatement,
      expectedOutcome: data.expectedOutcome.present
          ? data.expectedOutcome.value
          : this.expectedOutcome,
      screenId: data.screenId.present ? data.screenId.value : this.screenId,
      routePath: data.routePath.present ? data.routePath.value : this.routePath,
      allowedRoles: data.allowedRoles.present
          ? data.allowedRoles.value
          : this.allowedRoles,
      requiredApis: data.requiredApis.present
          ? data.requiredApis.value
          : this.requiredApis,
      requiredComponents: data.requiredComponents.present
          ? data.requiredComponents.value
          : this.requiredComponents,
      requiredForms: data.requiredForms.present
          ? data.requiredForms.value
          : this.requiredForms,
      designSource: data.designSource.present
          ? data.designSource.value
          : this.designSource,
      designUrl: data.designUrl.present ? data.designUrl.value : this.designUrl,
      mockDataNotes: data.mockDataNotes.present
          ? data.mockDataNotes.value
          : this.mockDataNotes,
      needsPhiData: data.needsPhiData.present
          ? data.needsPhiData.value
          : this.needsPhiData,
      needsConsent: data.needsConsent.present
          ? data.needsConsent.value
          : this.needsConsent,
      needsSignature: data.needsSignature.present
          ? data.needsSignature.value
          : this.needsSignature,
      needsAuditLog: data.needsAuditLog.present
          ? data.needsAuditLog.value
          : this.needsAuditLog,
      acceptanceCriteria: data.acceptanceCriteria.present
          ? data.acceptanceCriteria.value
          : this.acceptanceCriteria,
      testScenarios: data.testScenarios.present
          ? data.testScenarios.value
          : this.testScenarios,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Proposal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('requestedBy: $requestedBy, ')
          ..write('department: $department, ')
          ..write('office: $office, ')
          ..write('role: $role, ')
          ..write('priority: $priority, ')
          ..write('businessGoal: $businessGoal, ')
          ..write('problemStatement: $problemStatement, ')
          ..write('expectedOutcome: $expectedOutcome, ')
          ..write('screenId: $screenId, ')
          ..write('routePath: $routePath, ')
          ..write('allowedRoles: $allowedRoles, ')
          ..write('requiredApis: $requiredApis, ')
          ..write('requiredComponents: $requiredComponents, ')
          ..write('requiredForms: $requiredForms, ')
          ..write('designSource: $designSource, ')
          ..write('designUrl: $designUrl, ')
          ..write('mockDataNotes: $mockDataNotes, ')
          ..write('needsPhiData: $needsPhiData, ')
          ..write('needsConsent: $needsConsent, ')
          ..write('needsSignature: $needsSignature, ')
          ..write('needsAuditLog: $needsAuditLog, ')
          ..write('acceptanceCriteria: $acceptanceCriteria, ')
          ..write('testScenarios: $testScenarios, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    title,
    description,
    requestedBy,
    department,
    office,
    role,
    priority,
    businessGoal,
    problemStatement,
    expectedOutcome,
    screenId,
    routePath,
    allowedRoles,
    requiredApis,
    requiredComponents,
    requiredForms,
    designSource,
    designUrl,
    mockDataNotes,
    needsPhiData,
    needsConsent,
    needsSignature,
    needsAuditLog,
    acceptanceCriteria,
    testScenarios,
    createdAt,
    status,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Proposal &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.requestedBy == this.requestedBy &&
          other.department == this.department &&
          other.office == this.office &&
          other.role == this.role &&
          other.priority == this.priority &&
          other.businessGoal == this.businessGoal &&
          other.problemStatement == this.problemStatement &&
          other.expectedOutcome == this.expectedOutcome &&
          other.screenId == this.screenId &&
          other.routePath == this.routePath &&
          other.allowedRoles == this.allowedRoles &&
          other.requiredApis == this.requiredApis &&
          other.requiredComponents == this.requiredComponents &&
          other.requiredForms == this.requiredForms &&
          other.designSource == this.designSource &&
          other.designUrl == this.designUrl &&
          other.mockDataNotes == this.mockDataNotes &&
          other.needsPhiData == this.needsPhiData &&
          other.needsConsent == this.needsConsent &&
          other.needsSignature == this.needsSignature &&
          other.needsAuditLog == this.needsAuditLog &&
          other.acceptanceCriteria == this.acceptanceCriteria &&
          other.testScenarios == this.testScenarios &&
          other.createdAt == this.createdAt &&
          other.status == this.status);
}

class ProposalsCompanion extends UpdateCompanion<Proposal> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> requestedBy;
  final Value<String> department;
  final Value<String> office;
  final Value<String> role;
  final Value<String> priority;
  final Value<String> businessGoal;
  final Value<String> problemStatement;
  final Value<String> expectedOutcome;
  final Value<String> screenId;
  final Value<String> routePath;
  final Value<String> allowedRoles;
  final Value<String> requiredApis;
  final Value<String> requiredComponents;
  final Value<String> requiredForms;
  final Value<String> designSource;
  final Value<String> designUrl;
  final Value<String> mockDataNotes;
  final Value<bool> needsPhiData;
  final Value<bool> needsConsent;
  final Value<bool> needsSignature;
  final Value<bool> needsAuditLog;
  final Value<String> acceptanceCriteria;
  final Value<String> testScenarios;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<int> rowid;
  const ProposalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.requestedBy = const Value.absent(),
    this.department = const Value.absent(),
    this.office = const Value.absent(),
    this.role = const Value.absent(),
    this.priority = const Value.absent(),
    this.businessGoal = const Value.absent(),
    this.problemStatement = const Value.absent(),
    this.expectedOutcome = const Value.absent(),
    this.screenId = const Value.absent(),
    this.routePath = const Value.absent(),
    this.allowedRoles = const Value.absent(),
    this.requiredApis = const Value.absent(),
    this.requiredComponents = const Value.absent(),
    this.requiredForms = const Value.absent(),
    this.designSource = const Value.absent(),
    this.designUrl = const Value.absent(),
    this.mockDataNotes = const Value.absent(),
    this.needsPhiData = const Value.absent(),
    this.needsConsent = const Value.absent(),
    this.needsSignature = const Value.absent(),
    this.needsAuditLog = const Value.absent(),
    this.acceptanceCriteria = const Value.absent(),
    this.testScenarios = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProposalsCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String requestedBy,
    required String department,
    required String office,
    required String role,
    required String priority,
    required String businessGoal,
    required String problemStatement,
    required String expectedOutcome,
    required String screenId,
    required String routePath,
    required String allowedRoles,
    required String requiredApis,
    required String requiredComponents,
    required String requiredForms,
    required String designSource,
    required String designUrl,
    required String mockDataNotes,
    required bool needsPhiData,
    required bool needsConsent,
    required bool needsSignature,
    required bool needsAuditLog,
    required String acceptanceCriteria,
    required String testScenarios,
    required DateTime createdAt,
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       requestedBy = Value(requestedBy),
       department = Value(department),
       office = Value(office),
       role = Value(role),
       priority = Value(priority),
       businessGoal = Value(businessGoal),
       problemStatement = Value(problemStatement),
       expectedOutcome = Value(expectedOutcome),
       screenId = Value(screenId),
       routePath = Value(routePath),
       allowedRoles = Value(allowedRoles),
       requiredApis = Value(requiredApis),
       requiredComponents = Value(requiredComponents),
       requiredForms = Value(requiredForms),
       designSource = Value(designSource),
       designUrl = Value(designUrl),
       mockDataNotes = Value(mockDataNotes),
       needsPhiData = Value(needsPhiData),
       needsConsent = Value(needsConsent),
       needsSignature = Value(needsSignature),
       needsAuditLog = Value(needsAuditLog),
       acceptanceCriteria = Value(acceptanceCriteria),
       testScenarios = Value(testScenarios),
       createdAt = Value(createdAt),
       status = Value(status);
  static Insertable<Proposal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? requestedBy,
    Expression<String>? department,
    Expression<String>? office,
    Expression<String>? role,
    Expression<String>? priority,
    Expression<String>? businessGoal,
    Expression<String>? problemStatement,
    Expression<String>? expectedOutcome,
    Expression<String>? screenId,
    Expression<String>? routePath,
    Expression<String>? allowedRoles,
    Expression<String>? requiredApis,
    Expression<String>? requiredComponents,
    Expression<String>? requiredForms,
    Expression<String>? designSource,
    Expression<String>? designUrl,
    Expression<String>? mockDataNotes,
    Expression<bool>? needsPhiData,
    Expression<bool>? needsConsent,
    Expression<bool>? needsSignature,
    Expression<bool>? needsAuditLog,
    Expression<String>? acceptanceCriteria,
    Expression<String>? testScenarios,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (requestedBy != null) 'requested_by': requestedBy,
      if (department != null) 'department': department,
      if (office != null) 'office': office,
      if (role != null) 'role': role,
      if (priority != null) 'priority': priority,
      if (businessGoal != null) 'business_goal': businessGoal,
      if (problemStatement != null) 'problem_statement': problemStatement,
      if (expectedOutcome != null) 'expected_outcome': expectedOutcome,
      if (screenId != null) 'screen_id': screenId,
      if (routePath != null) 'route_path': routePath,
      if (allowedRoles != null) 'allowed_roles': allowedRoles,
      if (requiredApis != null) 'required_apis': requiredApis,
      if (requiredComponents != null) 'required_components': requiredComponents,
      if (requiredForms != null) 'required_forms': requiredForms,
      if (designSource != null) 'design_source': designSource,
      if (designUrl != null) 'design_url': designUrl,
      if (mockDataNotes != null) 'mock_data_notes': mockDataNotes,
      if (needsPhiData != null) 'needs_phi_data': needsPhiData,
      if (needsConsent != null) 'needs_consent': needsConsent,
      if (needsSignature != null) 'needs_signature': needsSignature,
      if (needsAuditLog != null) 'needs_audit_log': needsAuditLog,
      if (acceptanceCriteria != null) 'acceptance_criteria': acceptanceCriteria,
      if (testScenarios != null) 'test_scenarios': testScenarios,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProposalsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? requestedBy,
    Value<String>? department,
    Value<String>? office,
    Value<String>? role,
    Value<String>? priority,
    Value<String>? businessGoal,
    Value<String>? problemStatement,
    Value<String>? expectedOutcome,
    Value<String>? screenId,
    Value<String>? routePath,
    Value<String>? allowedRoles,
    Value<String>? requiredApis,
    Value<String>? requiredComponents,
    Value<String>? requiredForms,
    Value<String>? designSource,
    Value<String>? designUrl,
    Value<String>? mockDataNotes,
    Value<bool>? needsPhiData,
    Value<bool>? needsConsent,
    Value<bool>? needsSignature,
    Value<bool>? needsAuditLog,
    Value<String>? acceptanceCriteria,
    Value<String>? testScenarios,
    Value<DateTime>? createdAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return ProposalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      requestedBy: requestedBy ?? this.requestedBy,
      department: department ?? this.department,
      office: office ?? this.office,
      role: role ?? this.role,
      priority: priority ?? this.priority,
      businessGoal: businessGoal ?? this.businessGoal,
      problemStatement: problemStatement ?? this.problemStatement,
      expectedOutcome: expectedOutcome ?? this.expectedOutcome,
      screenId: screenId ?? this.screenId,
      routePath: routePath ?? this.routePath,
      allowedRoles: allowedRoles ?? this.allowedRoles,
      requiredApis: requiredApis ?? this.requiredApis,
      requiredComponents: requiredComponents ?? this.requiredComponents,
      requiredForms: requiredForms ?? this.requiredForms,
      designSource: designSource ?? this.designSource,
      designUrl: designUrl ?? this.designUrl,
      mockDataNotes: mockDataNotes ?? this.mockDataNotes,
      needsPhiData: needsPhiData ?? this.needsPhiData,
      needsConsent: needsConsent ?? this.needsConsent,
      needsSignature: needsSignature ?? this.needsSignature,
      needsAuditLog: needsAuditLog ?? this.needsAuditLog,
      acceptanceCriteria: acceptanceCriteria ?? this.acceptanceCriteria,
      testScenarios: testScenarios ?? this.testScenarios,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (requestedBy.present) {
      map['requested_by'] = Variable<String>(requestedBy.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (office.present) {
      map['office'] = Variable<String>(office.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (businessGoal.present) {
      map['business_goal'] = Variable<String>(businessGoal.value);
    }
    if (problemStatement.present) {
      map['problem_statement'] = Variable<String>(problemStatement.value);
    }
    if (expectedOutcome.present) {
      map['expected_outcome'] = Variable<String>(expectedOutcome.value);
    }
    if (screenId.present) {
      map['screen_id'] = Variable<String>(screenId.value);
    }
    if (routePath.present) {
      map['route_path'] = Variable<String>(routePath.value);
    }
    if (allowedRoles.present) {
      map['allowed_roles'] = Variable<String>(allowedRoles.value);
    }
    if (requiredApis.present) {
      map['required_apis'] = Variable<String>(requiredApis.value);
    }
    if (requiredComponents.present) {
      map['required_components'] = Variable<String>(requiredComponents.value);
    }
    if (requiredForms.present) {
      map['required_forms'] = Variable<String>(requiredForms.value);
    }
    if (designSource.present) {
      map['design_source'] = Variable<String>(designSource.value);
    }
    if (designUrl.present) {
      map['design_url'] = Variable<String>(designUrl.value);
    }
    if (mockDataNotes.present) {
      map['mock_data_notes'] = Variable<String>(mockDataNotes.value);
    }
    if (needsPhiData.present) {
      map['needs_phi_data'] = Variable<bool>(needsPhiData.value);
    }
    if (needsConsent.present) {
      map['needs_consent'] = Variable<bool>(needsConsent.value);
    }
    if (needsSignature.present) {
      map['needs_signature'] = Variable<bool>(needsSignature.value);
    }
    if (needsAuditLog.present) {
      map['needs_audit_log'] = Variable<bool>(needsAuditLog.value);
    }
    if (acceptanceCriteria.present) {
      map['acceptance_criteria'] = Variable<String>(acceptanceCriteria.value);
    }
    if (testScenarios.present) {
      map['test_scenarios'] = Variable<String>(testScenarios.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProposalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('requestedBy: $requestedBy, ')
          ..write('department: $department, ')
          ..write('office: $office, ')
          ..write('role: $role, ')
          ..write('priority: $priority, ')
          ..write('businessGoal: $businessGoal, ')
          ..write('problemStatement: $problemStatement, ')
          ..write('expectedOutcome: $expectedOutcome, ')
          ..write('screenId: $screenId, ')
          ..write('routePath: $routePath, ')
          ..write('allowedRoles: $allowedRoles, ')
          ..write('requiredApis: $requiredApis, ')
          ..write('requiredComponents: $requiredComponents, ')
          ..write('requiredForms: $requiredForms, ')
          ..write('designSource: $designSource, ')
          ..write('designUrl: $designUrl, ')
          ..write('mockDataNotes: $mockDataNotes, ')
          ..write('needsPhiData: $needsPhiData, ')
          ..write('needsConsent: $needsConsent, ')
          ..write('needsSignature: $needsSignature, ')
          ..write('needsAuditLog: $needsAuditLog, ')
          ..write('acceptanceCriteria: $acceptanceCriteria, ')
          ..write('testScenarios: $testScenarios, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$GovernanceDatabase extends GeneratedDatabase {
  _$GovernanceDatabase(QueryExecutor e) : super(e);
  $GovernanceDatabaseManager get managers => $GovernanceDatabaseManager(this);
  late final $GovernanceSnapshotsTable governanceSnapshots =
      $GovernanceSnapshotsTable(this);
  late final $ProposalsTable proposals = $ProposalsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    governanceSnapshots,
    proposals,
  ];
}

typedef $$GovernanceSnapshotsTableCreateCompanionBuilder =
    GovernanceSnapshotsCompanion Function({
      Value<int> id,
      Value<DateTime> timestamp,
      required double healthScore,
      required int criticalIssues,
      required int highIssues,
      required int mediumIssues,
      required int lowIssues,
      required int totalScreens,
      required int productionReadyScreens,
    });
typedef $$GovernanceSnapshotsTableUpdateCompanionBuilder =
    GovernanceSnapshotsCompanion Function({
      Value<int> id,
      Value<DateTime> timestamp,
      Value<double> healthScore,
      Value<int> criticalIssues,
      Value<int> highIssues,
      Value<int> mediumIssues,
      Value<int> lowIssues,
      Value<int> totalScreens,
      Value<int> productionReadyScreens,
    });

class $$GovernanceSnapshotsTableFilterComposer
    extends Composer<_$GovernanceDatabase, $GovernanceSnapshotsTable> {
  $$GovernanceSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get healthScore => $composableBuilder(
    column: $table.healthScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get criticalIssues => $composableBuilder(
    column: $table.criticalIssues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get highIssues => $composableBuilder(
    column: $table.highIssues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mediumIssues => $composableBuilder(
    column: $table.mediumIssues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lowIssues => $composableBuilder(
    column: $table.lowIssues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalScreens => $composableBuilder(
    column: $table.totalScreens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productionReadyScreens => $composableBuilder(
    column: $table.productionReadyScreens,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GovernanceSnapshotsTableOrderingComposer
    extends Composer<_$GovernanceDatabase, $GovernanceSnapshotsTable> {
  $$GovernanceSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get healthScore => $composableBuilder(
    column: $table.healthScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get criticalIssues => $composableBuilder(
    column: $table.criticalIssues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get highIssues => $composableBuilder(
    column: $table.highIssues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mediumIssues => $composableBuilder(
    column: $table.mediumIssues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lowIssues => $composableBuilder(
    column: $table.lowIssues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalScreens => $composableBuilder(
    column: $table.totalScreens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productionReadyScreens => $composableBuilder(
    column: $table.productionReadyScreens,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GovernanceSnapshotsTableAnnotationComposer
    extends Composer<_$GovernanceDatabase, $GovernanceSnapshotsTable> {
  $$GovernanceSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get healthScore => $composableBuilder(
    column: $table.healthScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get criticalIssues => $composableBuilder(
    column: $table.criticalIssues,
    builder: (column) => column,
  );

  GeneratedColumn<int> get highIssues => $composableBuilder(
    column: $table.highIssues,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mediumIssues => $composableBuilder(
    column: $table.mediumIssues,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lowIssues =>
      $composableBuilder(column: $table.lowIssues, builder: (column) => column);

  GeneratedColumn<int> get totalScreens => $composableBuilder(
    column: $table.totalScreens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productionReadyScreens => $composableBuilder(
    column: $table.productionReadyScreens,
    builder: (column) => column,
  );
}

class $$GovernanceSnapshotsTableTableManager
    extends
        RootTableManager<
          _$GovernanceDatabase,
          $GovernanceSnapshotsTable,
          GovernanceSnapshot,
          $$GovernanceSnapshotsTableFilterComposer,
          $$GovernanceSnapshotsTableOrderingComposer,
          $$GovernanceSnapshotsTableAnnotationComposer,
          $$GovernanceSnapshotsTableCreateCompanionBuilder,
          $$GovernanceSnapshotsTableUpdateCompanionBuilder,
          (
            GovernanceSnapshot,
            BaseReferences<
              _$GovernanceDatabase,
              $GovernanceSnapshotsTable,
              GovernanceSnapshot
            >,
          ),
          GovernanceSnapshot,
          PrefetchHooks Function()
        > {
  $$GovernanceSnapshotsTableTableManager(
    _$GovernanceDatabase db,
    $GovernanceSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GovernanceSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GovernanceSnapshotsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GovernanceSnapshotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double> healthScore = const Value.absent(),
                Value<int> criticalIssues = const Value.absent(),
                Value<int> highIssues = const Value.absent(),
                Value<int> mediumIssues = const Value.absent(),
                Value<int> lowIssues = const Value.absent(),
                Value<int> totalScreens = const Value.absent(),
                Value<int> productionReadyScreens = const Value.absent(),
              }) => GovernanceSnapshotsCompanion(
                id: id,
                timestamp: timestamp,
                healthScore: healthScore,
                criticalIssues: criticalIssues,
                highIssues: highIssues,
                mediumIssues: mediumIssues,
                lowIssues: lowIssues,
                totalScreens: totalScreens,
                productionReadyScreens: productionReadyScreens,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                required double healthScore,
                required int criticalIssues,
                required int highIssues,
                required int mediumIssues,
                required int lowIssues,
                required int totalScreens,
                required int productionReadyScreens,
              }) => GovernanceSnapshotsCompanion.insert(
                id: id,
                timestamp: timestamp,
                healthScore: healthScore,
                criticalIssues: criticalIssues,
                highIssues: highIssues,
                mediumIssues: mediumIssues,
                lowIssues: lowIssues,
                totalScreens: totalScreens,
                productionReadyScreens: productionReadyScreens,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GovernanceSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$GovernanceDatabase,
      $GovernanceSnapshotsTable,
      GovernanceSnapshot,
      $$GovernanceSnapshotsTableFilterComposer,
      $$GovernanceSnapshotsTableOrderingComposer,
      $$GovernanceSnapshotsTableAnnotationComposer,
      $$GovernanceSnapshotsTableCreateCompanionBuilder,
      $$GovernanceSnapshotsTableUpdateCompanionBuilder,
      (
        GovernanceSnapshot,
        BaseReferences<
          _$GovernanceDatabase,
          $GovernanceSnapshotsTable,
          GovernanceSnapshot
        >,
      ),
      GovernanceSnapshot,
      PrefetchHooks Function()
    >;
typedef $$ProposalsTableCreateCompanionBuilder =
    ProposalsCompanion Function({
      required String id,
      required String title,
      required String description,
      required String requestedBy,
      required String department,
      required String office,
      required String role,
      required String priority,
      required String businessGoal,
      required String problemStatement,
      required String expectedOutcome,
      required String screenId,
      required String routePath,
      required String allowedRoles,
      required String requiredApis,
      required String requiredComponents,
      required String requiredForms,
      required String designSource,
      required String designUrl,
      required String mockDataNotes,
      required bool needsPhiData,
      required bool needsConsent,
      required bool needsSignature,
      required bool needsAuditLog,
      required String acceptanceCriteria,
      required String testScenarios,
      required DateTime createdAt,
      required String status,
      Value<int> rowid,
    });
typedef $$ProposalsTableUpdateCompanionBuilder =
    ProposalsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<String> requestedBy,
      Value<String> department,
      Value<String> office,
      Value<String> role,
      Value<String> priority,
      Value<String> businessGoal,
      Value<String> problemStatement,
      Value<String> expectedOutcome,
      Value<String> screenId,
      Value<String> routePath,
      Value<String> allowedRoles,
      Value<String> requiredApis,
      Value<String> requiredComponents,
      Value<String> requiredForms,
      Value<String> designSource,
      Value<String> designUrl,
      Value<String> mockDataNotes,
      Value<bool> needsPhiData,
      Value<bool> needsConsent,
      Value<bool> needsSignature,
      Value<bool> needsAuditLog,
      Value<String> acceptanceCriteria,
      Value<String> testScenarios,
      Value<DateTime> createdAt,
      Value<String> status,
      Value<int> rowid,
    });

class $$ProposalsTableFilterComposer
    extends Composer<_$GovernanceDatabase, $ProposalsTable> {
  $$ProposalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requestedBy => $composableBuilder(
    column: $table.requestedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get office => $composableBuilder(
    column: $table.office,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessGoal => $composableBuilder(
    column: $table.businessGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get problemStatement => $composableBuilder(
    column: $table.problemStatement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expectedOutcome => $composableBuilder(
    column: $table.expectedOutcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get screenId => $composableBuilder(
    column: $table.screenId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routePath => $composableBuilder(
    column: $table.routePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allowedRoles => $composableBuilder(
    column: $table.allowedRoles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requiredApis => $composableBuilder(
    column: $table.requiredApis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requiredComponents => $composableBuilder(
    column: $table.requiredComponents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requiredForms => $composableBuilder(
    column: $table.requiredForms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designSource => $composableBuilder(
    column: $table.designSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designUrl => $composableBuilder(
    column: $table.designUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mockDataNotes => $composableBuilder(
    column: $table.mockDataNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsPhiData => $composableBuilder(
    column: $table.needsPhiData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsConsent => $composableBuilder(
    column: $table.needsConsent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsSignature => $composableBuilder(
    column: $table.needsSignature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsAuditLog => $composableBuilder(
    column: $table.needsAuditLog,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get acceptanceCriteria => $composableBuilder(
    column: $table.acceptanceCriteria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testScenarios => $composableBuilder(
    column: $table.testScenarios,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProposalsTableOrderingComposer
    extends Composer<_$GovernanceDatabase, $ProposalsTable> {
  $$ProposalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requestedBy => $composableBuilder(
    column: $table.requestedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get office => $composableBuilder(
    column: $table.office,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessGoal => $composableBuilder(
    column: $table.businessGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get problemStatement => $composableBuilder(
    column: $table.problemStatement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expectedOutcome => $composableBuilder(
    column: $table.expectedOutcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get screenId => $composableBuilder(
    column: $table.screenId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routePath => $composableBuilder(
    column: $table.routePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allowedRoles => $composableBuilder(
    column: $table.allowedRoles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requiredApis => $composableBuilder(
    column: $table.requiredApis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requiredComponents => $composableBuilder(
    column: $table.requiredComponents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requiredForms => $composableBuilder(
    column: $table.requiredForms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designSource => $composableBuilder(
    column: $table.designSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designUrl => $composableBuilder(
    column: $table.designUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mockDataNotes => $composableBuilder(
    column: $table.mockDataNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsPhiData => $composableBuilder(
    column: $table.needsPhiData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsConsent => $composableBuilder(
    column: $table.needsConsent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsSignature => $composableBuilder(
    column: $table.needsSignature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsAuditLog => $composableBuilder(
    column: $table.needsAuditLog,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get acceptanceCriteria => $composableBuilder(
    column: $table.acceptanceCriteria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testScenarios => $composableBuilder(
    column: $table.testScenarios,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProposalsTableAnnotationComposer
    extends Composer<_$GovernanceDatabase, $ProposalsTable> {
  $$ProposalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requestedBy => $composableBuilder(
    column: $table.requestedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );

  GeneratedColumn<String> get office =>
      $composableBuilder(column: $table.office, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get businessGoal => $composableBuilder(
    column: $table.businessGoal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get problemStatement => $composableBuilder(
    column: $table.problemStatement,
    builder: (column) => column,
  );

  GeneratedColumn<String> get expectedOutcome => $composableBuilder(
    column: $table.expectedOutcome,
    builder: (column) => column,
  );

  GeneratedColumn<String> get screenId =>
      $composableBuilder(column: $table.screenId, builder: (column) => column);

  GeneratedColumn<String> get routePath =>
      $composableBuilder(column: $table.routePath, builder: (column) => column);

  GeneratedColumn<String> get allowedRoles => $composableBuilder(
    column: $table.allowedRoles,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requiredApis => $composableBuilder(
    column: $table.requiredApis,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requiredComponents => $composableBuilder(
    column: $table.requiredComponents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requiredForms => $composableBuilder(
    column: $table.requiredForms,
    builder: (column) => column,
  );

  GeneratedColumn<String> get designSource => $composableBuilder(
    column: $table.designSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get designUrl =>
      $composableBuilder(column: $table.designUrl, builder: (column) => column);

  GeneratedColumn<String> get mockDataNotes => $composableBuilder(
    column: $table.mockDataNotes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get needsPhiData => $composableBuilder(
    column: $table.needsPhiData,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get needsConsent => $composableBuilder(
    column: $table.needsConsent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get needsSignature => $composableBuilder(
    column: $table.needsSignature,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get needsAuditLog => $composableBuilder(
    column: $table.needsAuditLog,
    builder: (column) => column,
  );

  GeneratedColumn<String> get acceptanceCriteria => $composableBuilder(
    column: $table.acceptanceCriteria,
    builder: (column) => column,
  );

  GeneratedColumn<String> get testScenarios => $composableBuilder(
    column: $table.testScenarios,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$ProposalsTableTableManager
    extends
        RootTableManager<
          _$GovernanceDatabase,
          $ProposalsTable,
          Proposal,
          $$ProposalsTableFilterComposer,
          $$ProposalsTableOrderingComposer,
          $$ProposalsTableAnnotationComposer,
          $$ProposalsTableCreateCompanionBuilder,
          $$ProposalsTableUpdateCompanionBuilder,
          (
            Proposal,
            BaseReferences<_$GovernanceDatabase, $ProposalsTable, Proposal>,
          ),
          Proposal,
          PrefetchHooks Function()
        > {
  $$ProposalsTableTableManager(_$GovernanceDatabase db, $ProposalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProposalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProposalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProposalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> requestedBy = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<String> office = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> businessGoal = const Value.absent(),
                Value<String> problemStatement = const Value.absent(),
                Value<String> expectedOutcome = const Value.absent(),
                Value<String> screenId = const Value.absent(),
                Value<String> routePath = const Value.absent(),
                Value<String> allowedRoles = const Value.absent(),
                Value<String> requiredApis = const Value.absent(),
                Value<String> requiredComponents = const Value.absent(),
                Value<String> requiredForms = const Value.absent(),
                Value<String> designSource = const Value.absent(),
                Value<String> designUrl = const Value.absent(),
                Value<String> mockDataNotes = const Value.absent(),
                Value<bool> needsPhiData = const Value.absent(),
                Value<bool> needsConsent = const Value.absent(),
                Value<bool> needsSignature = const Value.absent(),
                Value<bool> needsAuditLog = const Value.absent(),
                Value<String> acceptanceCriteria = const Value.absent(),
                Value<String> testScenarios = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProposalsCompanion(
                id: id,
                title: title,
                description: description,
                requestedBy: requestedBy,
                department: department,
                office: office,
                role: role,
                priority: priority,
                businessGoal: businessGoal,
                problemStatement: problemStatement,
                expectedOutcome: expectedOutcome,
                screenId: screenId,
                routePath: routePath,
                allowedRoles: allowedRoles,
                requiredApis: requiredApis,
                requiredComponents: requiredComponents,
                requiredForms: requiredForms,
                designSource: designSource,
                designUrl: designUrl,
                mockDataNotes: mockDataNotes,
                needsPhiData: needsPhiData,
                needsConsent: needsConsent,
                needsSignature: needsSignature,
                needsAuditLog: needsAuditLog,
                acceptanceCriteria: acceptanceCriteria,
                testScenarios: testScenarios,
                createdAt: createdAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required String requestedBy,
                required String department,
                required String office,
                required String role,
                required String priority,
                required String businessGoal,
                required String problemStatement,
                required String expectedOutcome,
                required String screenId,
                required String routePath,
                required String allowedRoles,
                required String requiredApis,
                required String requiredComponents,
                required String requiredForms,
                required String designSource,
                required String designUrl,
                required String mockDataNotes,
                required bool needsPhiData,
                required bool needsConsent,
                required bool needsSignature,
                required bool needsAuditLog,
                required String acceptanceCriteria,
                required String testScenarios,
                required DateTime createdAt,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => ProposalsCompanion.insert(
                id: id,
                title: title,
                description: description,
                requestedBy: requestedBy,
                department: department,
                office: office,
                role: role,
                priority: priority,
                businessGoal: businessGoal,
                problemStatement: problemStatement,
                expectedOutcome: expectedOutcome,
                screenId: screenId,
                routePath: routePath,
                allowedRoles: allowedRoles,
                requiredApis: requiredApis,
                requiredComponents: requiredComponents,
                requiredForms: requiredForms,
                designSource: designSource,
                designUrl: designUrl,
                mockDataNotes: mockDataNotes,
                needsPhiData: needsPhiData,
                needsConsent: needsConsent,
                needsSignature: needsSignature,
                needsAuditLog: needsAuditLog,
                acceptanceCriteria: acceptanceCriteria,
                testScenarios: testScenarios,
                createdAt: createdAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProposalsTableProcessedTableManager =
    ProcessedTableManager<
      _$GovernanceDatabase,
      $ProposalsTable,
      Proposal,
      $$ProposalsTableFilterComposer,
      $$ProposalsTableOrderingComposer,
      $$ProposalsTableAnnotationComposer,
      $$ProposalsTableCreateCompanionBuilder,
      $$ProposalsTableUpdateCompanionBuilder,
      (
        Proposal,
        BaseReferences<_$GovernanceDatabase, $ProposalsTable, Proposal>,
      ),
      Proposal,
      PrefetchHooks Function()
    >;

class $GovernanceDatabaseManager {
  final _$GovernanceDatabase _db;
  $GovernanceDatabaseManager(this._db);
  $$GovernanceSnapshotsTableTableManager get governanceSnapshots =>
      $$GovernanceSnapshotsTableTableManager(_db, _db.governanceSnapshots);
  $$ProposalsTableTableManager get proposals =>
      $$ProposalsTableTableManager(_db, _db.proposals);
}
