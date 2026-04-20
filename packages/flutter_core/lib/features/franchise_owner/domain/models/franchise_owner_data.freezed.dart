// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'franchise_owner_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FranchiseOwnerData {

 Map<String, dynamic> get metrics;
/// Create a copy of FranchiseOwnerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FranchiseOwnerDataCopyWith<FranchiseOwnerData> get copyWith => _$FranchiseOwnerDataCopyWithImpl<FranchiseOwnerData>(this as FranchiseOwnerData, _$identity);

  /// Serializes this FranchiseOwnerData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FranchiseOwnerData&&const DeepCollectionEquality().equals(other.metrics, metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(metrics));

@override
String toString() {
  return 'FranchiseOwnerData(metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class $FranchiseOwnerDataCopyWith<$Res>  {
  factory $FranchiseOwnerDataCopyWith(FranchiseOwnerData value, $Res Function(FranchiseOwnerData) _then) = _$FranchiseOwnerDataCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> metrics
});




}
/// @nodoc
class _$FranchiseOwnerDataCopyWithImpl<$Res>
    implements $FranchiseOwnerDataCopyWith<$Res> {
  _$FranchiseOwnerDataCopyWithImpl(this._self, this._then);

  final FranchiseOwnerData _self;
  final $Res Function(FranchiseOwnerData) _then;

/// Create a copy of FranchiseOwnerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metrics = null,}) {
  return _then(_self.copyWith(
metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [FranchiseOwnerData].
extension FranchiseOwnerDataPatterns on FranchiseOwnerData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FranchiseOwnerData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FranchiseOwnerData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FranchiseOwnerData value)  $default,){
final _that = this;
switch (_that) {
case _FranchiseOwnerData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FranchiseOwnerData value)?  $default,){
final _that = this;
switch (_that) {
case _FranchiseOwnerData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> metrics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FranchiseOwnerData() when $default != null:
return $default(_that.metrics);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> metrics)  $default,) {final _that = this;
switch (_that) {
case _FranchiseOwnerData():
return $default(_that.metrics);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> metrics)?  $default,) {final _that = this;
switch (_that) {
case _FranchiseOwnerData() when $default != null:
return $default(_that.metrics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FranchiseOwnerData extends FranchiseOwnerData {
  const _FranchiseOwnerData({required final  Map<String, dynamic> metrics}): _metrics = metrics,super._();
  factory _FranchiseOwnerData.fromJson(Map<String, dynamic> json) => _$FranchiseOwnerDataFromJson(json);

 final  Map<String, dynamic> _metrics;
@override Map<String, dynamic> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}


/// Create a copy of FranchiseOwnerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FranchiseOwnerDataCopyWith<_FranchiseOwnerData> get copyWith => __$FranchiseOwnerDataCopyWithImpl<_FranchiseOwnerData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FranchiseOwnerDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FranchiseOwnerData&&const DeepCollectionEquality().equals(other._metrics, _metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_metrics));

@override
String toString() {
  return 'FranchiseOwnerData(metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class _$FranchiseOwnerDataCopyWith<$Res> implements $FranchiseOwnerDataCopyWith<$Res> {
  factory _$FranchiseOwnerDataCopyWith(_FranchiseOwnerData value, $Res Function(_FranchiseOwnerData) _then) = __$FranchiseOwnerDataCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> metrics
});




}
/// @nodoc
class __$FranchiseOwnerDataCopyWithImpl<$Res>
    implements _$FranchiseOwnerDataCopyWith<$Res> {
  __$FranchiseOwnerDataCopyWithImpl(this._self, this._then);

  final _FranchiseOwnerData _self;
  final $Res Function(_FranchiseOwnerData) _then;

/// Create a copy of FranchiseOwnerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metrics = null,}) {
  return _then(_FranchiseOwnerData(
metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
