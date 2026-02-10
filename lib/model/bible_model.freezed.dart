// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BibleModel {
  String? get book => throw _privateConstructorUsedError;
  String? get chapter => throw _privateConstructorUsedError;
  int? get remainingTime => throw _privateConstructorUsedError;
  int? get sleepTime => throw _privateConstructorUsedError;
  List<String>? get books => throw _privateConstructorUsedError;
  int? get currentBookIndex => throw _privateConstructorUsedError;
  List<String>? get chapters => throw _privateConstructorUsedError;
  int? get currentChapterIndex => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  Map<String, dynamic>? get bibleContent => throw _privateConstructorUsedError;
  Map<String, int>? get bibleSummary => throw _privateConstructorUsedError;
  AudioPlayer? get player => throw _privateConstructorUsedError;

  /// Create a copy of BibleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BibleModelCopyWith<BibleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BibleModelCopyWith<$Res> {
  factory $BibleModelCopyWith(
          BibleModel value, $Res Function(BibleModel) then) =
      _$BibleModelCopyWithImpl<$Res, BibleModel>;
  @useResult
  $Res call(
      {String? book,
      String? chapter,
      int? remainingTime,
      int? sleepTime,
      List<String>? books,
      int? currentBookIndex,
      List<String>? chapters,
      int? currentChapterIndex,
      bool isPlaying,
      Map<String, dynamic>? bibleContent,
      Map<String, int>? bibleSummary,
      AudioPlayer? player});
}

/// @nodoc
class _$BibleModelCopyWithImpl<$Res, $Val extends BibleModel>
    implements $BibleModelCopyWith<$Res> {
  _$BibleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BibleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? book = freezed,
    Object? chapter = freezed,
    Object? remainingTime = freezed,
    Object? sleepTime = freezed,
    Object? books = freezed,
    Object? currentBookIndex = freezed,
    Object? chapters = freezed,
    Object? currentChapterIndex = freezed,
    Object? isPlaying = null,
    Object? bibleContent = freezed,
    Object? bibleSummary = freezed,
    Object? player = freezed,
  }) {
    return _then(_value.copyWith(
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as String?,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
      remainingTime: freezed == remainingTime
          ? _value.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as int?,
      sleepTime: freezed == sleepTime
          ? _value.sleepTime
          : sleepTime // ignore: cast_nullable_to_non_nullable
              as int?,
      books: freezed == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentBookIndex: freezed == currentBookIndex
          ? _value.currentBookIndex
          : currentBookIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      chapters: freezed == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentChapterIndex: freezed == currentChapterIndex
          ? _value.currentChapterIndex
          : currentChapterIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      bibleContent: freezed == bibleContent
          ? _value.bibleContent
          : bibleContent // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      bibleSummary: freezed == bibleSummary
          ? _value.bibleSummary
          : bibleSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      player: freezed == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as AudioPlayer?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BibleModelImplCopyWith<$Res>
    implements $BibleModelCopyWith<$Res> {
  factory _$$BibleModelImplCopyWith(
          _$BibleModelImpl value, $Res Function(_$BibleModelImpl) then) =
      __$$BibleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? book,
      String? chapter,
      int? remainingTime,
      int? sleepTime,
      List<String>? books,
      int? currentBookIndex,
      List<String>? chapters,
      int? currentChapterIndex,
      bool isPlaying,
      Map<String, dynamic>? bibleContent,
      Map<String, int>? bibleSummary,
      AudioPlayer? player});
}

/// @nodoc
class __$$BibleModelImplCopyWithImpl<$Res>
    extends _$BibleModelCopyWithImpl<$Res, _$BibleModelImpl>
    implements _$$BibleModelImplCopyWith<$Res> {
  __$$BibleModelImplCopyWithImpl(
      _$BibleModelImpl _value, $Res Function(_$BibleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BibleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? book = freezed,
    Object? chapter = freezed,
    Object? remainingTime = freezed,
    Object? sleepTime = freezed,
    Object? books = freezed,
    Object? currentBookIndex = freezed,
    Object? chapters = freezed,
    Object? currentChapterIndex = freezed,
    Object? isPlaying = null,
    Object? bibleContent = freezed,
    Object? bibleSummary = freezed,
    Object? player = freezed,
  }) {
    return _then(_$BibleModelImpl(
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as String?,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
      remainingTime: freezed == remainingTime
          ? _value.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as int?,
      sleepTime: freezed == sleepTime
          ? _value.sleepTime
          : sleepTime // ignore: cast_nullable_to_non_nullable
              as int?,
      books: freezed == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentBookIndex: freezed == currentBookIndex
          ? _value.currentBookIndex
          : currentBookIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      chapters: freezed == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentChapterIndex: freezed == currentChapterIndex
          ? _value.currentChapterIndex
          : currentChapterIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      bibleContent: freezed == bibleContent
          ? _value.bibleContent
          : bibleContent // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      bibleSummary: freezed == bibleSummary
          ? _value.bibleSummary
          : bibleSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      player: freezed == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as AudioPlayer?,
    ));
  }
}

/// @nodoc

class _$BibleModelImpl implements _BibleModel {
  const _$BibleModelImpl(
      {this.book,
      this.chapter,
      this.remainingTime,
      this.sleepTime,
      this.books,
      this.currentBookIndex,
      this.chapters,
      this.currentChapterIndex,
      this.isPlaying = false,
      this.bibleContent,
      this.bibleSummary,
      this.player});

  @override
  final String? book;
  @override
  final String? chapter;
  @override
  final int? remainingTime;
  @override
  final int? sleepTime;
  @override
  final List<String>? books;
  @override
  final int? currentBookIndex;
  @override
  final List<String>? chapters;
  @override
  final int? currentChapterIndex;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  final Map<String, dynamic>? bibleContent;
  @override
  final Map<String, int>? bibleSummary;
  @override
  final AudioPlayer? player;

  @override
  String toString() {
    return 'BibleModel(book: $book, chapter: $chapter, remainingTime: $remainingTime, sleepTime: $sleepTime, books: $books, currentBookIndex: $currentBookIndex, chapters: $chapters, currentChapterIndex: $currentChapterIndex, isPlaying: $isPlaying, bibleContent: $bibleContent, bibleSummary: $bibleSummary, player: $player)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BibleModelImpl &&
            (identical(other.book, book) || other.book == book) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.remainingTime, remainingTime) ||
                other.remainingTime == remainingTime) &&
            (identical(other.sleepTime, sleepTime) ||
                other.sleepTime == sleepTime) &&
            const DeepCollectionEquality().equals(other.books, books) &&
            (identical(other.currentBookIndex, currentBookIndex) ||
                other.currentBookIndex == currentBookIndex) &&
            const DeepCollectionEquality().equals(other.chapters, chapters) &&
            (identical(other.currentChapterIndex, currentChapterIndex) ||
                other.currentChapterIndex == currentChapterIndex) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            const DeepCollectionEquality()
                .equals(other.bibleContent, bibleContent) &&
            const DeepCollectionEquality()
                .equals(other.bibleSummary, bibleSummary) &&
            (identical(other.player, player) || other.player == player));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      book,
      chapter,
      remainingTime,
      sleepTime,
      const DeepCollectionEquality().hash(books),
      currentBookIndex,
      const DeepCollectionEquality().hash(chapters),
      currentChapterIndex,
      isPlaying,
      const DeepCollectionEquality().hash(bibleContent),
      const DeepCollectionEquality().hash(bibleSummary),
      player);

  /// Create a copy of BibleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BibleModelImplCopyWith<_$BibleModelImpl> get copyWith =>
      __$$BibleModelImplCopyWithImpl<_$BibleModelImpl>(this, _$identity);
}

abstract class _BibleModel implements BibleModel {
  const factory _BibleModel(
      {final String? book,
      final String? chapter,
      final int? remainingTime,
      final int? sleepTime,
      final List<String>? books,
      final int? currentBookIndex,
      final List<String>? chapters,
      final int? currentChapterIndex,
      final bool isPlaying,
      final Map<String, dynamic>? bibleContent,
      final Map<String, int>? bibleSummary,
      final AudioPlayer? player}) = _$BibleModelImpl;

  @override
  String? get book;
  @override
  String? get chapter;
  @override
  int? get remainingTime;
  @override
  int? get sleepTime;
  @override
  List<String>? get books;
  @override
  int? get currentBookIndex;
  @override
  List<String>? get chapters;
  @override
  int? get currentChapterIndex;
  @override
  bool get isPlaying;
  @override
  Map<String, dynamic>? get bibleContent;
  @override
  Map<String, int>? get bibleSummary;
  @override
  AudioPlayer? get player;

  /// Create a copy of BibleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BibleModelImplCopyWith<_$BibleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
