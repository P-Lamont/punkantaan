import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/main.dart';
import 'package:punkantaan/search_page.dart';
import 'package:punkantaan/util.dart';

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


