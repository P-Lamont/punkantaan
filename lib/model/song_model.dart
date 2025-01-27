
class SongModel {
  String title;
  String old;
  String tune;
  String key;
  String beat;
  List<String> chorus;
  List<List<String>>stanza;
  SongModel(this.title,this.old,this.tune,this.key,this.beat,this.chorus,this.stanza);

  factory SongModel.fromJson(dynamic json){
    var chorusList = List<String>.from(json['chorus']); 
    var stanzaList = (json['stanza'] as List).map((i) => List<String>.from(i)).toList();
    return SongModel(
      json['title'], json['old'], json['tune'], 
      json['key'], json['beat'], chorusList,stanzaList
    );
  }
}
