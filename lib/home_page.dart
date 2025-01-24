import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/main.dart';
import 'package:punkantaan/search_page.dart';
import 'package:punkantaan/settings_page.dart';
import 'package:punkantaan/util.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});
  @override
  ConsumerState  createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final ScrollController _scrollController = ScrollController(
    keepScrollOffset: false
  );

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
            thumbVisibility:true,
            // trackVisibility: true,
            controller: _scrollController,
            thickness: 16,
            radius: const Radius.circular(10), // Rounded corners
            interactive: true,
            child: ListView(
              padding: const EdgeInsets.all(0),
              controller: _scrollController,
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
                    margin: const EdgeInsets.all(0),
                    color: songIndex.isEven?Colors.white:Colors.white60,
                    child: ListTile(
                      title: Text(
                        '${songIndex+1} ${item.title}',
                        overflow:TextOverflow.fade,
                      ),
                      onTap:(){
                        _onItemTapped(ref,songIndex);
                      },
                      tileColor: songIndex.isEven?Colors.white:Colors.white60,
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
        actions:const [
          SearchIcon(),
          SettingsIcon()
        ],

      ),
      body:appState.songIndex!=null?GestureDetector(
        onTapDown: (TapDownDetails details) {
          final RenderBox box = context.findRenderObject() as RenderBox; 
          final position = box.globalToLocal(details.globalPosition);
          final screenWidth = MediaQuery.of(context).size.width;
          if (position.dx > screenWidth *(3/4)) {
            int? newIndex;
            
            if(appState.songIndex!!=appState.songcontents!.length-1){
              newIndex = appState.songIndex!+1;
            }
            if (newIndex!=null){
              appState.setSongIndex(newIndex);
            }
          }
          if (position.dx < screenWidth *(1/4)) {
            if (appState.songIndex!!=0){
              appState.setSongIndex(appState.songIndex!-1);
            }
          }
        },
        child: SingleChildScrollView(
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
                  bodyFontSize: appState.bodyFontSize,
                  stanza: 1,
                  highlightedLine: appState.highlighted?['line'],
                  highlightedStanza: appState.highlighted?['stanza'],
                  type:appState.highlighted?['type'],
                  songIndex: appState.songIndex,
                  highlightedIndex: appState.highlighted?['index'],
                ),
                if (appState.songcontents![appState.songIndex!].chorus.isNotEmpty)
                SizedBox(height: appState.bodyFontSize*2),
                if (appState.songcontents![appState.songIndex!].chorus.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: appState.songcontents![appState.songIndex!].chorus.asMap().entries.map(
                    (item) {
                      if(
                        appState.songIndex==appState.highlighted?['index']&&
                        appState.highlighted?['type']=='chorus' &&
                        appState.highlighted?['line']==item.key+1){
                        return CenterText(
                          texts: item.value,
                          fontSize:appState.bodyFontSize,
                          color:Colors.red,
                          backgroundColor: appState.highlightColor,
                        );                      
                      }
                      return CenterText(
                        texts: item.value,
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
    final riverpod = ref.watch(riverpodProvider);
    List<List<Widget>>data =riverpod
      .songcontents![riverpod.songIndex!]
      .stanza.sublist(1).asMap().entries.map((item)
      {
        return [
          StanzaColumn(
            listStanza:item.value,
            bodyFontSize: riverpod.bodyFontSize,
            stanza: item.key+2,
            highlightedLine: riverpod.highlighted?['line'],
            highlightedStanza: riverpod.highlighted?['stanza'],
            type:riverpod.highlighted?['type'],
            songIndex: riverpod.songIndex,
            highlightedIndex: riverpod.highlighted?['index'],
          ),
          SizedBox(height: height,)
        ];
      }).toList();
    return data.expand((element)=>element).toList();
  }
}

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:()async{
        Navigator.push(
          context,
         MaterialPageRoute(builder: (context) => const SettingsPage()),
         );
        }, 
    icon: const Icon(Icons.settings));
  }
}

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()async{
        showSearch(context: context, delegate:MySearchDelegant ());
      }, 
      icon: const Icon(Icons.search),
    );
  }
}


