import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:punkantaan/main.dart';
// import 'package:punkantaan/riverpod_model.dart';
import 'package:punkantaan/model/song_model.dart';
import 'package:fuzzywuzzy/ratios/partial_ratio.dart';
// final riverpodProvider = ChangeNotifierProvider<RiverpodModel>((ref){
//   return RiverpodModel();
// }); 

class SearchResultView extends ConsumerWidget {
  const SearchResultView({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(riverpodProvider);
    List<Map<String,dynamic>> resultlist =[];
    // var regString = RegExp(query, caseSensitive: false);
    RegExp regExp = RegExp(r'[^a-zA-Z]/s');
    for (int i=0;i<appState.songcontents!.length;i++){
      SongModel content = appState.songcontents![i];
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
    if (resultlist.isNotEmpty){
      resultlist.sort((a, b) { 
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
    }
    return Scrollbar(
      thickness: 15,
      radius: const Radius.circular(20),
      interactive: true,
      child: ListView.builder( 
        itemCount: resultlist.length, itemBuilder: (context, index) { 
          Map<String,dynamic>data = resultlist[index];
          return Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: ListTile( 
              title: Text(data['string']),
              subtitle: Text('On:${data['type']} Stanza: ${data['stanza']}'),
              onTap: () { 
                ref.watch(riverpodProvider).setHighlighted(data);
                ref.watch(riverpodProvider)
                  .setSongIndex(data['index']);
                Navigator.pop(context);
              }, 
            ),
          ); 
        }, 
      ),
    );
  }
}

class  MySearchDelegant extends SearchDelegate{
  // const MySearchDelegant({super.keys,required this.contents});
  // final List<SongModel> contents;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(
    onPressed: (){    
      Navigator.pop(context);
    }, 
    icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultView(query:query);
    }
    
    @override
    Widget buildSuggestions(BuildContext context) {
  // TODO: implement buildSuggestions
      return Container();
    }
  }

