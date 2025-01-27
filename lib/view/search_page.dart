import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/main.dart';
import 'package:punkantaan/controller/search_functions.dart';
import 'package:punkantaan/model/riverpod_model.dart';
// import 'package:punkantaan/riverpod_model.dart';
// final riverpodProvider = ChangeNotifierProvider<RiverpodModel>((ref){
//   return RiverpodModel();
// }); 

class SearchResultView extends ConsumerWidget {
  const SearchResultView({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(riverpodProvider);
    
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
      child: SearchResultBuilder(resultlist: resultlist, appState: appState),
    );
  }
}

class SearchResultBuilder extends StatelessWidget {
  const SearchResultBuilder({
    super.key,
    required this.resultlist,
    required this.appState,
  });

  final List<Map<String, dynamic>> resultlist;
  final RiverpodModel appState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( 
      itemCount: resultlist.length, itemBuilder: (context, index) { 
        Map<String,dynamic>data = resultlist[index];
        return SearchResultCard(data: data, appState: appState); 
      }, 
    );
  }
}

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.data,
    required this.appState,
  });

  final Map<String, dynamic> data;
  final RiverpodModel appState;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile( 
        title: Text(data['string']),
        subtitle: Text('On:${data['type']} Stanza: ${data['stanza']}'),
        onTap: () { 
          appState.setHighlighted(data);
          appState.setSongIndex(data['index']);
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

