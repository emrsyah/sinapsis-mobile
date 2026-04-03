// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Folder {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'parent_id') String? get parentId; String get name;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt; List<Folder> get children;
/// Create a copy of Folder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderCopyWith<Folder> get copyWith => _$FolderCopyWithImpl<Folder>(this as Folder, _$identity);

  /// Serializes this Folder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Folder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,parentId,name,createdAt,updatedAt,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'Folder(id: $id, userId: $userId, parentId: $parentId, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, children: $children)';
}


}

/// @nodoc
abstract mixin class $FolderCopyWith<$Res>  {
  factory $FolderCopyWith(Folder value, $Res Function(Folder) _then) = _$FolderCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'parent_id') String? parentId, String name,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, List<Folder> children
});




}
/// @nodoc
class _$FolderCopyWithImpl<$Res>
    implements $FolderCopyWith<$Res> {
  _$FolderCopyWithImpl(this._self, this._then);

  final Folder _self;
  final $Res Function(Folder) _then;

/// Create a copy of Folder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? parentId = freezed,Object? name = null,Object? createdAt = null,Object? updatedAt = null,Object? children = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<Folder>,
  ));
}

}


/// Adds pattern-matching-related methods to [Folder].
extension FolderPatterns on Folder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Folder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Folder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Folder value)  $default,){
final _that = this;
switch (_that) {
case _Folder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Folder value)?  $default,){
final _that = this;
switch (_that) {
case _Folder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'parent_id')  String? parentId,  String name, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<Folder> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Folder() when $default != null:
return $default(_that.id,_that.userId,_that.parentId,_that.name,_that.createdAt,_that.updatedAt,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'parent_id')  String? parentId,  String name, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<Folder> children)  $default,) {final _that = this;
switch (_that) {
case _Folder():
return $default(_that.id,_that.userId,_that.parentId,_that.name,_that.createdAt,_that.updatedAt,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'parent_id')  String? parentId,  String name, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<Folder> children)?  $default,) {final _that = this;
switch (_that) {
case _Folder() when $default != null:
return $default(_that.id,_that.userId,_that.parentId,_that.name,_that.createdAt,_that.updatedAt,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Folder implements Folder {
  const _Folder({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'parent_id') this.parentId, required this.name, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, final  List<Folder> children = const []}): _children = children;
  factory _Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'parent_id') final  String? parentId;
@override final  String name;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;
 final  List<Folder> _children;
@override@JsonKey() List<Folder> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of Folder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderCopyWith<_Folder> get copyWith => __$FolderCopyWithImpl<_Folder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FolderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Folder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,parentId,name,createdAt,updatedAt,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'Folder(id: $id, userId: $userId, parentId: $parentId, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, children: $children)';
}


}

/// @nodoc
abstract mixin class _$FolderCopyWith<$Res> implements $FolderCopyWith<$Res> {
  factory _$FolderCopyWith(_Folder value, $Res Function(_Folder) _then) = __$FolderCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'parent_id') String? parentId, String name,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, List<Folder> children
});




}
/// @nodoc
class __$FolderCopyWithImpl<$Res>
    implements _$FolderCopyWith<$Res> {
  __$FolderCopyWithImpl(this._self, this._then);

  final _Folder _self;
  final $Res Function(_Folder) _then;

/// Create a copy of Folder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? parentId = freezed,Object? name = null,Object? createdAt = null,Object? updatedAt = null,Object? children = null,}) {
  return _then(_Folder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<Folder>,
  ));
}


}

// dart format on
