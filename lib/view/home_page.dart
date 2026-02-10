import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/model/model_riverpod.dart';
import 'package:punkantaan/controller/bible.dart';
import 'package:punkantaan/view/search_page.dart';
import 'package:punkantaan/view/util.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});
  @override
  ConsumerState  createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController(
    keepScrollOffset: false
  );
  final ScrollController _scrollSec = ScrollController(
    keepScrollOffset: false
  );
  @override void dispose() {
    _scrollController.dispose(); 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final songcontents = ref.watch(modelRiverpodProvider.select((it)=>it.songcontents))??[];
    final songIndex = ref.watch(modelRiverpodProvider.select((it)=>it.songIndex));
    final appStateN = ref.watch(modelRiverpodProvider.notifier);
    // print('rebuild ${appState.favorites}');
    return  Scaffold(
      drawer:SizedBox(
          width: getDrawerSize(),
          child: Scrollbar(
            thumbVisibility:true,
            // trackVisibility: true,
            // controller: _scrollController,
            thickness: 16,
            radius: const Radius.circular(10), // Rounded corners
            interactive: true,
            child: ListView(
              padding: const EdgeInsets.all(0),
              // controller: _scrollController,
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
                ...songcontents.map((item){
                  int songIndex = songcontents.indexOf(item);
                  return Card(
                    margin: const EdgeInsets.all(0),
                    color: songIndex.isEven?Colors.white:Colors.white60,
                    child: ListTile(
                      title: Text(
                        '${songIndex+1} ${item.title}',
                        overflow:TextOverflow.fade,
                      ),
                      onTap:(){
                        appStateN.setSongIndex(songIndex);
                        Navigator.pop(context);
                        // _onItemTapped(ref,songIndex);
                      },
                      tileColor: songIndex.isEven?Colors.white:Colors.white60,
                      textColor: Colors.black
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
          // RecentsIcon(),
          BibleIcon(),
          FavoritesIcon(),
          SettingsIcon()
        ],
      ),
      body:songIndex!=null?GestureDetector(
        onHorizontalDragEnd: (details)=>slideDetails(details),
        // onHorizontalDragStart:(details)=>slideDetails(details) ,
        child:  SingleChildScrollView(
          controller: _scrollSec,
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: SongContentsColumn()
          ),
        ),
      ):Container()
    );
  }
  double getDrawerSize(){
    double screenWidth =MediaQuery.of(context).size.width;
    late double drawerSize;
    if (screenWidth>500){
      drawerSize = 350;
    }else{
      drawerSize =screenWidth*.75;
    }
    return drawerSize;
  }

  void slideDetails(DragEndDetails details){
    final appStateN = ref.watch(modelRiverpodProvider.notifier);
    final appState = ref.watch(modelRiverpodProvider);
    if (details.primaryVelocity! < 0) {
      int? newIndex;
      
      if(appState.songIndex!!=appState.songcontents!.length-1){
        newIndex = appState.songIndex!+1;
      }
      if (newIndex!=null){
        appStateN.setSongIndex(newIndex);
      }
    }
    if (details.primaryVelocity! > 0 ) {
      if (appState.songIndex!!=0){
        appStateN.setSongIndex(appState.songIndex!-1);
      }
    }
  }
}

class SongContentsColumn extends ConsumerWidget {
  const SongContentsColumn({super.key});

  @override
  Widget build( BuildContext context,WidgetRef ref) {
    final appState = ref.watch(modelRiverpodProvider);
    final appStateN = ref.watch(modelRiverpodProvider.notifier);
    return Column(
      children: [
        SizedBox(height:(appState.titleFontSize*1.5)),
        TitleHeading(
          songIndex: appState.songIndex, 
          titleFontSize: appState.titleFontSize, 
          bodyFontSize: appState.bodyFontSize
        ),
        TextButton.icon(
          icon:Icon(appState.favorites.contains(appState.songIndex!+1)?Icons.favorite:
          Icons.favorite_border),
          label: appState.favorites.contains(appState.songIndex!+1)?
            const Text('Remove from Favorites'):const Text('Add to Favorites'),
          onPressed:()async{
            bool isFavorite = appState.favorites.contains(appState.songIndex!+1);
            print(isFavorite);
            if (isFavorite){
              await appStateN.removeFavorites(appState.songIndex!+1);
            }else{
              await appStateN.addtoFavorites(appState.songIndex!+1);
            }
          },
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
        const ChorusColumn(),
        SizedBox(height: appState.bodyFontSize*2),
        ...otherStanza(appState.bodyFontSize*2,ref)
      ],
    );
  }
  List<Widget> otherStanza(double height,WidgetRef ref){
    final appState = ref.watch(modelRiverpodProvider);
    List<List<Widget>>data =appState
      .songcontents![appState.songIndex!]
      .stanza.sublist(1).asMap().entries.map((item)
      {
        return [
          StanzaColumn(
            listStanza:item.value,
            bodyFontSize: appState.bodyFontSize,
            stanza: item.key+2,
            highlightedLine: appState.highlighted?['line'],
            highlightedStanza: appState.highlighted?['stanza'],
            type:appState.highlighted?['type'],
            songIndex: appState.songIndex,
            highlightedIndex: appState.highlighted?['index'],
          ),
          SizedBox(height: height,)
        ];
      }).toList();
    return data.expand((element)=>element).toList();
  }
}
class ChorusColumn extends ConsumerWidget {
  const ChorusColumn({
    super.key
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(modelRiverpodProvider);
    return Column(
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
    );
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
        Navigator.pushNamed(
          context,'/settings'
         );
        }, 
    icon: const Icon(Icons.settings));
  }
}
class FavoritesIcon extends StatelessWidget {
  const FavoritesIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:()async{
        Navigator.pushNamed(
          context,'/fav'
         );
        }, 
    icon: const Icon(Icons.favorite));
  }
}
class RecentsIcon extends StatelessWidget {
  const RecentsIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:()async{
        Navigator.pushNamed(
          context,'/recents'
         );
        }, 
    icon: const Icon(Icons.history));
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
class BibleIcon extends ConsumerWidget {
  const BibleIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final bibleProviderN = ref.watch(bibleNotifierProvider.notifier);
    return IconButton(
      onPressed:()async{
        bibleProviderN.listBooks();
        Navigator.pushNamed(
          context,'/listbooks'
         );
        }, 
    icon: const Icon(Icons.book));
  }
}

