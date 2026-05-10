// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinical_article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClinicalArticle {

 String get url; String get title; String get category; String get content;@JsonKey(name: 'html_content') String get htmlContent;
/// Create a copy of ClinicalArticle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicalArticleCopyWith<ClinicalArticle> get copyWith => _$ClinicalArticleCopyWithImpl<ClinicalArticle>(this as ClinicalArticle, _$identity);

  /// Serializes this ClinicalArticle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicalArticle&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.content, content) || other.content == content)&&(identical(other.htmlContent, htmlContent) || other.htmlContent == htmlContent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,title,category,content,htmlContent);

@override
String toString() {
  return 'ClinicalArticle(url: $url, title: $title, category: $category, content: $content, htmlContent: $htmlContent)';
}


}

/// @nodoc
abstract mixin class $ClinicalArticleCopyWith<$Res>  {
  factory $ClinicalArticleCopyWith(ClinicalArticle value, $Res Function(ClinicalArticle) _then) = _$ClinicalArticleCopyWithImpl;
@useResult
$Res call({
 String url, String title, String category, String content,@JsonKey(name: 'html_content') String htmlContent
});




}
/// @nodoc
class _$ClinicalArticleCopyWithImpl<$Res>
    implements $ClinicalArticleCopyWith<$Res> {
  _$ClinicalArticleCopyWithImpl(this._self, this._then);

  final ClinicalArticle _self;
  final $Res Function(ClinicalArticle) _then;

/// Create a copy of ClinicalArticle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? title = null,Object? category = null,Object? content = null,Object? htmlContent = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,htmlContent: null == htmlContent ? _self.htmlContent : htmlContent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClinicalArticle].
extension ClinicalArticlePatterns on ClinicalArticle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicalArticle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicalArticle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicalArticle value)  $default,){
final _that = this;
switch (_that) {
case _ClinicalArticle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicalArticle value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicalArticle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String title,  String category,  String content, @JsonKey(name: 'html_content')  String htmlContent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicalArticle() when $default != null:
return $default(_that.url,_that.title,_that.category,_that.content,_that.htmlContent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String title,  String category,  String content, @JsonKey(name: 'html_content')  String htmlContent)  $default,) {final _that = this;
switch (_that) {
case _ClinicalArticle():
return $default(_that.url,_that.title,_that.category,_that.content,_that.htmlContent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String title,  String category,  String content, @JsonKey(name: 'html_content')  String htmlContent)?  $default,) {final _that = this;
switch (_that) {
case _ClinicalArticle() when $default != null:
return $default(_that.url,_that.title,_that.category,_that.content,_that.htmlContent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicalArticle extends ClinicalArticle {
  const _ClinicalArticle({required this.url, required this.title, required this.category, required this.content, @JsonKey(name: 'html_content') required this.htmlContent}): super._();
  factory _ClinicalArticle.fromJson(Map<String, dynamic> json) => _$ClinicalArticleFromJson(json);

@override final  String url;
@override final  String title;
@override final  String category;
@override final  String content;
@override@JsonKey(name: 'html_content') final  String htmlContent;

/// Create a copy of ClinicalArticle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicalArticleCopyWith<_ClinicalArticle> get copyWith => __$ClinicalArticleCopyWithImpl<_ClinicalArticle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicalArticleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicalArticle&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.content, content) || other.content == content)&&(identical(other.htmlContent, htmlContent) || other.htmlContent == htmlContent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,title,category,content,htmlContent);

@override
String toString() {
  return 'ClinicalArticle(url: $url, title: $title, category: $category, content: $content, htmlContent: $htmlContent)';
}


}

/// @nodoc
abstract mixin class _$ClinicalArticleCopyWith<$Res> implements $ClinicalArticleCopyWith<$Res> {
  factory _$ClinicalArticleCopyWith(_ClinicalArticle value, $Res Function(_ClinicalArticle) _then) = __$ClinicalArticleCopyWithImpl;
@override @useResult
$Res call({
 String url, String title, String category, String content,@JsonKey(name: 'html_content') String htmlContent
});




}
/// @nodoc
class __$ClinicalArticleCopyWithImpl<$Res>
    implements _$ClinicalArticleCopyWith<$Res> {
  __$ClinicalArticleCopyWithImpl(this._self, this._then);

  final _ClinicalArticle _self;
  final $Res Function(_ClinicalArticle) _then;

/// Create a copy of ClinicalArticle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? title = null,Object? category = null,Object? content = null,Object? htmlContent = null,}) {
  return _then(_ClinicalArticle(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,htmlContent: null == htmlContent ? _self.htmlContent : htmlContent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
