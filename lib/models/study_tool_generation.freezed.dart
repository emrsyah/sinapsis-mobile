// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_tool_generation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlashCard {

 String get question; String get answer;
/// Create a copy of FlashCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashCardCopyWith<FlashCard> get copyWith => _$FlashCardCopyWithImpl<FlashCard>(this as FlashCard, _$identity);

  /// Serializes this FlashCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashCard&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,answer);

@override
String toString() {
  return 'FlashCard(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $FlashCardCopyWith<$Res>  {
  factory $FlashCardCopyWith(FlashCard value, $Res Function(FlashCard) _then) = _$FlashCardCopyWithImpl;
@useResult
$Res call({
 String question, String answer
});




}
/// @nodoc
class _$FlashCardCopyWithImpl<$Res>
    implements $FlashCardCopyWith<$Res> {
  _$FlashCardCopyWithImpl(this._self, this._then);

  final FlashCard _self;
  final $Res Function(FlashCard) _then;

/// Create a copy of FlashCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? answer = null,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashCard].
extension FlashCardPatterns on FlashCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashCard value)  $default,){
final _that = this;
switch (_that) {
case _FlashCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashCard value)?  $default,){
final _that = this;
switch (_that) {
case _FlashCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  String answer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashCard() when $default != null:
return $default(_that.question,_that.answer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  String answer)  $default,) {final _that = this;
switch (_that) {
case _FlashCard():
return $default(_that.question,_that.answer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  String answer)?  $default,) {final _that = this;
switch (_that) {
case _FlashCard() when $default != null:
return $default(_that.question,_that.answer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlashCard implements FlashCard {
  const _FlashCard({required this.question, required this.answer});
  factory _FlashCard.fromJson(Map<String, dynamic> json) => _$FlashCardFromJson(json);

@override final  String question;
@override final  String answer;

/// Create a copy of FlashCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashCardCopyWith<_FlashCard> get copyWith => __$FlashCardCopyWithImpl<_FlashCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashCard&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,answer);

@override
String toString() {
  return 'FlashCard(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$FlashCardCopyWith<$Res> implements $FlashCardCopyWith<$Res> {
  factory _$FlashCardCopyWith(_FlashCard value, $Res Function(_FlashCard) _then) = __$FlashCardCopyWithImpl;
@override @useResult
$Res call({
 String question, String answer
});




}
/// @nodoc
class __$FlashCardCopyWithImpl<$Res>
    implements _$FlashCardCopyWith<$Res> {
  __$FlashCardCopyWithImpl(this._self, this._then);

  final _FlashCard _self;
  final $Res Function(_FlashCard) _then;

/// Create a copy of FlashCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? answer = null,}) {
  return _then(_FlashCard(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FlashcardContent {

 List<FlashCard> get cards;
/// Create a copy of FlashcardContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardContentCopyWith<FlashcardContent> get copyWith => _$FlashcardContentCopyWithImpl<FlashcardContent>(this as FlashcardContent, _$identity);

  /// Serializes this FlashcardContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashcardContent&&const DeepCollectionEquality().equals(other.cards, cards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cards));

@override
String toString() {
  return 'FlashcardContent(cards: $cards)';
}


}

/// @nodoc
abstract mixin class $FlashcardContentCopyWith<$Res>  {
  factory $FlashcardContentCopyWith(FlashcardContent value, $Res Function(FlashcardContent) _then) = _$FlashcardContentCopyWithImpl;
@useResult
$Res call({
 List<FlashCard> cards
});




}
/// @nodoc
class _$FlashcardContentCopyWithImpl<$Res>
    implements $FlashcardContentCopyWith<$Res> {
  _$FlashcardContentCopyWithImpl(this._self, this._then);

  final FlashcardContent _self;
  final $Res Function(FlashcardContent) _then;

/// Create a copy of FlashcardContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cards = null,}) {
  return _then(_self.copyWith(
cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<FlashCard>,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashcardContent].
extension FlashcardContentPatterns on FlashcardContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashcardContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashcardContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashcardContent value)  $default,){
final _that = this;
switch (_that) {
case _FlashcardContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashcardContent value)?  $default,){
final _that = this;
switch (_that) {
case _FlashcardContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FlashCard> cards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashcardContent() when $default != null:
return $default(_that.cards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FlashCard> cards)  $default,) {final _that = this;
switch (_that) {
case _FlashcardContent():
return $default(_that.cards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FlashCard> cards)?  $default,) {final _that = this;
switch (_that) {
case _FlashcardContent() when $default != null:
return $default(_that.cards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlashcardContent implements FlashcardContent {
  const _FlashcardContent({required final  List<FlashCard> cards}): _cards = cards;
  factory _FlashcardContent.fromJson(Map<String, dynamic> json) => _$FlashcardContentFromJson(json);

 final  List<FlashCard> _cards;
@override List<FlashCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of FlashcardContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashcardContentCopyWith<_FlashcardContent> get copyWith => __$FlashcardContentCopyWithImpl<_FlashcardContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashcardContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashcardContent&&const DeepCollectionEquality().equals(other._cards, _cards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards));

@override
String toString() {
  return 'FlashcardContent(cards: $cards)';
}


}

/// @nodoc
abstract mixin class _$FlashcardContentCopyWith<$Res> implements $FlashcardContentCopyWith<$Res> {
  factory _$FlashcardContentCopyWith(_FlashcardContent value, $Res Function(_FlashcardContent) _then) = __$FlashcardContentCopyWithImpl;
@override @useResult
$Res call({
 List<FlashCard> cards
});




}
/// @nodoc
class __$FlashcardContentCopyWithImpl<$Res>
    implements _$FlashcardContentCopyWith<$Res> {
  __$FlashcardContentCopyWithImpl(this._self, this._then);

  final _FlashcardContent _self;
  final $Res Function(_FlashcardContent) _then;

/// Create a copy of FlashcardContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cards = null,}) {
  return _then(_FlashcardContent(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<FlashCard>,
  ));
}


}


/// @nodoc
mixin _$QuizQuestion {

 String get question; List<String> get options;@JsonKey(name: 'correct_index') int get correctIndex; String get explanation;
/// Create a copy of QuizQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizQuestionCopyWith<QuizQuestion> get copyWith => _$QuizQuestionCopyWithImpl<QuizQuestion>(this as QuizQuestion, _$identity);

  /// Serializes this QuizQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizQuestion&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.explanation, explanation) || other.explanation == explanation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(options),correctIndex,explanation);

@override
String toString() {
  return 'QuizQuestion(question: $question, options: $options, correctIndex: $correctIndex, explanation: $explanation)';
}


}

/// @nodoc
abstract mixin class $QuizQuestionCopyWith<$Res>  {
  factory $QuizQuestionCopyWith(QuizQuestion value, $Res Function(QuizQuestion) _then) = _$QuizQuestionCopyWithImpl;
@useResult
$Res call({
 String question, List<String> options,@JsonKey(name: 'correct_index') int correctIndex, String explanation
});




}
/// @nodoc
class _$QuizQuestionCopyWithImpl<$Res>
    implements $QuizQuestionCopyWith<$Res> {
  _$QuizQuestionCopyWithImpl(this._self, this._then);

  final QuizQuestion _self;
  final $Res Function(QuizQuestion) _then;

/// Create a copy of QuizQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? options = null,Object? correctIndex = null,Object? explanation = null,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizQuestion].
extension QuizQuestionPatterns on QuizQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizQuestion value)  $default,){
final _that = this;
switch (_that) {
case _QuizQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _QuizQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  List<String> options, @JsonKey(name: 'correct_index')  int correctIndex,  String explanation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizQuestion() when $default != null:
return $default(_that.question,_that.options,_that.correctIndex,_that.explanation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  List<String> options, @JsonKey(name: 'correct_index')  int correctIndex,  String explanation)  $default,) {final _that = this;
switch (_that) {
case _QuizQuestion():
return $default(_that.question,_that.options,_that.correctIndex,_that.explanation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  List<String> options, @JsonKey(name: 'correct_index')  int correctIndex,  String explanation)?  $default,) {final _that = this;
switch (_that) {
case _QuizQuestion() when $default != null:
return $default(_that.question,_that.options,_that.correctIndex,_that.explanation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizQuestion implements QuizQuestion {
  const _QuizQuestion({required this.question, required final  List<String> options, @JsonKey(name: 'correct_index') required this.correctIndex, required this.explanation}): _options = options;
  factory _QuizQuestion.fromJson(Map<String, dynamic> json) => _$QuizQuestionFromJson(json);

@override final  String question;
 final  List<String> _options;
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override@JsonKey(name: 'correct_index') final  int correctIndex;
@override final  String explanation;

/// Create a copy of QuizQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizQuestionCopyWith<_QuizQuestion> get copyWith => __$QuizQuestionCopyWithImpl<_QuizQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizQuestion&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.correctIndex, correctIndex) || other.correctIndex == correctIndex)&&(identical(other.explanation, explanation) || other.explanation == explanation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(_options),correctIndex,explanation);

@override
String toString() {
  return 'QuizQuestion(question: $question, options: $options, correctIndex: $correctIndex, explanation: $explanation)';
}


}

/// @nodoc
abstract mixin class _$QuizQuestionCopyWith<$Res> implements $QuizQuestionCopyWith<$Res> {
  factory _$QuizQuestionCopyWith(_QuizQuestion value, $Res Function(_QuizQuestion) _then) = __$QuizQuestionCopyWithImpl;
@override @useResult
$Res call({
 String question, List<String> options,@JsonKey(name: 'correct_index') int correctIndex, String explanation
});




}
/// @nodoc
class __$QuizQuestionCopyWithImpl<$Res>
    implements _$QuizQuestionCopyWith<$Res> {
  __$QuizQuestionCopyWithImpl(this._self, this._then);

  final _QuizQuestion _self;
  final $Res Function(_QuizQuestion) _then;

/// Create a copy of QuizQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? options = null,Object? correctIndex = null,Object? explanation = null,}) {
  return _then(_QuizQuestion(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,correctIndex: null == correctIndex ? _self.correctIndex : correctIndex // ignore: cast_nullable_to_non_nullable
as int,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$QuizContent {

 List<QuizQuestion> get questions;
/// Create a copy of QuizContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizContentCopyWith<QuizContent> get copyWith => _$QuizContentCopyWithImpl<QuizContent>(this as QuizContent, _$identity);

  /// Serializes this QuizContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizContent&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'QuizContent(questions: $questions)';
}


}

/// @nodoc
abstract mixin class $QuizContentCopyWith<$Res>  {
  factory $QuizContentCopyWith(QuizContent value, $Res Function(QuizContent) _then) = _$QuizContentCopyWithImpl;
@useResult
$Res call({
 List<QuizQuestion> questions
});




}
/// @nodoc
class _$QuizContentCopyWithImpl<$Res>
    implements $QuizContentCopyWith<$Res> {
  _$QuizContentCopyWithImpl(this._self, this._then);

  final QuizContent _self;
  final $Res Function(QuizContent) _then;

/// Create a copy of QuizContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questions = null,}) {
  return _then(_self.copyWith(
questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuizQuestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizContent].
extension QuizContentPatterns on QuizContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizContent value)  $default,){
final _that = this;
switch (_that) {
case _QuizContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizContent value)?  $default,){
final _that = this;
switch (_that) {
case _QuizContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<QuizQuestion> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizContent() when $default != null:
return $default(_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<QuizQuestion> questions)  $default,) {final _that = this;
switch (_that) {
case _QuizContent():
return $default(_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<QuizQuestion> questions)?  $default,) {final _that = this;
switch (_that) {
case _QuizContent() when $default != null:
return $default(_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizContent implements QuizContent {
  const _QuizContent({required final  List<QuizQuestion> questions}): _questions = questions;
  factory _QuizContent.fromJson(Map<String, dynamic> json) => _$QuizContentFromJson(json);

 final  List<QuizQuestion> _questions;
@override List<QuizQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of QuizContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizContentCopyWith<_QuizContent> get copyWith => __$QuizContentCopyWithImpl<_QuizContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizContent&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'QuizContent(questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$QuizContentCopyWith<$Res> implements $QuizContentCopyWith<$Res> {
  factory _$QuizContentCopyWith(_QuizContent value, $Res Function(_QuizContent) _then) = __$QuizContentCopyWithImpl;
@override @useResult
$Res call({
 List<QuizQuestion> questions
});




}
/// @nodoc
class __$QuizContentCopyWithImpl<$Res>
    implements _$QuizContentCopyWith<$Res> {
  __$QuizContentCopyWithImpl(this._self, this._then);

  final _QuizContent _self;
  final $Res Function(_QuizContent) _then;

/// Create a copy of QuizContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questions = null,}) {
  return _then(_QuizContent(
questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuizQuestion>,
  ));
}


}


/// @nodoc
mixin _$MindMapNode {

 String get label; List<MindMapNode> get children;
/// Create a copy of MindMapNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MindMapNodeCopyWith<MindMapNode> get copyWith => _$MindMapNodeCopyWithImpl<MindMapNode>(this as MindMapNode, _$identity);

  /// Serializes this MindMapNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MindMapNode&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'MindMapNode(label: $label, children: $children)';
}


}

/// @nodoc
abstract mixin class $MindMapNodeCopyWith<$Res>  {
  factory $MindMapNodeCopyWith(MindMapNode value, $Res Function(MindMapNode) _then) = _$MindMapNodeCopyWithImpl;
@useResult
$Res call({
 String label, List<MindMapNode> children
});




}
/// @nodoc
class _$MindMapNodeCopyWithImpl<$Res>
    implements $MindMapNodeCopyWith<$Res> {
  _$MindMapNodeCopyWithImpl(this._self, this._then);

  final MindMapNode _self;
  final $Res Function(MindMapNode) _then;

/// Create a copy of MindMapNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? children = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<MindMapNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [MindMapNode].
extension MindMapNodePatterns on MindMapNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MindMapNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MindMapNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MindMapNode value)  $default,){
final _that = this;
switch (_that) {
case _MindMapNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MindMapNode value)?  $default,){
final _that = this;
switch (_that) {
case _MindMapNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  List<MindMapNode> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MindMapNode() when $default != null:
return $default(_that.label,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  List<MindMapNode> children)  $default,) {final _that = this;
switch (_that) {
case _MindMapNode():
return $default(_that.label,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  List<MindMapNode> children)?  $default,) {final _that = this;
switch (_that) {
case _MindMapNode() when $default != null:
return $default(_that.label,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MindMapNode implements MindMapNode {
  const _MindMapNode({required this.label, final  List<MindMapNode> children = const []}): _children = children;
  factory _MindMapNode.fromJson(Map<String, dynamic> json) => _$MindMapNodeFromJson(json);

@override final  String label;
 final  List<MindMapNode> _children;
@override@JsonKey() List<MindMapNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of MindMapNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MindMapNodeCopyWith<_MindMapNode> get copyWith => __$MindMapNodeCopyWithImpl<_MindMapNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MindMapNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MindMapNode&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'MindMapNode(label: $label, children: $children)';
}


}

/// @nodoc
abstract mixin class _$MindMapNodeCopyWith<$Res> implements $MindMapNodeCopyWith<$Res> {
  factory _$MindMapNodeCopyWith(_MindMapNode value, $Res Function(_MindMapNode) _then) = __$MindMapNodeCopyWithImpl;
@override @useResult
$Res call({
 String label, List<MindMapNode> children
});




}
/// @nodoc
class __$MindMapNodeCopyWithImpl<$Res>
    implements _$MindMapNodeCopyWith<$Res> {
  __$MindMapNodeCopyWithImpl(this._self, this._then);

  final _MindMapNode _self;
  final $Res Function(_MindMapNode) _then;

/// Create a copy of MindMapNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? children = null,}) {
  return _then(_MindMapNode(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<MindMapNode>,
  ));
}


}


/// @nodoc
mixin _$MindmapContent {

 String get root; List<MindMapNode> get children;@JsonKey(name: 'image_url') String? get imageUrl;
/// Create a copy of MindmapContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MindmapContentCopyWith<MindmapContent> get copyWith => _$MindmapContentCopyWithImpl<MindmapContent>(this as MindmapContent, _$identity);

  /// Serializes this MindmapContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MindmapContent&&(identical(other.root, root) || other.root == root)&&const DeepCollectionEquality().equals(other.children, children)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,root,const DeepCollectionEquality().hash(children),imageUrl);

@override
String toString() {
  return 'MindmapContent(root: $root, children: $children, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $MindmapContentCopyWith<$Res>  {
  factory $MindmapContentCopyWith(MindmapContent value, $Res Function(MindmapContent) _then) = _$MindmapContentCopyWithImpl;
@useResult
$Res call({
 String root, List<MindMapNode> children,@JsonKey(name: 'image_url') String? imageUrl
});




}
/// @nodoc
class _$MindmapContentCopyWithImpl<$Res>
    implements $MindmapContentCopyWith<$Res> {
  _$MindmapContentCopyWithImpl(this._self, this._then);

  final MindmapContent _self;
  final $Res Function(MindmapContent) _then;

/// Create a copy of MindmapContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? root = null,Object? children = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<MindMapNode>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MindmapContent].
extension MindmapContentPatterns on MindmapContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MindmapContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MindmapContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MindmapContent value)  $default,){
final _that = this;
switch (_that) {
case _MindmapContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MindmapContent value)?  $default,){
final _that = this;
switch (_that) {
case _MindmapContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String root,  List<MindMapNode> children, @JsonKey(name: 'image_url')  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MindmapContent() when $default != null:
return $default(_that.root,_that.children,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String root,  List<MindMapNode> children, @JsonKey(name: 'image_url')  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _MindmapContent():
return $default(_that.root,_that.children,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String root,  List<MindMapNode> children, @JsonKey(name: 'image_url')  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _MindmapContent() when $default != null:
return $default(_that.root,_that.children,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MindmapContent implements MindmapContent {
  const _MindmapContent({required this.root, final  List<MindMapNode> children = const [], @JsonKey(name: 'image_url') this.imageUrl}): _children = children;
  factory _MindmapContent.fromJson(Map<String, dynamic> json) => _$MindmapContentFromJson(json);

@override final  String root;
 final  List<MindMapNode> _children;
@override@JsonKey() List<MindMapNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}

@override@JsonKey(name: 'image_url') final  String? imageUrl;

/// Create a copy of MindmapContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MindmapContentCopyWith<_MindmapContent> get copyWith => __$MindmapContentCopyWithImpl<_MindmapContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MindmapContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MindmapContent&&(identical(other.root, root) || other.root == root)&&const DeepCollectionEquality().equals(other._children, _children)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,root,const DeepCollectionEquality().hash(_children),imageUrl);

@override
String toString() {
  return 'MindmapContent(root: $root, children: $children, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$MindmapContentCopyWith<$Res> implements $MindmapContentCopyWith<$Res> {
  factory _$MindmapContentCopyWith(_MindmapContent value, $Res Function(_MindmapContent) _then) = __$MindmapContentCopyWithImpl;
@override @useResult
$Res call({
 String root, List<MindMapNode> children,@JsonKey(name: 'image_url') String? imageUrl
});




}
/// @nodoc
class __$MindmapContentCopyWithImpl<$Res>
    implements _$MindmapContentCopyWith<$Res> {
  __$MindmapContentCopyWithImpl(this._self, this._then);

  final _MindmapContent _self;
  final $Res Function(_MindmapContent) _then;

/// Create a copy of MindmapContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? root = null,Object? children = null,Object? imageUrl = freezed,}) {
  return _then(_MindmapContent(
root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<MindMapNode>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
