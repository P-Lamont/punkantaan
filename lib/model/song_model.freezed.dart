// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'song_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SongModel {
  String get title => throw _privateConstructorUsedError;
  String get old => throw _privateConstructorUsedError;
  String get tune => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get beat => throw _privateConstructorUsedError;
  List<String> get chorus => throw _privateConstructorUsedError;
  List<List<String>> get stanza => throw _privateConstructorUsedError;

  /// Create a copy of SongModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SongModelCopyWith<SongModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongModelCopyWith<$Res> {
  factory $SongModelCopyWith(SongModel value, $Res Function(SongModel) then) =
      _$SongModelCopyWithImpl<$Res, SongModel>;
  @useResult
  $Res call(
      {String title,
      String old,
      String tune,
      String key,
      String beat,
      List<String> chorus,
      List<List<String>> stanza});
}

/// @nodoc
class _$SongModelCopyWithImpl<$Res, $Val extends SongModel>
    implements $SongModelCopyWith<$Res> {
  _$SongModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SongModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? old = null,
    Object? tune = null,
    Object? key = null,
    Object? beat = null,
    Object? chorus = null,
    Object? stanza = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      old: null == old
          ? _value.old
          : old // ignore: cast_nullable_to_non_nullable
              as String,
      tune: null == tune
          ? _value.tune
          : tune // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      beat: null == beat
          ? _value.beat
          : beat // ignore: cast_nullable_to_non_nullable
              as String,
      chorus: null == chorus
          ? _value.chorus
          : chorus // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stanza: null == stanza
          ? _value.stanza
          : stanza // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SongModelImplCopyWith<$Res>
    implements $SongModelCopyWith<$Res> {
  factory _$$SongModelImplCopyWith(
          _$SongModelImpl value, $Res Function(_$SongModelImpl) then) =
      __$$SongModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String old,
      String tune,
      String key,
      String beat,
      List<String> chorus,
      List<List<String>> stanza});
}

/// @nodoc
class __$$SongModelImplCopyWithImpl<$Res>
    extends _$SongModelCopyWithImpl<$Res, _$SongModelImpl>
    implements _$$SongModelImplCopyWith<$Res> {
  __$$SongModelImplCopyWithImpl(
      _$SongModelImpl _value, $Res Function(_$SongModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SongModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? old = null,
    Object? tune = null,
    Object? key = null,
    Object? beat = null,
    Object? chorus = null,
    Object? stanza = null,
  }) {
    return _then(_$SongModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      old: null == old
          ? _value.old
          : old // ignore: cast_nullable_to_non_nullable
              as String,
      tune: null == tune
          ? _value.tune
          : tune // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      beat: null == beat
          ? _value.beat
          : beat // ignore: cast_nullable_to_non_nullable
              as String,
      chorus: null == chorus
          ? _value.chorus
          : chorus // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stanza: null == stanza
          ? _value.stanza
          : stanza // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
    ));
  }
}

/// @nodoc

class _$SongModelImpl implements _SongModel {
  const _$SongModelImpl(
      {required this.title,
      required this.old,
      required this.tune,
      required this.key,
      required this.beat,
      required this.chorus,
      required this.stanza});

  @override
  final String title;
  @override
  final String old;
  @override
  final String tune;
  @override
  final String key;
  @override
  final String beat;
  @override
  final List<String> chorus;
  @override
  final List<List<String>> stanza;

  @override
  String toString() {
    return 'SongModel(title: $title, old: $old, tune: $tune, key: $key, beat: $beat, chorus: $chorus, stanza: $stanza)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.old, old) || other.old == old) &&
            (identical(other.tune, tune) || other.tune == tune) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.beat, beat) || other.beat == beat) &&
            const DeepCollectionEquality().equals(other.chorus, chorus) &&
            const DeepCollectionEquality().equals(other.stanza, stanza));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      old,
      tune,
      key,
      beat,
      const DeepCollectionEquality().hash(chorus),
      const DeepCollectionEquality().hash(stanza));

  /// Create a copy of SongModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SongModelImplCopyWith<_$SongModelImpl> get copyWith =>
      __$$SongModelImplCopyWithImpl<_$SongModelImpl>(this, _$identity);
}

abstract class _SongModel implements SongModel {
  const factory _SongModel(
      {required final String title,
      required final String old,
      required final String tune,
      required final String key,
      required final String beat,
      required final List<String> chorus,
      required final List<List<String>> stanza}) = _$SongModelImpl;

  @override
  String get title;
  @override
  String get old;
  @override
  String get tune;
  @override
  String get key;
  @override
  String get beat;
  @override
  List<String> get chorus;
  @override
  List<List<String>> get stanza;

  /// Create a copy of SongModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SongModelImplCopyWith<_$SongModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
