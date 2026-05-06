// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'psw_dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PswDashboardState {

 AsyncValue<PswDashboardData> get dashboardData; AsyncValue<AuthState> get authState; bool get isSyncing;
/// Create a copy of PswDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PswDashboardStateCopyWith<PswDashboardState> get copyWith => _$PswDashboardStateCopyWithImpl<PswDashboardState>(this as PswDashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PswDashboardState&&(identical(other.dashboardData, dashboardData) || other.dashboardData == dashboardData)&&(identical(other.authState, authState) || other.authState == authState)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing));
}


@override
int get hashCode => Object.hash(runtimeType,dashboardData,authState,isSyncing);

@override
String toString() {
  return 'PswDashboardState(dashboardData: $dashboardData, authState: $authState, isSyncing: $isSyncing)';
}


}

/// @nodoc
abstract mixin class $PswDashboardStateCopyWith<$Res>  {
  factory $PswDashboardStateCopyWith(PswDashboardState value, $Res Function(PswDashboardState) _then) = _$PswDashboardStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<PswDashboardData> dashboardData, AsyncValue<AuthState> authState, bool isSyncing
});




}
/// @nodoc
class _$PswDashboardStateCopyWithImpl<$Res>
    implements $PswDashboardStateCopyWith<$Res> {
  _$PswDashboardStateCopyWithImpl(this._self, this._then);

  final PswDashboardState _self;
  final $Res Function(PswDashboardState) _then;

/// Create a copy of PswDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dashboardData = null,Object? authState = null,Object? isSyncing = null,}) {
  return _then(_self.copyWith(
dashboardData: null == dashboardData ? _self.dashboardData : dashboardData // ignore: cast_nullable_to_non_nullable
as AsyncValue<PswDashboardData>,authState: null == authState ? _self.authState : authState // ignore: cast_nullable_to_non_nullable
as AsyncValue<AuthState>,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PswDashboardState].
extension PswDashboardStatePatterns on PswDashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PswDashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PswDashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PswDashboardState value)  $default,){
final _that = this;
switch (_that) {
case _PswDashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PswDashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _PswDashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncValue<PswDashboardData> dashboardData,  AsyncValue<AuthState> authState,  bool isSyncing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PswDashboardState() when $default != null:
return $default(_that.dashboardData,_that.authState,_that.isSyncing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncValue<PswDashboardData> dashboardData,  AsyncValue<AuthState> authState,  bool isSyncing)  $default,) {final _that = this;
switch (_that) {
case _PswDashboardState():
return $default(_that.dashboardData,_that.authState,_that.isSyncing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncValue<PswDashboardData> dashboardData,  AsyncValue<AuthState> authState,  bool isSyncing)?  $default,) {final _that = this;
switch (_that) {
case _PswDashboardState() when $default != null:
return $default(_that.dashboardData,_that.authState,_that.isSyncing);case _:
  return null;

}
}

}

/// @nodoc


class _PswDashboardState implements PswDashboardState {
  const _PswDashboardState({this.dashboardData = const AsyncValue<PswDashboardData>.loading(), this.authState = const AsyncValue<AuthState>.loading(), this.isSyncing = false});
  

@override@JsonKey() final  AsyncValue<PswDashboardData> dashboardData;
@override@JsonKey() final  AsyncValue<AuthState> authState;
@override@JsonKey() final  bool isSyncing;

/// Create a copy of PswDashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PswDashboardStateCopyWith<_PswDashboardState> get copyWith => __$PswDashboardStateCopyWithImpl<_PswDashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PswDashboardState&&(identical(other.dashboardData, dashboardData) || other.dashboardData == dashboardData)&&(identical(other.authState, authState) || other.authState == authState)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing));
}


@override
int get hashCode => Object.hash(runtimeType,dashboardData,authState,isSyncing);

@override
String toString() {
  return 'PswDashboardState(dashboardData: $dashboardData, authState: $authState, isSyncing: $isSyncing)';
}


}

/// @nodoc
abstract mixin class _$PswDashboardStateCopyWith<$Res> implements $PswDashboardStateCopyWith<$Res> {
  factory _$PswDashboardStateCopyWith(_PswDashboardState value, $Res Function(_PswDashboardState) _then) = __$PswDashboardStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<PswDashboardData> dashboardData, AsyncValue<AuthState> authState, bool isSyncing
});




}
/// @nodoc
class __$PswDashboardStateCopyWithImpl<$Res>
    implements _$PswDashboardStateCopyWith<$Res> {
  __$PswDashboardStateCopyWithImpl(this._self, this._then);

  final _PswDashboardState _self;
  final $Res Function(_PswDashboardState) _then;

/// Create a copy of PswDashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dashboardData = null,Object? authState = null,Object? isSyncing = null,}) {
  return _then(_PswDashboardState(
dashboardData: null == dashboardData ? _self.dashboardData : dashboardData // ignore: cast_nullable_to_non_nullable
as AsyncValue<PswDashboardData>,authState: null == authState ? _self.authState : authState // ignore: cast_nullable_to_non_nullable
as AsyncValue<AuthState>,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
