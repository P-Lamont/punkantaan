import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
part 'bible_model.freezed.dart';
@Freezed(makeCollectionsUnmodifiable:false)
abstract class BibleModel with _$BibleModel{
  const factory BibleModel({
    String? book,
    String? chapter,
    int? remainingTime,
    int? sleepTime,
    List<String>? books,
    int? currentBookIndex,
    List<String>? chapters,
    int? currentChapterIndex,
    @Default(false)bool isPlaying,
    Map<String,dynamic>? bibleContent,
    Map<String,int>? bibleSummary,
    AudioPlayer? player
  })=_BibleModel;
  
}
