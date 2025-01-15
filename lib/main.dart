// import 'dart:convert';
// import 'dart:io';
import 'package:punkantaan/riverpod_model.dart';
import 'dart:core';
// import 'song_model.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:punkantaan/song_model.dart';
class SearchResultView extends ConsumerWidget {
  const SearchResultView({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(riverpodProvider);
    List<Map<dynamic,dynamic>> resultlist =[];
    var regString = RegExp(query, caseSensitive: false);
    for (int i=0;i<appState.songcontents!.length;i++){
      SongModel content = appState.songcontents![i];
      Map<String,dynamic> results={};

      if (regString.hasMatch(content.title)){
        results['Title']=true;
      }
      if (content.chorus.isNotEmpty){
        List<int> chorusLines =[];
        content.chorus.asMap().entries.map((choline)=>{
          if (regString.hasMatch(choline.value)){
            chorusLines.add(choline.key)
          }
        }).toList();
        if (chorusLines.isNotEmpty){
          results['Chorus'] = true;
        }
      }
      if (content.stanza.isNotEmpty){
        List<int> stanzaLines =[];
        List<String> stanzaCombined =content.stanza.map((e) =>e.join(' '),).toList(); 
        stanzaCombined.asMap().entries.map((stanzaline)=>{
          if (regString.hasMatch(stanzaline.value)){
            stanzaLines.add(stanzaline.key+1)
          }
        }).toList();
        if (stanzaLines.isNotEmpty){
          results['Stanza'] = stanzaLines;
        }
      }
      if (results.isNotEmpty){
        results['index']=i;
        resultlist.add(results);
      }
    }
 
    return Scrollbar(
      thickness: 15,
      radius: const Radius.circular(20),
      interactive: true,
      child: ListView.builder( 
        itemCount: resultlist.length, itemBuilder: (context, index) { 
          Map<dynamic,dynamic>data = resultlist[index];
          bool title =data['Title']==null?false:true;
          bool chorus =data['Chorus']==null?false:true;
          dynamic stanza =data['Stanza'] ?? false;
          return ListTile( 
            title: Text(appState.songcontents![data['index']].title),
            subtitle: Text('On Title:$title On Chorus:$chorus On Stanza:$stanza'),
            onTap: () { 
              ref.watch(riverpodProvider)
                .setSongIndex(data['index']);
              Navigator.pop(context);
            }, 
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


void main() {
  runApp(const ProviderScope(child:MyApp()));

}
final riverpodProvider = ChangeNotifierProvider<RiverpodModel>((ref){
  return RiverpodModel();
}); 

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(riverpodProvider);
    appState.readJson();
    bool hasContents = appState.songcontents==null;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: hasContents?const CircularProgressIndicator():const MyHomePage()
    );
  }

}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});
  @override
  ConsumerState  createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override void dispose() {
    _scrollController.dispose(); 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(riverpodProvider);
    return  Scaffold(
      drawer:SizedBox(
          width: MediaQuery.of(context).size.width*.75,
          child: Scrollbar(
            // controller: _scrollController,
            thickness: 16,
            radius: const Radius.circular(10), // Rounded corners
            interactive: true,
            child: ListView(
              // padding: const EdgeInsets.all(8),
              children: [
                DrawerHeader( 
                  decoration: BoxDecoration( color: Theme.of(context).colorScheme.primaryContainer, ), 
                  child: Center(
                    child: Text( 
                      'Contents', 
                      style: TextStyle( 
                        color:  Theme.of(context).colorScheme.primary, fontSize: 24, 
                      ), 
                    ),
                  ), 
                ),
                ...appState.songcontents!.map((item){
                  int songIndex = appState.songcontents!.indexOf(item);
                  return Card(
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      title: Text(
                        '${songIndex+1} ${item.title}',
                        overflow:TextOverflow.fade,
                      ),
                      onTap:(){
                        _onItemTapped(ref,songIndex);
                      },
                      tileColor: Colors.white,
                      textColor: Colors.black,
                    // textColor: ,
                              ),
                  );
              }),
              ]
            ),
          ),
        ),
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text('Punkantaan'),
        actions: [
          IconButton(
            onPressed: ()async{
              showSearch(context: context, delegate:MySearchDelegant ());
            }, 
            icon: const Icon(Icons.search),
          )
        ],

      ),
      body:appState.songIndex!=null?SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height:(appState.titleFontSize*1.5)),
              TitleHeading(
                widget: widget, 
                songIndex: appState.songIndex, 
                titleFontSize: appState.titleFontSize, 
                bodyFontSize: appState.bodyFontSize
              ),
              SizedBox(height:appState.bodyFontSize*2),
              StanzaColumn(
                listStanza:appState.songcontents![appState.songIndex!].stanza[0], 
                bodyFontSize: appState.bodyFontSize
              ),
              if (appState.songcontents![appState.songIndex!].chorus.isNotEmpty)
              SizedBox(height: appState.bodyFontSize*2),
              if (appState.songcontents![appState.songIndex!].chorus.isNotEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: appState.songcontents![appState.songIndex!].chorus.map(
                  (item) {
                    return CenterText(
                      texts: item,
                      fontSize:appState.bodyFontSize,
                      color:Colors.red,
                    );
                  }
                ).toList(),
              ),
              SizedBox(height: appState.bodyFontSize*2),
              ...otherStanza(ref,appState.bodyFontSize*2)
            ],
          ),
        ),
      ):Container()
    );
  }
  void _onItemTapped(WidgetRef ref,int index) { 
      // print(widget.songcontents[index].stanza);
      // songIndex = index; 
      ref.read(riverpodProvider.notifier).setSongIndex(index);

    Navigator.pop(context);
  }
  List<Widget> otherStanza(WidgetRef ref,double height){
    List<List<Widget>>data =ref.watch(riverpodProvider)
      .songcontents![ref.watch(riverpodProvider).songIndex!]
      .stanza.sublist(1).map((item)
      {
        return [StanzaColumn(
          listStanza:item,
          bodyFontSize: ref.watch(riverpodProvider).bodyFontSize,),
          SizedBox(height: height,)
        ];
      }).toList();
    return data.expand((element)=>element).toList();
  }
}

class StanzaColumn extends StatelessWidget {
  const StanzaColumn({
    super.key,
    required this.bodyFontSize,
    required this.listStanza,
  });

  final double bodyFontSize;
  final List<String> listStanza;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: listStanza.map(
        (item) {return LeftAlignText(
          texts: item,
          fontSize:bodyFontSize,
          textcolor:Colors.black
        );}
      ).toList(),
    );
  }
}

class TitleHeading extends ConsumerWidget {
  const TitleHeading({
    super.key,
    required this.widget,
    required this.songIndex,
    required this.titleFontSize,
    required this.bodyFontSize,
  });

  final MyHomePage widget;
  final int? songIndex;
  final double titleFontSize;
  final double bodyFontSize;

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Column( 
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        CenterText(
          texts:"${ref.watch(riverpodProvider).songcontents![songIndex!].title} (${ref.watch(riverpodProvider).songcontents![songIndex!].old})", 
          fontSize: titleFontSize,
          color: Colors.black,
        ),
        CenterText(
          texts: 'Tune of:${ref.watch(riverpodProvider).songcontents![songIndex!].tune}', 
          fontSize: bodyFontSize,
          color: Colors.black,
        ),
        Row(
          children: [
            const Spacer(flex: 4,),
            CenterText(
              texts:'Key of ${ref.watch(riverpodProvider).songcontents![songIndex!].key.toUpperCase()}', 
              fontSize: bodyFontSize,
              color: Colors.black,
            ),
            const Spacer(flex: 1,),
            CenterText(
              texts:'Beat: ${ref.watch(riverpodProvider).songcontents![songIndex!].beat}', 
              color: Colors.black,
              fontSize: bodyFontSize,
            ),
            const Spacer(flex: 4,),
          ],
        ),
      ] 
    );
  }
}

class CenterText extends StatelessWidget {
  const CenterText({
    super.key,
    required this.texts,
    required this.fontSize,
    required this.color,
  });

  final String texts;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
        texts,
        style: TextStyle(fontSize:fontSize, color: color),
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
    );
  }
}
class LeftAlignText extends StatelessWidget {
  const LeftAlignText({
    super.key,
    required this.texts,
    required this.fontSize,
    required this.textcolor,
  });

  final String texts;
  final double fontSize;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
          texts,
          style: TextStyle(fontSize:fontSize,color: textcolor),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.left,
      ),
    );
  }
}