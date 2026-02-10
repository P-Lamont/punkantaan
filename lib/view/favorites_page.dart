import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/model/model_riverpod.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  final ScrollController _scrollFav = ScrollController(
    keepScrollOffset: false
  );
  @override
  void dispose(){
    _scrollFav.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(modelRiverpodProvider);
    // final scroll = ScrollController();
    final appStateN = ref.watch(modelRiverpodProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Scrollbar(
        controller: _scrollFav,
        radius: const Radius.circular(10.0),
        thickness: 15.0,
        child: ListView(
          children:appState.favorites.map((e){
            return ListTile(
              title: Text("$e. ${appState.songcontents![e-1].title}"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: ()async{
                await appStateN.setSongIndex(e-1);
                if(context.mounted){
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}