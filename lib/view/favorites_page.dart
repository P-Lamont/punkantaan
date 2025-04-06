import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/model/model_riverpod.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(modelRiverpodProvider);
    final appStateN = ref.watch(modelRiverpodProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Column(
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
    );
  }
}