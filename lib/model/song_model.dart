import 'package:freezed_annotation/freezed_annotation.dart';
part 'song_model.freezed.dart';
@Freezed(makeCollectionsUnmodifiable:false)
abstract class SongModel with _$SongModel{
  const factory SongModel({
    required String title,
    required String old,
    required String tune,
    required String key,
    required String beat,
    required List<String> chorus,
    required List<List<String>>stanza
  })=_SongModel;
  factory SongModel.fromJson(dynamic json){
    var chorusList = List<String>.from(json['chorus']); 
    var stanzaList = (json['stanza'] as List).map((i) => List<String>.from(i)).toList();
    return SongModel(
      title:json['title'], old:json['old'],tune:json['tune'], 
      key:json['key'],beat: json['beat'],chorus: chorusList,stanza:stanzaList
    );
  }
}
