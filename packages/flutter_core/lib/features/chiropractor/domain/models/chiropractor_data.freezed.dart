// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of '02_M_chiropractor_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChiropractorData {

 Map<String, dynamic> get metrics;
/// Create a copy of ChiropractorData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChiropractorDataCopyWith<ChiropractorData> get copyWith => _$ChiropractorDataCopyWithImpl<ChiropractorData>(this as ChiropractorData, _$identity);

  /// Serializes this ChiropractorData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChiropractorData&&const DeepCollectionEquality().equals(other.metrics, metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(metrics));

@override
String toString() {
  return 'ChiropractorData(metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class $ChiropractorDataCopyWith<$Res>  {
  factory $ChiropractorDataCopyWith(ChiropractorData value, $Res Function(ChiropractorData) _then) = _$ChiropractorDataCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> metrics
});




}
/// @nodoc
class _$ChiropractorDataCopyWithImpl<$Res>
    implements $ChiropractorDataCopyWith<$Res> {
  _$ChiropractorDataCopyWithImpl(this._self, this._then);

  final ChiropractorData _self;
  final $Res Function(ChiropractorData) _then;

/// Create a copy of ChiropractorData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metrics = null,}) {
  return _then(_self.copyWith(
metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChiropractorData].
extension ChiropractorDataPatterns on ChiropractorData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChiropractorData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChiropractorData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChiropractorData value)  $default,){
final _that = this;
switch (_that) {
case _ChiropractorData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChiropractorData value)?  $default,){
final _that = this;
switch (_that) {
case _ChiropractorData() when $default != null:
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
case _ChiropractorData() when $default != null:
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
case _ChiropractorData():
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
case _ChiropractorData() when $default != null:
return $default(_that.metrics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChiropractorData extends ChiropractorData {
  const _ChiropractorData({required final  Map<String, dynamic> metrics}): _metrics = metrics,super._();
  factory _ChiropractorData.fromJson(Map<String, dynamic> json) => _$ChiropractorDataFromJson(json);

 final  Map<String, dynamic> _metrics;
@override Map<String, dynamic> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}


/// Create a copy of ChiropractorData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChiropractorDataCopyWith<_ChiropractorData> get copyWith => __$ChiropractorDataCopyWithImpl<_ChiropractorData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChiropractorDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChiropractorData&&const DeepCollectionEquality().equals(other._metrics, _metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_metrics));

@override
String toString() {
  return 'ChiropractorData(metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class _$ChiropractorDataCopyWith<$Res> implements $ChiropractorDataCopyWith<$Res> {
  factory _$ChiropractorDataCopyWith(_ChiropractorData value, $Res Function(_ChiropractorData) _then) = __$ChiropractorDataCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> metrics
});




}
/// @nodoc
class __$ChiropractorDataCopyWithImpl<$Res>
    implements _$ChiropractorDataCopyWith<$Res> {
  __$ChiropractorDataCopyWithImpl(this._self, this._then);

  final _ChiropractorData _self;
  final $Res Function(_ChiropractorData) _then;

/// Create a copy of ChiropractorData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metrics = null,}) {
  return _then(_ChiropractorData(
metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
