import 'package:punkantaan/model/song_model.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzywuzzy/ratios/partial_ratio.dart';

List<Map<String,dynamic>> searchFromSongs(String query,List<SongModel> songcontents){
  List<Map<String,dynamic>> resultlist =[];
  RegExp regExp = RegExp(r'[^a-zA-Z]/s');
  for (int i=0;i<songcontents.length;i++){
    SongModel content = songcontents[i];
      // List<Map<String,dynamic>> results=[];

    String title = content.title.replaceAll(regExp,'');
    int titleratio = partialRatio(query.toUpperCase(), title);
    if (titleratio>90){
      resultlist.add(
        {
          'string':content.title,
          'Score':titleratio,
          'line':1,
          'preference':1,
          'stanza':1,
          'index':i,
          'type':'title'
        }
      );
      // results['Title']=true;
    }
    if (content.chorus.isNotEmpty){
      List<String> chorusList =content.chorus.map((e)=>e.replaceAll(regExp,'')).toList();
      final chorusLines =extractAllSorted(
        query: query, 
        choices: chorusList,
        ratio: PartialRatio(),
        cutoff: 90
        );
      // content.chorus.asMap().entries.map((choline)=>{
      //   if (regString.hasMatch(choline.value)){
      //     chorusLines.add(choline.key)
      //   }
      // }).toList();
      List<Map<String,dynamic>>chorusLines2 =chorusLines.map((e) =>
        {
          'string':e.choice.toString(),'Score':e.score,
          'line':e.index+1,'preference':2,'stanza':1,'index':i,
          'type':'chorus'
        },).toList();
      if (chorusLines2.isNotEmpty){
        resultlist.addAll(chorusLines2);
      }
    }
    if (content.stanza.isNotEmpty){
      List<Map<String,dynamic>> stanzaLines =[];
      // List<String> stanzaCombined =content.stanza.map((e) =>e.join(' '),).toList(); 
      content.stanza.asMap().entries.map((stanzaline){
        // if (regString.hasMatch(stanzaline.value)){
        //   stanzaLines.add(stanzaline.key+1)
        // }
        List<String>stanzaAlpha = stanzaline.value.map((e)=>e.replaceAll(regExp,'')).toList();
        final stanzaResults = extractAllSorted(
          query: query, 
          choices: stanzaAlpha,
          ratio: PartialRatio(),
          cutoff: 90
        );
        if(stanzaResults.isNotEmpty){
          List<Map<String,dynamic>>stanzaResults2=stanzaResults.map((e) =>
            {
              'string':e.choice.toString(),'Score':e.score,
              'line':e.index+1,'stanza':stanzaline.key+1,'preference':3,
              'index':i,'type':'stanza'
            }
          ).toList();
          stanzaLines.addAll(stanzaResults2);
        }
      }).toList();
      if (stanzaLines.isNotEmpty){
        resultlist.addAll(stanzaLines);
      }
    }
  }
  return resultlist;
}
List<Map<String,dynamic>> sortSongResults(List<Map<String,dynamic>> data){
  data.sort((a, b) { 
    int scoreComparison = a['Score'].compareTo(b['Score']); 
    if (scoreComparison != 0) { 
      return scoreComparison;
    }
    int preferenceComparison = a['preference'].compareTo(b['preference']); 
    if(preferenceComparison!=0){
      return preferenceComparison; 
    }
    int stanzaComparison = a['stanza'].compareTo(b['stanza']); 
    if (stanzaComparison!=0){
      return stanzaComparison;
    }
    return a['line'].compareTo(b['line']);
  });
  return data;
}