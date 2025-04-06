import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:punkantaan/model/song_model.dart';

part 'contents_riverpod.freezed.dart';
@Freezed(makeCollectionsUnmodifiable:false)
abstract class ContentsRiverpod with _$ContentsRiverpod{
  const factory ContentsRiverpod({
    List<SongModel>? songcontents,
    int? songIndex,
    required double titleFontSize,
    required double bodyFontSize,
    required Color highlightColor,
    Map<String,dynamic>? highlighted,
    required List<int> favorites ,
    required List<int> recent
  })=_ContentsRiverpod;
}