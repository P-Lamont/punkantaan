import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/controller/search_functions.dart';
import 'package:punkantaan/model/model_riverpod.dart';
// import 'package:punkantaan/riverpod_model.dart';
// final riverpodProvider = ChangeNotifierProvider<RiverpodModel>((ref){
//   return RiverpodModel();
// }); 

class SearchResultView extends ConsumerWidget {
  const SearchResultView({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appStateN = ref.watch(modelRiverpodProvider.notifier);
    final appState = ref.watch(modelRiverpodProvider);
    List<Map<String,dynamic>> resultlist =appState.songcontents!=null?
      searchFromSongs(query, appState.songcontents!):[];
    // var regString = RegExp(query, caseSensitive: false);

    if (resultlist.isNotEmpty){
      resultlist = sortSongResults(resultlist);
    }
    return Scrollbar(
      thickness: 15,
      radius: const Radius.circular(20),
      interactive: true,
      child: SearchResultBuilder(resultlist: resultlist),
    );
  }
}

class SearchResultBuilder extends ConsumerWidget {
  const SearchResultBuilder({
    super.key,
    required this.resultlist
  });

  final List<Map<String, dynamic>> resultlist;


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ListView.builder( 
      itemCount: resultlist.length, itemBuilder: (context, index) { 
        Map<String,dynamic>data = resultlist[index];
        return SearchResultCard(data: data); 
      }, 
    );
  }
}

class SearchResultCard extends ConsumerWidget {
  const SearchResultCard({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appStateN = ref.watch(modelRiverpodProvider.notifier);
    // final appState = ref.watch(modelRiverpodProvider);
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile( 
        title: Text(data['string']),
        subtitle: Text('On:${data['type']} Stanza: ${data['stanza']}'),
        onTap: () { 
          appStateN.setHighlighted(data);
          appStateN.setSongIndex(data['index']);
          Navigator.pop(context);
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

